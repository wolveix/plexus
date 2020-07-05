FROM jrottenberg/ffmpeg:4.1-alpine

COPY plexus /usr/bin/plexus

RUN chmod u+x /usr/bin/plexus

RUN apk update && \
    apk add bash curl rsync unzip

RUN curl https://rclone.org/install.sh | bash

RUN mkdir -p /config /root/.config/plexus && \
    cp -rl /root/.config/plexus /config

WORKDIR /config

ENTRYPOINT [ "plexus" ]