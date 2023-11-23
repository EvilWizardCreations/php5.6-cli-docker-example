#!/bin/bash
# USAGE:
# build-up-php-5-6-cli.sh
#
# NOTE:
# Rebuild the Docker image & compose up.

# source the environment variables
set -o allexport; source "${PWD}/.env"; set +o allexport

# Get the details from the environment
docker_service=${DOCKER_BUILD_SERVICE:-php-5-6-cli}
build_desc=${DOCKER_BUILD_DESC:-PHP ${PHP_VERSION} CLI}
compose_build_file="${PWD}/${DOCKER_COMPOSE_BUILD_FILE}"

# Use the EWC Protocol to build the image of the service & compose up
ewc-docker-build-up.sh "${docker_service}" "${build_desc}"
