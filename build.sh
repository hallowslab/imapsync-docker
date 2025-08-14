#!/usr/bin/env bash
set -euo pipefail

OS_FOLDER="$1"          # e.g. ubuntu, alpine, debian
BASE_IMAGE="$2"           # e.g. ubuntu:jammy, alpine:3.18
IMAPSYNC_VER="$3"       # e.g. 2.229

USER="yourdockerhubuser"
BASE_TAG="${OS_FOLDER}_${BASE_IMAGE}"
IMAGE="${USER}/imapsync:${BASE_TAG}-${IMAPSYNC_VER}"

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --push \
  --build-arg IMAPSYNC_VERSION="$IMAPSYNC_VER" \
  --build-arg BASE_IMAGE="$BASE_TAG" \
  -f "${OS_FOLDER}/Dockerfile" \
  -t "$IMAGE" \
  .
echo "Published $IMAGE"
