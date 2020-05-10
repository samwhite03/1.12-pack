build:
	docker build --build-arg PACK_VERSION=1.1.2 -t ronnieonthehub/1.12-pack:latest .

push:
	docker push ronnieonthehub/1.12-pack:latest

pull:
	docker image pull ronnieonthehub/1.12-pack:latest

run:
	-mkdir volume
	-docker stop ronnie
	-docker rm ronnie
	docker run --name ronnie -it \
	-v "/Users/ronan/Documents/GitRepos/1.12-pack/volume":/opt/minecraft \
	-v "/Users/ronan/Documents/GitRepos/1.12-pack/":/root \
	-e "MINECRAFT_EULA=true" \
	-d ronnieonthehub/1.12-pack:latest /bin/bash
	docker exec -it ronnie /bin/bash

clean:
	docker system prune


