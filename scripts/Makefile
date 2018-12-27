install_and_pack:
	make install
	make pack

install:
	gem install ${GEM} -v ${VERSION}

pack:
	make prepare_packing
	make create_zip

prepare_packing:
	mkdir -p /amazonlinuxdocker/tmp/ruby/gems/2.5.0
	cp -r /usr/local/rvm/gems/ruby-2.5.3/* /amazonlinuxdocker/tmp/ruby/gems/2.5.0/.

create_zip:
	make delete_existing_zip
	cd /amazonlinuxdocker/tmp/ && zip -r /amazonlinuxdocker/builded/${GEM}-${VERSION}.zip ruby lib

create_zip_with_libs:
	make delete_existing_zip
	cd /amazonlinuxdocker/tmp/ && zip -r /amazonlinuxdocker/builded/${GEM}-${VERSION}.zip ruby lib

delete_existing_zip:
	cd /amazonlinuxdocker/builded/ && rm -f ${GEM}-${VERSION}.zip

