FROM ruby:alpine

RUN apk update && apk add --no-cache openssl

WORKDIR /usr/src

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY config.ru jwt_server.rb ./

EXPOSE 8088/tcp
CMD bundle exec rackup -p 8088 -o 0.0.0.0
