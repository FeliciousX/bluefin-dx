#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Security research layer (small, stable, fine on host)
dnf5 install -y \
    tmux \
    nmap wireshark-cli tcpdump \
    aircrack-ng \
    whois traceroute

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Ghostty terminal — see https://ghostty.org/docs/install/binary#fedora
# Fedora packages are community builds (not official Ghostty binaries);
# accept the third-party-binary risk or build from source instead.
dnf5 copr enable -y scottames/ghostty
dnf5 install -y ghostty

# Bake the dracut fido2 module via usr/etc/
dnf5 install -y libfido2 systemd-udev

#### Example for enabling a System Unit File

systemctl enable podman.socket
