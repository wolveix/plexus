#!/bin/bash
while read line; do
     #!/bin/bash
     PATH=${line%/*}
     FILE=${line##*/}
     NAME=${FILE%.*}
     echo "Downloading: " $FILE
     /usr/bin/rclone copy "GDrive:$line" /tmp/plex-encode/convert --stats-log-level NOTICE --stats 30s
     echo "File downloaded."
     video_codec=$(/usr/bin/mediainfo --Inform="Video;%Format%" "/tmp/plex-encode/convert/$FILE")
     if [ $video_codec == "AVC" ]
     then
         echo "Codec is x264"
         /usr/bin/ffmpeg -i "/tmp/convert/$FILE" -c:v copy -c:a aac -q:a 100 -preset veryfast -strict -2 -movflags faststart -threads 2 -loglevel quiet -stats "/tmp/convert/done/$NAME.mkv"
     else
         echo "Codec isn't x264"
         /usr/bin/ffmpeg -i "/tmp/convert/$FILE" -c:v libx264 -c:a aac -q:a 100 -preset veryfast -strict -2 -movflags faststart -threads 2 -loglevel quiet -stats "/tmp/convert/done/$NAME.mkv"
     fi
     echo "File successfully converted."
     /usr/bin/rclone delete "GDrive:$line" --stats-log-level NOTICE --stats 30s
     echo "Original file deleted from GDrive"
     /usr/bin/rclone move "/tmp/plex-encode/convert/done/$NAME.mkv" "GDrive:$PATH" --stats-log-level NOTICE --stats 30s
     echo "File successfully uploaded."
     /bin/rm "/tmp/plex-encode/convert/$FILE"
     /bin/grep -v "$line" /root/plex-encode/list.txt > /tmp/plex-encode/list.txt; /bin/mv /tmp/plex-encode/list.txt /root/plex-encode/list.txt
done < /root/plex-encode/list.txt