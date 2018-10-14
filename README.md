# AION Network development environment for Mac OS

Currently AION Network build/development is only supported on Ubuntu 16.04 LTS. So it is required to configure a development environment for Mac OS using a docker container for compilation, build & deployment.

## Instructions

1. Pull AION Network repo and checkout to the `master-pre-merge` branch

```bash
$ git pull --recursive https://github.com/aionnetwork/aion
$ cd aion
$ git checkout master-pre-merge
git submodule update --init —recursive
```

1. Start docker container for compilation: (**TODO**: include environment variabled setup)

```bash
$ cd docker-aion-dev
$ docker-compose up -d
```

1. Run a bash terminal on the container you started/run in the previous step

```bash
$ docker run <CONTAINER_ID> bash
```

1. Compile AION project

```bash
$ cd /aion
$ ./gradlew build pack -x test -Dcompile.debug=true
```

1. Locally, start AION Network node using docker-compose

```bash
$ cd aion
$ docker-compose -f supporting-services.yml up
```