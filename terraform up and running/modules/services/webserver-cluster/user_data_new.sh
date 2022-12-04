#!/bin/bash

echo "hello, World, v2" > index.html
nohup busybox httpd -f -p ${server_port} &