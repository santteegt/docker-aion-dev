# AION Network development environment for Mac OS

Currently AION Network build/development is only supported on Ubuntu 16.04 LTS. So it is required to configure a development environment for Mac OS using a docker container for compilation, build & deployment.

## Instructions

* Pull AION Network repo and checkout to the `master-pre-merge` branch:

```bash
$ cd docker-aion-dev
$ git pull --recursive https://github.com/aionnetwork/aion
$ cd aion
$ git checkout master-pre-merge
git submodule update --init
```

* Start docker container for compilation: (**TODO**: include environment variabled setup):

```bash
$ cd ..
$ docker-compose up -d
```

* Run a bash terminal on the container you started/run in the previous step:

```bash
$ docker run <CONTAINER_ID> bash
```

* Using the docker container compile the AION project:

```bash
$ cd /aion
$ ./gradlew build pack -x test -Dcompile.debug=true
```

* Now locally, copy the files `override-config.py` and `supporting-services.yml` to the `aion` folder:

```bash
$ cp override-config.py aion/override-config.py
$ cp supporting-services.yml aion/supporting-services.yml
```

If you want to override/change value of other config variables, modify this files accordingly.

* Start AION Network node using docker-compose:

```bash
$ cd aion
$ docker-compose -f supporting-services.yml up
```

* Node will startup and wait for a connection to the `6006` port for debugging. Import `aion` repo on IntelliJ and attach a debugger.