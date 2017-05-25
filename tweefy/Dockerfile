FROM ruby:2.3
MAINTAINER Miguel Hernandez "michelangelo93@gmail.com"

# Run container
WORKDIR /app

COPY start.rb Gemfile secrets.yaml /app/

# Install dependencies
RUN bundle install

CMD ["start.rb"]
ENTRYPOINT ["ruby"]
