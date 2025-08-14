#!/usr/bin/env bash
set -e
VER="$1"
mkdir -p /opt/imapsync
git clone https://github.com/imapsync/imapsync.git /opt/imapsync
cd /opt/imapsync
git checkout imapsync-$VER
make testp && make install
