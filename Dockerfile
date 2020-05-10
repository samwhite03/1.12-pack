FROM openjdk:8-jre
MAINTAINER Ronan Munro

EXPOSE 25565

ARG PACK_VERSION=1.1.2

VOLUME ["/root"]
WORKDIR /root

RUN apt-get update && apt-get install -y wget

RUN mkdir -p /var/lib/minecraft/ && wget -O /var/lib/minecraft/minecraft.zip http://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK_VERSION.zip \
	&& unzip -d /var/lib/minecraft /var/lib/minecraft/minecraft.zip \
	&& rm /var/lib/minecraft/minecraft.zip

COPY entrypoint.sh /entrypoint.sh

CMD /entrypoint.sh