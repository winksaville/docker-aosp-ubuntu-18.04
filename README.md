# Create Docker image for building aosp (UNTESTED)

The list of requirements is from [here](sudo apt-get install curl git unzip)
all that is needed is "curl git zip" I added a few others. So the list
currently is: "curl git zip bsdmainutils tree vim sudo gnupg" as of this
writing. Check the Dockerfile for the "latest".

Another of my goals was to allow this image to share users
and groups between the host and docker image. This is going
to be specific to my host system so do NOT use this image directly.

To accomplish this the gids and uids must match and I've
create docker volumes to map the same file in both systems.
The result is:
```
wink@3900x:~/prgs/docker/aosp-ubuntu-18.04
$ id
uid=1000(wink) gid=985(users) groups=985(users),5(tty),98(power),150(wireshark),973(docker),987(uucp),988(storage),992(kvm),998(wheel),1001(sudo)
wink@3900x:~/prgs/docker/aosp-ubuntu-18.04
$ docker-compose run --rm -w `pwd` aosp
Creating aosp-ubuntu-1804_aosp_run ... done
wink@c53cec2288a6:~/prgs/docker/aosp-ubuntu-18.04
$ id
uid=1000(wink) gid=985(users) groups=985(users),1001(sudo)
```

## Repo

## Pull image from dockerhub (TBD not on docker hub)
```bash
docker pull winksaville/aosp:ub-18.04
```

## Build image locally

Clone the repo
```
git clone https://github/winksaville/docker-aosp-ubuntu-18.04.git aosp-ubuntu-18.04
```

```bash
cd aosp-ubuntu-18.04
docker build -t winksaville/aosp:ub-18.04 .
```

## Run image

The easy way to run the image is use docker-compose which
uses docker-compose.yml to set the volumes and the network
```bash
docker-compose run --rm -w `pwd` aosp
```

To manually run the image as the current user which is
equivalent to docker-compose above:
```bash
docker run --name aosp --user=$USER -v /home:/home -w `pwd` -v /etc/group:/etc/group:ro -v /etc/gshadow:/etc/gshadow:ro -v /etc/passwd:/etc/passwd:ro -v /etc/shadow:/etc/shadow:ro -v /etc/sudoers:/etc/sudoers:ro -v /etc/sudoers.d:/etc/sudoers.d:ro --rm -it winksaville/aosp:ub-18.04
```

## Push to dockerhub (TBD not on docker hub)
```bash
docker push winksaville/aosp:ub-18.04
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
