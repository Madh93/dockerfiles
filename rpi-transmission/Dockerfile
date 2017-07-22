FROM hypriot/rpi-alpine-scratch
MAINTAINER Miguel Hernandez "michelangelo93@gmail.com"

# Install transmission
RUN apk update \
    && apk add transmission-daemon bash vim \
    && rm -rf /var/cache/apk/*

# Copy custom settings
COPY settings.json /app/config/

# Add to 'users' group
RUN addgroup transmission users

# Set up directories and permissions
RUN chown -R transmission:users /app \
    && chmod g+s /app \
    && mkdir /app/completed /app/incomplete \
    && chmod -R 775 /app

# Continue as user 'transmission'
USER transmission

# Expose volumes:
VOLUME /app/completed /app/incomplete

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

CMD ["/usr/bin/transmission-daemon", "-f", "-g", "/app/config"]
