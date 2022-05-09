FROM openjdk:8-jre
MAINTAINER Sam White samwhite2003@outlook.com

EXPOSE 25565

ENV PACK_VERSION=1.4.1
ENV MINECRAFT_HOME="/opt/minecraft"
ENV MINECRAFT_SRC="/usr/src/minecraft"
ENV MINECRAFT_EULA=false
ENV MAX_MEM=4G

VOLUME ["/opt/minecraft"]
WORKDIR /opt/minecraft

RUN apt-get update && apt-get install -y wget vim

COPY entrypoint.sh /root/entrypoint.sh

CMD /root/entrypoint.sh
