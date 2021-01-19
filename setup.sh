#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)
ln -si $SCRIPT_DIR"/titech" /usr/local/bin
chmod 777 $SCRIPT_DIR"/titech"