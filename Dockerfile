FROM ubuntu

MAINTAINER 330k

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y build-essential libcurl4-openssl-dev git automake && \
  git clone https://github.com/macchky/cpuminer.git

WORKDIR cpuminer

RUN ./autogen.sh && \
  ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" && \
  make

ENTRYPOINT ["/cpuminer/minerd"]
CMD ["-a", "yescrypt", "-o", "stratum+tcp://jp.lapool.me:3014", "-u", "330k.user", "-p", "password"]
