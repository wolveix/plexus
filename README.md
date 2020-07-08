# Plexus
A suite of tools to help manage the media behind a Plex server.

## Docker
Rather than installing the dependencies and downloading Plexus locally, you can run the Plexus Docker image:
```shell
docker run -v $HOME/.config/plexus:/root/.config/plexus -v $HOME/.plexus:/root/.plexus -v /your/media/mount:/media wolveix/Plexus:latest 
```

## Install
### Automatic
You can automatically install Plexus by running the following line via a supported command line interface:
``` shell
curl https://plexus.wolveix.com/install.sh | sudo bash
```

If you don't have superuser priviledges or are using macOS, use this instead:
``` shell
curl https://plexus.wolveix.com/install.sh | bash
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

Install any missing dependencies (macOS):
``` shell
brew update && brew upgrade
brew install curl ffmpeg rsync
```

Create all of the temporary folders required:
``` shell
mkdir -p $HOME/.config/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
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

#### That's it!

Plexus natively supports RClone and a custom build of FFmpeg. You can install any dependencies via Plexus' built-in install function.

### Configuration

This is the default config file:
```
audio_codec="aac"
blacklist_file="$HOME/.plexus/blacklist"
convert_dir="$HOME/.plexus/encode/convert"
converted_dir="$HOME/.plexus/encode/converted"
deinterlacing="true"
ffmpeg_binary=""
ffmpeg_threads="2"
ffmpeg_preset="faster"
ffprobe_binary=""
force_overwrite="true"
fusermount_binary=""
hardware_acceleration="false"
hardware_codec="opencl"
list_file="$HOME/.plexus/list.txt"
media_container="mkv"
media_dir="/mnt/plexdrive"
mount_dir=""
rclone_binary=""
rsync_binary=""
video_codec="h264"
video_library="libx264"
```

Without changing any options, Plexus will create a list of your files that either don't use the MKV container, x264 video codec or the aac audio codec. You can then process this list by running the encode command which will move through the list and re-encode each file to fit the above three conditions.

Original files are replaced by default, but you can disable this by changing the `force_overwrite` value to `false`. You can edit the config file directly (`$HOME/.config/plexus/plexus.conf`) or you can use the built-in config function by running `plexus config`.

### Usage
This somewhat varies depending on whether you're planning on encoding local media or media contained on an [RClone remote](https://rclone.org/remote_setup/). Firstly, specify your ideal codecs via the `config` function.

#### Local Media
Run `plexus list -d /path/to/media` to start building a recursive list of your media which needs to be re-encoded.

Once the list function has finished its process, you can begin the encoding process by running `plexus encode -l /path/to/list`.

#### Remote Media
Run `plexus list -d /mount/path/path/to/media -m /mount/path` to start building a recursive list of your media which needs to be re-encoded.

Once the list function has finished its process, you can begin the encoding process by running `plexus encode -l /path/to/list -r RCloneRemote:`.

### Support
If you run into any issues, please [submit an issue via this repo](https://github.com/Wolveix/Plexus/issues/new?assignees=&labels=&template=bug_report.md&title=). If the issue occurs during the encode command, please run the command again with the `--verbose` flag so that we may have a better idea of what's happening.

## Credits
- Creator: [Robert Thomas](https://github.com/Wolveix)
- Help: [Greg Probst](https://github.com/gorgarp), [Mason Rowe](https://github.com/MasonR)
- License: [GNU General Public License v3.0](https://github.com/Wolveix/Plexus/blob/master/LICENSE)
