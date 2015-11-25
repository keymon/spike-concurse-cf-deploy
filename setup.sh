#!/bin/sh

set -e

vagrant up

echo "Downloading fly command"
wget -q "http://192.168.100.4:8080/api/v1/cli?arch=amd64&platform=$(uname -s | tr A-Z a-z)" -O fly
chmod +x fly

