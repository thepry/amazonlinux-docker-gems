install_and_pack:
	docker-compose run --rm -w /amazonlinuxdocker/scripts linux /bin/bash -l -c "make GEM=${GEM} VERSION=${VERSION} install_and_pack"

bash:
	docker-compose run --rm -w /amazonlinuxdocker/scripts linux /bin/bash -l

build:
	docker-compose build
