FROM ubuntu:xenial
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y wget
ADD cuda-repo-ubuntu1604_8.0.44-1_amd64.deb /tmp/cuda.deb
RUN dpkg -i /tmp/cuda.deb && apt update
RUN apt install -y cuda-8-0 llvm-3.8 cuda-toolkit-8-0 clang-3.8 nvidia-367-dev nvidia-367
RUN cd /tmp && wget http://luajit.org/download/LuaJIT-2.1.0-beta2.tar.gz; tar -zxvf LuaJIT-2.1.0-beta2.tar.gz
RUN apt install -y libncurses5-dev libz-dev libclang-3.8-dev llvm-dev
RUN cd /tmp/LuaJIT-2.1.0-beta2 && make -j8 && make install
RUN #ln -sf luajit-2.1.0-beta2 /usr/lib/llvm-3.8/terra/build/bin/luajit
RUN apt -y install git; cd /usr/lib/llvm-3.8/; git clone https://github.com/zdevito/terra.git
ADD Makefile /usr/lib/llvm-3.8/terra/
ADD Makefile.inc /usr/lib/llvm-3.8/terra/
ENV PWD=/usr/lib/llvm-3.8/terra
RUN cd /usr/lib/llvm-3.8/terra && make -j8 && make install

