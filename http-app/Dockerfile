# Set base image
FROM ruby:3.0.1

# Set Dockerfile variables
ARG BUNDLER_VERSION=2.2.23 \
    USER=bookstore_user

# Set environment variables
ENV BUNDLER_VERSION=${BUNDLER_VERSION}

# Expose port numbers
EXPOSE 3000

# Update apt packages
RUN apt-get update -qq \
    && apt-get install -y sudo

# Create user
RUN adduser --uid 1200 \
    --home /home/${USER} \
    --disabled-password \
    --gecos '' \
    ${USER}

# Add user to sudo group
RUN adduser ${USER} sudo \
    && sudo whoami \
    && sudo ls /home

# Set user to execute any command without password
COPY sudoers.txt /etc/sudoers
RUN chmod 440 /etc/sudoers \
    && cat /etc/sudoers

# Set user
USER ${USER}

# Set working directory
WORKDIR /app

# Install dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update \
    && sudo apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs\
    yarn

# Install bundler
RUN gem install bundler -v ${BUNDLER_VERSION}

# Copy Gemfile and bundle install
COPY Gemfile Gemfile.lock ./
RUN sudo chmod 777 Gemfile Gemfile.lock
RUN bundle config set --local without 'development test'
RUN bundle install

# Copy package file and yarn install
COPY package.json yarn.lock ./
RUN sudo chmod 777 package.json yarn.lock
RUN sudo chmod 777 -R /app;
RUN yarn install

# Copy other project files
COPY . ./
