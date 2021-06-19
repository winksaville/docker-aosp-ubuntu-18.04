# Create Docker image for building aosp

WIP, we'll see how it goes. One of the goals is to allow
this image to share users and groups between the host and
docker image. This is going to be specific to my host system
so do NOT use this image directly.

The list of requirements is from [here](https://source.android.com/setup/build/initializing#installing-required-packages-ubuntu-1804)

The goal here is that the uid, gid, groups and wheel id are
the same in both the docker image and host:
```
  wink@wink-desktop:~/prgs/docker/arch
  $ id
  uid=1000(wink) gid=100(users) groups=100(users),10(wheel),95(storage),98(power),150(wireshark),992(adbusers),995(docker)
  wink@wink-desktop:~/prgs/docker/arch (master)
  $ docker-compose run -rm -w `pwd` aosp
  wink@c0bffe16f256:~
  $ id
  uid=1000(wink) gid=100(users) groups=100(users),10(wheel)
```

# Repo
https://github.com/winksaville/aosp-ub-18.04.git

# Pull image
```bash
docker pull winksaville/aosp:ub-18.04
```

# Build image

```bash
docker build -t winksaville/aosp:ub-18.04 .
```

# Run image

The easy way to run the image is use docker-compose which
uses docker-compose.yml to set the volumes and the network
(runs in privileged mode so gdb can be used):
```bash
docker-compose run --rm -w `pwd` aosp
```

To manually run the image as the current user which is
equivalent to docker-compose above:
```bash
docker run --privileged --name aosp --user=$USER -v /home:/home -w `pwd` -v /etc/group:/etc/group:ro -v /etc/gshadow:/etc/gshadow:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /etc/sudoers:/etc/sudoers:ro --rm -it winksaville/aosp:ub-18.04
```

# Push to dockerhub

```bash
docker push winksaville/aosp:ub-18.04
```
