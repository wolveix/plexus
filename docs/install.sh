#!/usr/bin/env bash
printf "\\e[93m=== Plexus v0.9.54 - Developed by Robert Thomas ==="
printf "\\n=== https://github.com/Wolveix/Plexus ===\\e[0m"
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
case $distro in
  '"CentOS Linux"')
    printf "\\n\\e[36mInstalling any missing dependencies.\\n\\e[94m"
    yum -q -y install epel-release
    yum -q -y update && yum -q -y upgrade
    yum -q -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
    yum -q -y install curl ffmpeg ffmpeg-devel progress
    ;;
  '"Debian GNU/Linux"' | '"Ubuntu"')
    printf "\\n\\e[36mInstalling any missing dependencies.\\n\\e[94m"
    apt-get -qq -y update && apt-get -qq -y upgrade
    apt-get -qq -y install curl ffmpeg progress
    ;;
  *)
    printf "\\nIt doesn't look like your distro is supported.\\nCreate an issue here: https://github.com/Wolveix/Plexus/issues/new\\n"
    exit
    ;;
esac
mkdir -p $HOME/.config/plexus /mnt/plexus $HOME/.plexus/encode/convert $HOME/.plexus/encode/converted $HOME/.plexus/rclone /tmp/plexus
cd /tmp/plexus || exit
if [ ! -f "$HOME/.config/plexus/plexus.conf" ]; then
  curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus.conf 2>/dev/null
  mv plexus.conf "$HOME"/.config/plexus/
fi
curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus 2>/dev/null
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
