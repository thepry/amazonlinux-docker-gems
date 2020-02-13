FROM amazonlinux:2.0.20181114-with-sources

# RUN  yum install -y gcc
RUN yum install -y gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel ruby-devel gcc-c++ jq git curl which tar procps libxml2 wget build-essential libc6-dev zip

# RUN  gpg --keyserver hkp://keys.gnupg.net --recv-keys key1 key2

RUN  gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN  curl -sSL https://get.rvm.io | bash -s stable
RUN source /etc/profile.d/rvm.sh

RUN /bin/bash -l -c "rvm install 2.5.3 --disable-shared && rvm --default use 2.5.3"


# find latest version of FreeTDS ftp://ftp.freetds.org/pub/freetds/stable/
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.92.tar.gz && \
       tar -xzf freetds-1.00.92.tar.gz && \
       rm freetds-1.00.92.tar.gz && \
      cd freetds-1.00.92 && \
      ./configure --prefix=/usr/local --with-tdsver=7.3 && \
      make && \
      make install

RUN yum install -y postgresql-devel
