FROM jrottenberg/ffmpeg:4.1-alpine

RUN apk --no-cache add bash curl rsync unzip

COPY plexus /usr/bin/plexus

RUN chmod u+x /usr/bin/plexus

RUN curl https://rclone.org/install.sh | bash

WORKDIR /root/.config/plexus

ENTRYPOINT [ "plexus" ]
