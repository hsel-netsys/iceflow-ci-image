FROM ubuntu:latest

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install git cmake wget software-properties-common build-essential pkg-config python3-minimal libssl-dev libsqlite3-dev libopencv-dev clang-format && \
    ln -s /usr/include/opencv4 /usr/local/include/opencv4 && \
    # Install nlohmann-json
    add-apt-repository ppa:team-xbmc/ppa && \
    apt-get update && \
    apt-get -y install nlohmann-json3-dev && \
    # Install libboost
    wget https://sourceforge.net/projects/boost/files/boost/1.76.0/boost_1_76_0.tar.bz2 && \
    tar xfo boost_1_76_0.tar.bz2 && \
    cd boost_1_76_0 && \
    ./bootstrap.sh && \
    ./b2 --with=all install && \
    cd .. && \
    rm -rf boost_1_76_0 && \
    # Install ndn-cxx
    git clone https://github.com/named-data/ndn-cxx && \
    cd ndn-cxx && \
    ./waf configure --with-examples && \
    ./waf && \
    ./waf install && \
    ldconfig && \
    cd .. && \
    rm -rf ndn-cxx && \
    # Install PSync
    git clone https://github.com/named-data/PSync.git && \
    cd PSync && \
    ./waf configure && \
    ./waf && \
    ./waf install && \
    cd .. && \
    rm -rf PSync && \
    # Install yaml-cpp
    git clone https://github.com/jbeder/yaml-cpp.git && \
    cd yaml-cpp && \
    mkdir build && \
    cd build && \
    cmake -DYAML_BUILD_SHARED_LIBS=on .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf yaml-cpp