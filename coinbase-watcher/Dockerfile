FROM ruby:2.4-alpine
MAINTAINER Miguel Hernandez "michelangelo93@gmail.com"

# Run container
WORKDIR /app

COPY start.rb Gemfile secrets.yaml /app/
RUN mkdir /app/db

# Install dependencies
RUN apk update \
  && apk add build-base sqlite-dev \
  && rm -rf /var/cache/apk/*

RUN bundle install

# Expose volume
VOLUME /app/db

CMD ["start.rb"]
ENTRYPOINT ["ruby"]
