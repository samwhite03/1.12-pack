COPY openjdk:8-jre
MAINTAINER Ronan Munro

EXPOSE 25565

ENV PACK_VERSION=1.1.2

VOLUME ["/var/lib/minecraft"]

WORKDIR ["/var/lib/minecraft"]

RUN
\
	wget -O  /var/lib/minecraft/1122pack.zip http://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK_VERSION.zip \
	unzip -j 1122pack.zip \
	rm 1122pack.zip && \
\

CMD ["launchsever.sh"]