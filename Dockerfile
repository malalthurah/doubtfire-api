FROM ruby:2.0.0

RUN apt-get update
RUN apt-get install -y \
  build-essential \
  libpq-dev imagemagick \
  libmagickwand-dev \
  libmagic-dev \
  pdftk \
  libpq-dev \
  python-pygments

ENV RAILS_ENV docker

ADD . /doubtfire-api
WORKDIR /doubtfire-api

EXPOSE 3000

RUN bundle update
RUN bundle install --without production test replica
RUN rake db:create db:populate[extend_populate]
