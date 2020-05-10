build:
	docker build --build-arg PACK_VERSION=1.1.2 -t ronnieonthehub/1.12-pack:latest .

push:
	docker push ronnieonthehub/1.12-pack:latest

pull:
	docker image pull ronnieonthehub/1.12-pack:latest

run:
	-mkdir root
	-docker stop ronnie
	-docker rm ronnie
	docker run --name ronnie -it \
	-v "/Users/ronan/Documents/GitRepos/1.12-pack/root":/root \
	-d ronnieonthehub/1.12-pack:latest /bin/bash
	docker exec -it ronnie /bin/bash

clean:
	docker system prune


