FROM openjdk:8-jre
MAINTAINER Ronan Munro

EXPOSE 25565

ENV PACK_VERSION=1.1.2

VOLUME ["/var/lib/minecraft"]

WORKDIR ["/var/lib/minecraft"]

RUN apt-get update && apt-get install -y wget \	
	&& wget -O  /var/lib/minecraft/1122pack.zip http://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK_VERSION.zip \
	&& unzip -d /var/lib/minecraft /var/lib/minecraft/1122pack.zip \
	&& rm /var/lib/minecraft/1122pack.zip

CMD ["launchsever.sh"]