#!/bin/sh

# get confd
curl -L https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 -o bin/confd

# get confd-watch script
curl -L https://raw.github.com/AirshipCMS/CoreOS-fleet-nginx/master/confd-watch.tar.gz | tar -C bin/ -xvz