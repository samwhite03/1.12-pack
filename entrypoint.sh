#!/bin/bash
set -e
VERSION_FILE="$MINECRAFT_HOME/version"
CURRENT_VERSION=$(head -n 1 $VERSION_FILE || echo "does not exist")

mkdir -p $MINECRAFT_SRC || true
mkdir -p $MINECRAFT_HOME || true

check_env() {
    # Agree to EULA.
    if [ $MINECRAFT_EULA = true ]; then
        echo "Updating $MINECRAFT_HOME/eula.txt"
        echo "eula=$MINECRAFT_EULA" > $MINECRAFT_HOME/eula.txt
    else
        >&2 echo "Mojang requires you to accept their EULA. You need to set the MINECRAFT_EULA variable to true."
        exit 1
    fi
}

    #check for pack version mismatch
if [ "$CURRENT_VERSION" != "$PACK_VERSION" ]; then
	cd $MINECRAFT_SRC

    #download and unzip new pack version to source dir
    echo "Version mismatch: $PACK_VERSION (pack version) != $CURRENT_VERSION (current version)"
    wget -O "$MINECRAFT_SRC/minecraft.zip" "http://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK_VERSION.zip"
    unzip -o $MINECRAFT_SRC/minecraft.zip
	
    #move important config files to tmp
	echo "Moving config files"
	mv $MINECRAFT_HOME/server.properties /tmp/server.properties || echo "no server.properties to move"
	mv $MINECRAFT_HOME/config /tmp/config || echo "no config to move"

    #install new pack version from source dir to server home dir
	echo "Installing $PACK_VERSION"
    cp -r $MINECRAFT_SRC/. $MINECRAFT_HOME

    #move back important config files from tmp, and overwrite
    echo "Moving things back"
    yes | cp -r /tmp/server.properties $MINECRAFT_HOME/server.properties || echo "no server.properties to move back"
    yes | cp -r /tmp/config/* $MINECRAFT_HOME/config || echo "no config to move back"

    echo $PACK_VERSION > $VERSION_FILE

    #cleaning up Minecraft Source
    echo "cleaning up install files after upgrade to pack version $PACK_VERSION"
    rm -r "$MINECRAFT_SRC/"
fi

#set executable permission for launch script
chmod +x "$MINECRAFT_HOME/LaunchServer.sh"

#check to see if $MINECRAFT_EULA var is set
echo "Eula variable is set to: $MINECRAFT_EULA"
check_env

#start the server
echo "Starting server"
cd $MINECRAFT_HOME
sh "$MINECRAFT_HOME/LaunchServer.sh"

