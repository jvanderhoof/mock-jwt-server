# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

require './jwt_server'
run JwtServer
