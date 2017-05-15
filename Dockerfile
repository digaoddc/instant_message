FROM ruby:2.3.3

RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /var/www/instant_message
WORKDIR /var/www/instant_message

ADD Gemfile /var/www/instant_message
ADD Gemfile.lock /var/www/instant_message

RUN bundle install
