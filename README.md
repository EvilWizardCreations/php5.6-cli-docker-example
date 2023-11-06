# PHP 5.6 CLI Dockerfile Example

A base PHP 5.6 CLI image[^docker_pull_cmd_note] for demonstrating legacy projects available at [EWC Docker Hub](https://hub.docker.com/r/ewc2020/web).

An older version of ***PHP*** that some older codebases would require such an environment to run in.

Other Packages Included:

- Node v8.x
- Composer v1.7.1
- libxml2-dev
- libzip-dev
- libyaml-dev
- zip
- unzip
- git
- nodejs
- default-mysql-client
- vim
- npm i npm@`$NPM_VERSION`[^npm_version_note] -g
- yaml-1.3.0

PHP Extensions:

- gettext 
- mysqli 
- pdo_mysql 
- zip
- yaml


## Build & Compose Up

Note that the `php-5-6-cli` is the Docker Compose Service to ***Build***.

There is an [Evil Wizard Creations Protocol](https://bitbucket.org/evilwizardcreations/ewc-protocols) that makes this much simpler.

```bash
ewc-docker-build-up.sh php-5.6-cli "PHP 5.6 CLI"
```

Alternatively there is the *full Procedure*.

1. Build the Image using the `docker-compose-build.yaml` configuration.

    ```bash
    docker-compose -f ./docker-compose-build.yaml build --no-cache php-5-6-cli
    ```

1. Compose *Up* using the `docker-compose-build.yaml` configuration will use the new built Image and `-d` to *detach*.

    ```bash
    docker-compose -f ./docker-compose-build.yaml up -d
    ```

# Disclaimer

This Apache2 + PHP 5.6 build environment should ***NOT*** be used anywhere near a ***production*** environment. This build is for showcasing legacy systems that simple would not run in modern environments & as such it is littered with security holes and exploitation's.

[^docker_pull_cmd_note]: Use `docker pull ewc2020/web:php-5.6-cli-latest` to get a copy of the image.

[^npm_version_note]: Uses a `.env` ***build-arg*** called ***NPM_VERSION*** to specify the npm version.

[^multi_stage_builds_note]: Used mostly in ***Multi Stage*** image builds.

[^compose_name_note]: The `php-5-6-web-server` container name to build the image for.
