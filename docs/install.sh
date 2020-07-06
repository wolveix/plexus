#!/usr/bin/env bash
printf "\\e[93m=== Plexus v0.9.73 - Developed by Robert Thomas ==="
printf "\\n=== https://github.com/Wolveix/Plexus ===\\e[0m"
OS=$(uname)
case "$OS" in
    'FreeBSD' | 'Linux' | 'NetBSD' | 'OpenBSD')
        if [ ! -f "/etc/os-release" ]; then
            printf "\\nIt doesn't look like your distro is supported.\\nCreate an issue here: https://github.com/Wolveix/Plexus/issues/new\\n"
            exit
        else
            distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
        fi
        ;;
    'Darwin')
        distro='macOS'
        ;;
    *)
        printf "\\nIt doesn't look like your distro is supported.\\nCreate an issue here: https://github.com/Wolveix/Plexus/issues/new\\n"
        exit
        ;;
esac
case $distro in
    '"Alpine Linux"')
        printf "\\n\\e[36mInstalling any missing dependencies...\\n\\e[94m"
        apk add curl ffmpeg rsync
        ;;
    '"Arch Linux"' | '"ArcoLinuxD"' | '"Manjaro Linux"')
        printf "\\n\\e[36mInstalling any missing dependencies...\\n\\e[94m"
        pacman -Syu
        pacman -S curl ffmpeg rsync
        ;;
    '"CentOS Linux"')
        printf "\\n\\e[36mInstalling any missing dependencies...\\n\\e[94m"
        if [ "$(rpm --eval '%{centos_ver}')" -eq "8" ]; then
            dnf -q -y install epel-release dnf-utils
            yum-config-manager --set-enabled PowerTools
            yum-config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
            dnf -q -y install curl ffmpeg rsync
        else
            yum -q -y install epel-release
            yum -q -y update && yum -q -y upgrade
            yum -q -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
            yum -q -y install curl ffmpeg ffmpeg-devel rsync
        fi
        ;;
    '"Debian GNU/Linux"' | '"Linux Mint"' | '"Raspbian GNU/Linux"' | '"Ubuntu"')
        printf "\\n\\e[36mInstalling any missing dependencies...\\n\\e[94m"
        apt-get -qq -y update && apt-get -qq -y upgrade
        apt-get -qq -y install curl ffmpeg rsync
        ;;
    'Fedora')
        printf "\\n\\e[36mInstalling any missing dependencies...\\n\\e[94m"
        dnf -q -y install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
        dnf -q -y install "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
        dnf -q -y install curl ffmpeg ffmpeg-devel
        ;;
    'macOS')
        if [ ! $(command -v brew) ]; then
            printf "\\nIt doesn't look like you have brew installed.\\nFind out more here: https://brew.sh/.\\n"
            exit
        else
            brew_binary=$(command -v brew)
        fi
        printf "\\n\\e[36mInstalling any missing dependencies.\\n\\e[94m"
        "$brew_binary" update && "$brew_binary" upgrade
        "$brew_binary" install curl ffmpeg rsync
        ;;
    *)
        printf "\\nIt doesn't look like your distro is supported.\\nCreate an issue here: https://github.com/Wolveix/Plexus/issues/new\\n"
        exit
        ;;
esac
mkdir -p "$HOME/.config/plexus" "$HOME/.plexus/encode/convert" "$HOME/.plexus/encode/converted" "$HOME/.plexus/rclone" "/tmp/plexus"
touch "$HOME/.config/plexus/blacklist"
cd /tmp/plexus || exit
if [ ! -f "$HOME/.config/plexus/plexus.conf" ]; then
    curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus.conf 2>/dev/null
    mv plexus.conf "$HOME"/.config/plexus/
fi
curl -O https://raw.githubusercontent.com/Wolveix/Plexus/master/plexus 2>/dev/null
chmod u+x plexus

case "$OS" in
    'Linux')
        chmod 755 plexus
        chown root:root plexus
        mv plexus /usr/bin/plexus
        ;;
    'FreeBSD' | 'OpenBSD' | 'NetBSD')
        chown root:wheel plexus
        mv plexus /usr/bin/plexus
        ;;
    'Darwin' | 'OSX')
        mkdir -p /usr/local/bin
        mv plexus /usr/local/bin/plexus
        ;;
    *)
        mv plexus /usr/local/bin/plexus
        ;;
esac
printf "\\n\\e[32mInstall completed!\\n"
printf "\\nPlease run 'plexus help' to see a list of available commands.\\n\\e[0m"
