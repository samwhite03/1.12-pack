# 1.12-pack Minecraft Modpack Docker Image
## What is it?
A Docker image (which builds on openjdk:8-jre Docker image) which downloads the needed files of the modpack, extracts them, and runs the server. Currently this image is still being worked on, but it is working and stable. 

[Link to the modpack's website](https://www.technicpack.net/modpack/the-1122-pack.1406454)

## Enviroment Tables
There are several enviroment varbiables which can be altered. 

### MINECRAFT_EULA
Set standard to `false`. `MINECRAFT_EULA` has to be set to `true` by the user to be able to start the server.

### MINECRAFT_SRC
`MINECRAFT_SRC` default set to `/usr/src/minecraft`. This is the directory where the server zip is unpacked. Which is later copied to the MINECRAFT_HOME directory. This directory is stateless, and won't be saved on shutdown. I would not change this variable.

### MINECRAFT_HOME
`MINECRAFT_HOME` default set to `/opt/minecraft`. This is the directory where the server files and world is located. I would not change this variable.
