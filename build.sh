for f in /mnt/plex-encode/*.*; do
    echo "Looking at: $f"
    audio_codec=$(mediainfo --Inform="Audio;%Format%" "$f")
    video_codec=$(mediainfo --Inform="Video;%Format%" "$f")

    if [ $audio_codec != "AAC" ]
    then
        echo "$f" >> /root/files.txt
    fi
done