#!/bin/bash

if [ ! -f /root/minecraft_server*.jar ]; then
    echo "Does not exist"
    cp -vnpr /var/lib/minecraft/* /root
fi
chmod +x /root/LaunchServer.sh

/root/LaunchServer.sh