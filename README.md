# Plexus
A suite of tools to help manage the media behind a Plex server.

## Install

### Automatic
You can automatically install Plexus by running the following line via a supported command line interface:
``` bash
curl https://plexus.robt.me/install.sh | sudo bash
```

### Manual
Alternatively, you can manually install Plexus to a custom location on your device.
Install any missing dependencies and create all of the temporary folders required:
``` bash
sudo apt-get install curl ffmpeg unzip -y
mkdir -p /mnt/plexus /tmp/plexus/encode/convert /tmp/plexus/encode/converted /tmp/plexus/rclone $HOME/.config/plexus
```

Download the default config file and move it into the correct location:
``` bash
curl -O https://plexus.robt.me/versions/releases/latest/plexus.conf
mv plexus.conf "$HOME"/.config/plexus/
```

Next, download the executable itself:
``` bash
curl -O https://plexus.robt.me/versions/releases/latest/plexus
```

Finally, correct the file permissions and move it into your respective operating system's application directory. The following example is for Linux:
``` bash
chmod u+x plexus && chmod 755 plexus
sudo chown root:root plexus
sudo mv plexus /usr/bin/plexus
```

#### That's it!

The automated script checks for an RClone installation too as Plexus natively supports it. To install RClone:
``` bash
curl https://rclone.org/install.sh | sudo bash
```

## Credits
- Creator: Robert Thomas ([Wolveix](https://github.com/Wolveix))
- Original Scripts: Mason Rowe ([MasonR](https://github.com/MasonR))
- License: [GNU General Public License v3.0](https://github.com/Wolveix/Plexus/blob/master/LICENSE)
