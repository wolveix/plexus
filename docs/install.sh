#!/usr/bin/env bash
printf "\\e[93m=== Plexus v0.9.41 - Developed by Robert Thomas ==="
printf "\\n=== https://github.com/Wolveix/Plexus ===\\e[0m"
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
case $distro in
  '"CentOS Linux"')
    packages="yum -q -y"
    ;;
  '"Debian GNU/Linux"' | '"Ubuntu"')
    packages="apt-get -qq -y"
    ;;
  *)
    printf "\\nIt doesn't look like your distro is supported.\\nCreate an issue here: https://github.com/Wolveix/Plexus/issues/new\\n"
    exit
    ;;
esac
printf "\\n\\e[36mInstalling any missing dependencies.\\n\\e[94m"
$packages update && $packages upgrade
$packages install curl ffmpeg sudo > /dev/null
mkdir -p $HOME/.config/plexus /mnt/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
cd /tmp/plexus || exit
if [ ! -f "$HOME/.config/plexus/plexus.conf" ]; then
  curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus.conf 2>/dev/null
  mv plexus.conf "$HOME"/.config/plexus/
fi
if [ ! -z "$1" ] && [ "$1" == "dev" ]; then
  curl -O https://raw.githubusercontent.com/Wolveix/Plexus/dev/plexus 2>/dev/null
else
  curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus 2>/dev/null
fi
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
