# Plexus
A suite of tools to help manage the media behind a Plex server.

## Install
### Automatic
You can automatically install Plexus by running the following line via a supported command line interface:
``` shell
curl https://plexus.robt.me/install.sh | sudo bash
```

### Manual
Alternatively, you can manually install Plexus to a custom location on your device. You should install sudo if it doesn't already exist on your system.
Install any missing dependencies (Debian/Ubuntu):
``` shell
sudo apt-get -qq -y update && sudo apt-get -qq -y upgrade
sudo apt-get -qq -y install curl ffmpeg rsync
```

Install any missing dependencies (CentOS/Rhel):
``` shell
sudo yum -q -y install epel-release
sudo yum -q -y update && sudo yum -q -y upgrade
sudo yum -q -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
sudo yum -q -y install curl ffmpeg ffmpeg-devel rsync
```

Create all of the temporary folders required:
``` shell
mkdir -p $HOME/.config/plexus /mnt/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
```

Download the default config file and move it into the correct location:
``` shell
curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus.conf
mv plexus.conf "$HOME"/.config/plexus/
```

Next, download the executable itself:
``` shell
curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus
```

Finally, correct the file permissions and move it into your respective operating system's application directory. The following example is for Linux:
``` shell
chmod u+x plexus && chmod 755 plexus
sudo chown root:root plexus
sudo mv plexus /usr/bin/plexus
```

### Default Configuration
By default the config file is as shown below.
```
audio_codec="aac"
convert_dir="$HOME/.plexus/encode/convert"
converted_dir="$HOME/.plexus/encode/converted"
ffmpeg_binary=""
ffmpeg_threads="2"
ffmpeg_preset="faster"
ffprobe_binary=""
force_overwrite="true"
fusermount_binary=""
list_file="$HOME/.plexus/list.txt"
media_container="mkv"
media_dir="/mnt/plexdrive"
mount_dir=""
rclone_binary=""
rsync_binary=""
video_codec="h264"
video_library="libx264"
```
To change any values, either edit the file directly or run:
```
sudo plexus config
```




#### That's it!

Plexus natively supports RClone and a custom build of FFmpeg. You can install any dependencies via Plexus' built-in install function.

## Credits
- Creator: Robert Thomas ([Wolveix](https://github.com/Wolveix))
- Help: Mason Rowe ([MasonR](https://github.com/MasonR))
- License: [GNU General Public License v3.0](https://github.com/Wolveix/Plexus/blob/master/LICENSE)
