FROM ubuntu:18.04
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
    apt-get install -y htop iputils-ping ipython ipython3 jq \
    keychain less meld moreutils psmisc python-pip python-pudb python3-pip python3-pudb \
    screen silversearcher-ag sudo tig tmux tree vim virtualenv x11-apps x11-xserver-utils zsh && \
    apt-get install -y python-wstool python-rosdep ninja-build && \
    apt-get install -y libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev && \
    apt-get install -y gfortran liblua5.2-dev python-sphinx && \
    apt-get install -y build-essential zlib1g-dev && \
    apt-get install -y clang-format && \
    pip3 install pycodestyle && \
    pip3 install yapf && \
    pip install scipy scikit-learn && \
    rm -rf /var/lib/apt/lists/*

# Add VS code
# The download link is from https://code.visualstudio.com/updates
RUN wget https://vscode-update.azurewebsites.net/1.28.0/linux-deb-x64/stable -O code_amd64.deb && \
    dpkg -i --force-depends code_amd64.deb && \
    rm code_amd64.deb && \
    apt-get update && \
    apt-get install -y -f && \
    rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

