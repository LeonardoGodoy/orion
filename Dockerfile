FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev nodejs vim postgresql-client python-pip

ENV APP_HOME /server_orion
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# allows a shell script to run before any relative containers execute a command.
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# configures a new installation path for future bundler installs, and binstubs.
ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle

# Disable documentation when installing new gems. It decrease the amount of time to install a gem
RUN echo "gem: --no-document" > $APP_HOME/.gemrc

# allows bundler's binstubs to be executed without bundle exec (i.e. puma)
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Required version for bundler
RUN gem install bundler -v '2.0.1'
