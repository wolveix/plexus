# Plexus
A suite of tools to help manage the media behind a Plex server.

## Install

### Automatic
You can automatically install Plexus by running the following line via a supported command line interface:
``` shell
curl https://plexus.robt.me/install.sh | sudo bash
```

### Manual
Alternatively, you can manually install Plexus to a custom location on your device.
Install any missing dependencies and create all of the temporary folders required:
``` shell
sudo apt-get install curl ffmpeg unzip -y
mkdir -p $HOME/.config/plexus /mnt/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
```

Download the default config file and move it into the correct location:
``` shell
curl -O https://plexus.robt.me/versions/releases/latest/plexus.conf
mv plexus.conf "$HOME"/.config/plexus/
```

Next, download the executable itself:
``` shell
curl -O https://plexus.robt.me/versions/releases/latest/plexus
```

Finally, correct the file permissions and move it into your respective operating system's application directory. The following example is for Linux:
``` shell
chmod u+x plexus && chmod 755 plexus
sudo chown root:root plexus
sudo mv plexus /usr/bin/plexus
```

#### That's it!

Plexus natively supports RClone and a custom build of FFmpeg. You can install any dependencies via Plexus' built-in install function.

## Credits
- Creator: Robert Thomas ([Wolveix](https://github.com/Wolveix))
- Help: Mason Rowe ([MasonR](https://github.com/MasonR))
- License: [GNU General Public License v3.0](https://github.com/Wolveix/Plexus/blob/master/LICENSE)
