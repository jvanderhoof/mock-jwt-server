FROM ruby:alpine

RUN apk update && apk add --no-cache openssl

ENV RACK_ENV=production

WORKDIR /usr/src

COPY Gemfile Gemfile.lock config.ru jwt_server.rb ./

RUN bundle install

EXPOSE 8088/tcp
CMD bundle exec rackup -p 8088 -o 0.0.0.0
