cd /zeek-3.2.2
CFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2' CXXFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2' ./configure --build-type=none --prefix=/opt/zeek \
  --disable-broker-tests \
  --disable-zeekctl \
  --disable-auxtools \
  --disable-python
make -j 1
make install
