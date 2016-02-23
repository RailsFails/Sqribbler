FROM ruby:2.2.0

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev libssl-dev libreadline-dev wget vim
RUN apt-get install -y imagemagick libmagick++-dev libmagic-dev && apt-get clean

RUN mkdir /myapp
ADD . /myapp
WORKDIR /myapp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

ENV RAILS_ENV production
ENV RACK_ENV production

EXPOSE 3000
EXPOSE 80

RUN bundle install

RUN bundle exec rake assets:precompile
VOLUME /app/public

CMD ["rails","server","-b","0.0.0.0"]