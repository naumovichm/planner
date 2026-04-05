FROM ruby:3.4.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /planner
COPY Gemfile /planner/Gemfile
COPY Gemfile.lock /planner/Gemfile.lock
WORKDIR /planner
RUN bundle
EXPOSE 3000
CMD bin/rails db:create && bin/rails db:migrate && bin/rails s -b 0.0.0.0
