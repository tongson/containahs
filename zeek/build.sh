cd /zeek-3.2.2
env CFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2 -fomit-frame-pointer -pipe' CXXFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2 -fomit-frame-pointer -pipe' ./configure --build-type=none --prefix=/opt/zeek \
  --disable-broker-tests \
  --disable-zeekctl \
  --disable-auxtools \
  --disable-python \
  --enable-static-binpac
make -j 1
make install
