#!/bin/bash
set -e
VERSION_FILE="$MINECRAFT_HOME/version"
CURRENT_VERSION=$(head -n 1 $VERSION_FILE || echo "does not exist")

mkdir -p $MINECRAFT_SRC || true
mkdir -p $MINECRAFT_HOME || true

check_env() {
    # Agree to EULA.
    if [ "$MINECRAFT_EULA" == "true" ]; then
        echo "Updating $MINECRAFT_HOME/eula.txt"
        echo "eula=$MINECRAFT_EULA" > $MINECRAFT_HOME/eula.txt
    else
        >&2 echo "Mojang requires you to accept their EULA. You need to set the MINECRAFT_EULA variable to true."
        exit 1
    fi
}

if [ "$CURRENT_VERSION" != "$PACK_VERSION" ]; then
	cd $MINECRAFT_SRC

    echo "Version mismatch: $PACK_VERSION (pack version) != $CURRENT_VERSION (current version)"
    wget -O "$MINECRAFT_SRC/minecraft.zip" "http://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK_VERSION.zip"
    unzip -f $MINECRAFT_SRC/minecraft.zip
	rm "$MINECRAFT_SRC/minecraft.zip"

	echo "Moving config files"
	mv $MINECRAFT_HOME/server.properties /tmp/server.properties || echo "no server.properties to move"
	mv $MINECRAFT_HOME/config /tmp/config || echo "no config to move"

	echo "Installing $PACK_VERSION"
    cp -r $MINECRAFT_SRC/. $MINECRAFT_HOME

    echo "Moving things back"
    cp -R -f /tmp/server.properties $MINECRAFT_HOME/server.properties || echo "no server.properties to move back"
    cp -R -f /tmp/config $MINECRAFT_HOME/config || echo "no config to move back"

    echo $PACK_VERSION > $VERSION_FILE
fi
chmod +x "$MINECRAFT_HOME/LaunchServer.sh"

echo "Starting"

check_env

cd $MINECRAFT_HOME
sh "$MINECRAFT_HOME/LaunchServer.sh"