# This is an Ubuntu 18.08 docker image for aosp.
#
# I added user wink, uid=1000, and changed the default group id (gid)
# of users, gid=100 and wheel, gid=10, so it matches the gids of my
# Arch Linux host. This allows me, wink, to create new the files in
# my home directory and the user will be 'wink' and group will be 'users'.
#
# To get this functionality I need to execute docker run with a bunch
# of volume mappings using -v for home, group, gshadow, passwd, shadow and
# sudoers. The '-w `pwd`' will set the current directory as the initial
# directory. The complete command line is:
#   $ docker run --name aosp --user=$USER -v /home:/home -w `pwd` -v /etc/group:/etc/group:ro -v /etc/gshadow:/etc/gshadow:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d:/etc/sudoers.d:ro --rm -it winksaville/aosp:ub-18.04
#
# Or try:
#   $ docker-compose run --rm -w `pwd` aosp

FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  git-core \
  gnupg \
  flex \
  bison \
  build-essential \
  zip \
  curl \
  zlib1g-dev \
  gcc-multilib \
  g++-multilib \
  libc6-dev-i386 \
  lib32ncurses5-dev \
  x11proto-core-dev \
  libx11-dev \
  lib32z1-dev \
  libgl1-mesa-dev \
  libxml2-utils \
  xsltproc \
  unzip \
  vim \
  fontconfig


RUN \
 groupmod -g 985 users &&\
 groupmod -g 1001 sudo &&\
 useradd -ms /bin/bash -d /home/wink -g users -u 1000 wink &&\
 usermod -aG sudo wink

 #echo 'wink:password' | chpasswd


# RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

#ENV LC_ALL en_US,UTF-8
#ENV LANG en_US,UTF-8
#ENV LANGUAGE en_US,UTF8

# Login as user wink
USER wink
WORKDIR /home/wink
