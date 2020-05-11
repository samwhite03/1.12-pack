# 1.12-pack Minecraft Modpack Docker Image
## What is it?
A Docker image (which builds on openjdk:8-jre Docker image) which downloads the needed files of the modpack, extracts them, and runs the server. Currently this image is still being worked on, but it is working and stable. 

[Link to the modpack's website](https://www.technicpack.net/modpack/the-1122-pack.1406454)

## Enviroment Tables
There are several enviroment varbiables which can be altered.

### PACK_VERSION
`PACK_VERSION` is default set to `1.1.2`, because this is the latest version of the pack as of writing this image. During the install of the server a version file will be writen to the `MINECRAFT_HOME` directory. This is used to determine if there is a diffrence between `PACK_VERSION` (set by the user) and the version of the server installed. This variable can be changed to the desired version of the modpack.

### MINECRAFT_EULA
Set standard to `false`. `MINECRAFT_EULA` has to be set to `true` by the user to be able to start the server.

### MINECRAFT_SRC
`MINECRAFT_SRC` default set to `/usr/src/minecraft`. This is the directory where the server zip is unpacked. Which is later copied to the MINECRAFT_HOME directory. This directory is stateless, and won't be saved on shutdown. I would not change this variable.

### MINECRAFT_HOME
`MINECRAFT_HOME` default set to `/opt/minecraft`. This is the directory where the server files and world is located. I would not change this variable.

###MAX_MEM
Default set to `4G`. You could change this if you desire more memory for the server.

## Updating and config files
If there is a mismatch between the user set `PACK_VERSION` and currently installed server version, the server will do the following:
- Backup config dir, and server.properties to tmp folder.
- Download set `PACK_VERSION` zip, and unpack it to `MINECRAFT_SRC`.
- Write `MINECRAFT_SRC` to `MINECRAFT_HOME`.
- Copy and overwrite config dir and server.properties to from tmp to `MINECRAFT_HOME`.

This is usefull as you don't lose your (custom set) configs when updating to a new modpack version.

## Volumes
Only one volume should be bound, with the path same path as `MINECRAFT_HOME`.