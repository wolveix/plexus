#!/usr/bin/env bash
printf "\\e[93m=== Plexus v0.8.2 - Developed by Robert Thomas ==="
printf "\\n=== https://github.com/Wolveix/Plexus ==="
printf "\\n\\e[36mInstalling any missing dependencies.\\n\\e[94m"
apt-get install curl ffmpeg -y -qq
printf "\\n\\e[36mCreating directories if they don't already exist.\\n\\e[94m"
mkdir -p $HOME/.config/plexus /mnt/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
cd /tmp/plexus || exit
if [[ -f "$HOME/.config/plexus/plexus.conf" ]]
then
  curl -O https://plexus.robt.me/versions/releases/latest/plexus.conf 2>/dev/null
  mv plexus.conf "$HOME"/.config/plexus/
fi
curl -O https://plexus.robt.me/versions/releases/latest/plexus 2>/dev/null
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
