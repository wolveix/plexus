#!/usr/bin/env bash
printf "\\n\\e[93m=== Plexus v0.7.3d - Developed by Robert Thomas ==="
printf "\\n=== https://github.com/Wolveix/plexus ==="
printf "\\n\\e[32mInstalling missing dependencies.\\n\\n\\e[94m"
apt-get install curl ffmpeg unzip -y
printf "\\n\\e[32mCreating directories if they don't already exist.\\n\\e[94m"
mkdir -p /mnt/plexus /tmp/plexus/encode/convert /tmp/plexus/encode/converted /tmp/plexus/rclone $HOME/.config/plexus
rclone_version=$(rclone -V)
if [[ "$rclone_version" != *"os/arch: "* ]]; then printf "\\n\\e[32mInstalling RClone.\\n\\n\\e[94m"; curl https://rclone.org/install.sh | sudo bash; printf "\\e[32mRClone installed.\\n"; fi
rclone_remotes=$(rclone listremotes)
if [ -z "$rclone_remotes" ]; then printf "\\n\\e[32mYou don't have any RClone remotes setup. Set one up by running 'rclone config'\\n\\n\\e[94m"; fi
cd /tmp/plexus || exit
curl -O https://plexus.robt.me/versions/releases/latest/plexus.conf
mv plexus.conf "$HOME"/.config/plexus/
curl -O https://plexus.robt.me/versions/releases/latest/plexus
chmod u+x plexus

OS="$(uname)"
case ${OS,,} in
  'linux')
    chmod 755 plexus
    chown root:root plexus
    mv plexus /usr/bin/plexus
    ;;
  'freebsd' | 'openbsd' | 'netbsd')
    chown root:wheel plexus
    mv plexus /usr/bin/plexus
    ;;
  'darwin' | 'osx')
    mkdir -p /usr/local/bin
    mv plexus /usr/local/bin/plexus
    ;;
  *)
    mv plexus /usr/local/bin/plexus
    ;;
esac

printf "\\n\\e[32mInstall completed!\\n"
printf "\\nPlease run 'plexus help' to see a list of available commands.\\n\\e[0m"
