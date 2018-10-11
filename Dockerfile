ARG USER=chenhan
ARG UID=1000
ARG GID=1000

FROM ubuntu:16.04
LABEL Chen-Han Hsiao (Stanley) "chenhan.hsiao.tw@gmail.com"

USER root

# For development, do not exclude man pages & other documentation
RUN rm -f /etc/dpkg/dpkg.cfg.d/excludes

# Install common used utils (from education-common meta-package)
RUN apt-get update && \
    apt-get install -y apt-listchanges bash-completion bc bind9-host cfengine2 cifs-utils command-not-found convmv cups cups-browsed debconf-utils debian-archive-keyring deborphan dhcping dmidecode eject etherwake ethtool finger foomatic-db foomatic-db-engine fping gdb hddtemp hdparm hpijs-ppds hplip htop hwinfo iftop iotop iproute2 less libnss-myhostname libpam-tmpdir libwww-perl lshw lsscsi man-db manpages mc memtest86+ mlocate mtools mtr ncftp nictools-pci nmap nullidentd openbsd-inetd openssh-client pciutils printer-driver-hpijs printer-driver-pnm2ppa procinfo psmisc python-gtk2 python-vte reportbug rsync rsyslog screen strace sysfsutils tcpdump tcptraceroute traceroute unattended-upgrades valgrind vim wget && \
    rm -rf /var/lib/apt/lists/*

# Install utils
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y dbus-x11 debian-goodies gtk-recordmydesktop htop iputils-ping ipython ipython3 jq \
    keychain less meld moreutils openbox packaging-dev psmisc python-pip python-pudb python3-pip python3-pudb \
    screen silversearcher-ag sudo tig tmux tree vim virtualenv x11-apps x11-xserver-utils xcompmgr x11vnc xvfb zsh && \
    pip3 install pycodestyle && \
    pip3 install yapf && \
    pip install scipy scikit-learn && \
    rm -rf /var/lib/apt/lists/*

# Add custom user
ARG USER
ARG UID
ARG GID
RUN apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m $USER && \
    echo "$USER:$USER" | chpasswd && \
    usermod --shell /usr/bin/zsh $USER && \
    usermod -aG sudo $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER && \
    usermod  --uid $UID $USER && \
    groupmod --gid $GID $USER

USER $USER

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

