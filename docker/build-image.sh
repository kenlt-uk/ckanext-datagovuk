#!/bin/bash

set -eux

DOCKER_TAG="${GITHUB_SHA}"

if [ "${ARCH}" = "amd64" ]; then
  docker build . -t ghcr.io/alphagov/${APP}:${DOCKER_TAG} -f docker/${APP}/${VERSION}.Dockerfile
else
  docker buildx build --platform linux/${ARCH} . -t ghcr.io/alphagov/${APP}:${DOCKER_TAG} -f docker/${APP}/${VERSION}.Dockerfile
fi

if [[ -n ${DRY_RUN:-} ]]; then
  echo "Dry run; not pushing to registry"
else
  docker push ghcr.io/alphagov/${APP}:${DOCKER_TAG}
fi
