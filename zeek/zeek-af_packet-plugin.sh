cd /zeek-af_packet-plugin
env CFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2 -fomit-frame-pointer -pipe' CXXFLAGS='-O3 -DNDEBUG -march=nocona -mtune=haswell -msse4.2 -fomit-frame-pointer -pipe' ./configure --with-latest-kernel --zeek-dist=/zeek-3.2.2 && make && make install
