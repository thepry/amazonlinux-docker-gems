## Building ruby gems for Amazon Labmda

This repo contains a Dockerfile and scripts that simplify the process of building gems for Amazon Lambda.
To make it work with RubyOnJets, upload gems to S3 bucket and add your bucket to [jets config](http://rubyonjets.com/docs/lambdagems/)

Example S3 path: `https://s3.eu-central-1.amazonaws.com/YOUR_BUCKET_NAME/gems/2.5.0/tiny_tds/tiny_tds-2.1.1.zip`

### Simple gem example:

If your gem doesn't rely on additional system libraries during the runtime, you can build it with the following code:

```
make GEM=${GEM NAME} VERSION=${GEM VERSION} install_and_pack

```

For example

```
make GEM=sqlite3 VERSION=1.3.13 install_and_pack

```

After that docker container will be started, gem will be installed and packed.
The `./builded/sqlite3-1.3.13.zip` will be created.

If you build gem again it will delete the existing zip file from the `builded` folder.


### Complex gem example:

Some gems require extra system libraries during the runtime. That must be resolved manually by adding those libraries in the lib directory:

```
make bash
make GEM=tiny_tds VERSION=2.1.1 install
make prepare_packing
mkdir -p /amazonlinuxdocker/tmp/lib

cp /usr/local/lib/libsybdb.so.5 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libpthread.so.0 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libdl.so.2 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libcrypt.so.1 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libm.so.6 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libc.so.6 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libssl.so.10 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libcrypto.so.10 /amazonlinuxdocker/tmp/lib/.
cp /lib64/ld-linux-x86-64.so.2 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libgssapi_krb5.so.2 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libkrb5.so.3 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libcom_err.so.2 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libk5crypto.so.3 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libz.so.1 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libkrb5support.so.0 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libkeyutils.so.1 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libresolv.so.2 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libselinux.so.1 /amazonlinuxdocker/tmp/lib/.
cp /lib64/libpcre.so.1 /amazonlinuxdocker/tmp/lib/.


make GEM=tiny_tds VERSION=2.1.1 create_zip

exit

```

The `./builded/tiny_tds-2.1.1.zip` will be created.


`ldd` command is helpful when you need to find out which libraries are required by gem

```
bash-4.2# ldd /usr/local/rvm/gems/ruby-2.5.3/gems/tiny_tds-2.1.1/lib/tiny_tds/tiny_tds.so
    linux-vdso.so.1 (0x00007ffc4894d000)
    libsybdb.so.5 (0x00007f98e02eb000)
    libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f98e00cd000)
    libdl.so.2 => /lib64/libdl.so.2 (0x00007f98dfec9000)
    ...


```
