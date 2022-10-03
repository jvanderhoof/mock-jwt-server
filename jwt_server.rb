# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'jwt'
require 'openssl'
require 'net/http'
require 'securerandom'

# Simple intrface for testing services which use JWT
class JwtServer < Sinatra::Base
  before do
    content_type 'application/json'
  end

  get '/jwks_empty' do
    JSON.pretty_generate(keys: [])
  end

  get '/jwks' do
    JSON.pretty_generate(keys: [{ alg: 'RS256' }.merge(key.export)])
  end

  get '/info' do
    JSON.pretty_generate(default_values)
  end

  post '/verify' do
    token = JSON.parse(request.body.read.to_s)['token']
    begin
      JSON.pretty_generate(
        JWT.decode(
          token,
          nil,
          true, # Verify the signature of this token
          algorithms: ['RS256'],
          iss: default_values['iss'],
          verify_iss: true,
          aud: default_values['aud'],
          verify_aud: true,
          jwks: fetch_jwks
        )
      )
    rescue Exception => e
      status(400)
      body(JSON.pretty_generate(error: e))
    end
  end

  post '/generate' do
    body = request.body.read.to_s
    requested_claims = body.empty? ? {} : JSON.parse(body)
    JWT.encode(claims.merge(requested_claims), key.keypair, 'RS256', { kid: key.kid })
  end

  private

  def key
    @key ||= JWT::JWK::RSA.new(private_key)
  end

  def private_key
    @private_key ||= begin
      unless File.exist?('private_key.pem')
        File.open('private_key.pem', 'w') do |file|
          file.write(OpenSSL::PKey::RSA.generate(2048))
        end
      end
      OpenSSL::PKey::RSA.new(File.read('private_key.pem'))
    end
  end

  def default_values
    {
      iss: ENV.fetch('ISSUER', 'jwt.conjur.cyberark.com'),
      aud: ENV.fetch('AUDIENCE', '238d4793-70de-4183-9707-48ed8ecd19d9'),
      sub: ENV.fetch('SUBJECT', '19016b73-3ffa-4b26-80d8-aa9287738677')
    }
  end

  def claims(custom: {})
    # allow tokens to be valid for one hour
    current_time = Time.now.to_i
    default_values.merge(
      {
        'exp': current_time + 3600,
        'iat': current_time
      }
    ).merge(custom)
  end

  def fetch_jwks
    response = Net::HTTP.get_response(URI('http://localhost:8088/jwks'))
    if response.code.to_i == 200
      JSON.parse(response.body.to_s)
    else
      {}
    end
  end
end
