# Plex Encode
This script will create a list of media from your Plex server that needs to be re-encoded.

## Install

First, install required dependencies:
``` bash
sudo apt-get install ffmpeg mediainfo -y
```
Then, create the required directories:
``` bash
sudo mkdir /root/plex-encode /tmp/plex-encode /tmp/plex-encode/convert /tmp/plex-encode/converted
```
Next, run the build-list.sh script