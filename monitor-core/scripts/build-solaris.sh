#!/bin/bash

# If the code has just been taken from svn, this needs to be run first:
# PATH=/opt/csw/bin:$PATH ./bootstrap

if [ ! -f configure ];
then
  echo "Please run ./bootstrap first, it will generate configure, e.g."
  echo '  PATH=/opt/csw/bin:$PATH ./bootstrap'
  exit 1
fi

# Change these if you have installed them elsewhere

CSW_HOME=/opt/csw
APR=/opt/apr-1.2.7/bin/apr-1-config
LIBCONFUSE=/opt/confuse-2.6

if [ ! -d ${CSW} ];
then
  echo "Couldn't find ${CSW} - please make sure that"
  echo "Blastwave is installed and the path is correct in $0"
  exit 1
fi

if [ ! -x ${APR} ];
then
  echo "Couldn't execute ${APR} - please make sure that"
  echo "apr is installed and the path is correct in $0"
  exit 1
fi

if [ ! -d ${LIBCONFUSE} ];
then
  echo "Couldn't find ${LIBCONFUSE} - please make sure that"
  echo "confuse is installed and the path is correct in $0"
  exit 1
fi

MAKE=${CSW_HOME}/bin/gmake

if [ ! -x ${GMAKE} ];
then
  echo "Couldn't execute ${GMAKE} - please make sure that"
  echo "gmake is installed and the path is correct in $0"
  exit 1
fi

./configure \
  --prefix=/usr/local \
  --without-gcc --disable-nls \
  --enable-shared --disable-static --disable-static-build \
  --without-gmetad --disable-python \
  --with-libapr=${APR} --with-libconfuse=${LIBCONFUSE} --with-libexpat=${CSW_HOME} \
  CC=/opt/SUNWspro/bin/cc \
  LD=/usr/ccs/bin/ld \
  MAKE=${MAKE} \
  AR=/usr/ccs/bin/ar \
  LDFLAGS="-R/opt/csw/lib"

${MAKE}


