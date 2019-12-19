FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# RUN gem install bundler && bundle install --jobs 20 --retry 5
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]