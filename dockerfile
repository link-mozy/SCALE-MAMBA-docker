# build prerequisites
#
FROM ubuntu:20.04 AS prereq-builder
LABEL maintainer="rnjs213 <rnjs213@gmail.com>"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y m4 yasm gcc gpp curl openssh-server g++ make git net-tools vim wget unzip

RUN wget http://web.archive.org/web/20220129135611/http://www.mpir.org/mpir-3.0.0.tar.bz2 && tar -xjf mpir-3.0.0.tar.bz2 && rm mpir-3.0.0.tar.bz2
WORKDIR  mpir-3.0.0
RUN ./configure --enable-cxx --prefix=/mpir && make
RUN make check
RUN make install
RUN rm -rf /mpir/share

WORKDIR /
RUN wget https://www.openssl.org/source/openssl-1.1.1s.tar.gz && tar xf openssl-1.1.1s.tar.gz && rm openssl-1.1.1s.tar.gz
WORKDIR openssl-1.1.1s/
RUN ./config --prefix=/openssl no-async no-weak-ssl-ciphers && make
RUN make test
RUN make install
RUN rm -rf /openssl/share

WORKDIR /
RUN curl -O https://www.cryptopp.com/cryptopp870.zip && unzip cryptopp870.zip -d cryptopp870 && rm cryptopp870.zip
WORKDIR cryptopp870
RUN make
RUN make install PREFIX="/cryptopp"
RUN rm -rf /cryptopp/share

# build SALE-MAMBA binaries & final container
#
FROM ubuntu:20.04
LABEL maintainer="rnjs213 <rnjs213@gmail.com>"

RUN apt-get update
RUN apt-get install -y gcc gpp make g++ curl git python2
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup default nightly
RUN rustup target add wasm32-unknown-unknown

COPY --from=prereq-builder /mpir /usr/local/mpir
COPY --from=prereq-builder /openssl /usr/local/openssl
COPY --from=prereq-builder /cryptopp /usr/local/cryptopp

ENV MPIR_PATH="/usr/local/mpir/bin"
ENV OPENSSL_PATH="/usr/local/openssl/bin"
ENV C_INCLUDE_PATH="/usr/local/mpir/include/:${C_INCLUDE_PATH}"
ENV C_INCLUDE_PATH="/usr/local/openssl/include/:${C_INCLUDE_PATH}"
ENV CPLUS_INCLUDE_PATH="/usr/local/mpir/include/:${CPLUS_INCLUDE_PATH}"
ENV CPLUS_INCLUDE_PATH="/usr/local/openssl/include/:${CPLUS_INCLUDE_PATH}"
ENV CPLUS_INCLUDE_PATH="/usr/local/cryptopp/include/:${CPLUS_INCLUDE_PATH}"
ENV LIBRARY_PATH="/usr/local/mpir/lib/:${LIBRARY_PATH}"
ENV LIBRARY_PATH="/usr/local/openssl/lib/:${LIBRARY_PATH}"
ENV LIBRARY_PATH="/usr/local/cryptopp/lib/:${LIBRARY_PATH}"
ENV LD_LIBRARY_PATH="/usr/local/mpir/lib/:${LD_LIBRARY_PATH}"
ENV LD_LIBRARY_PATH="/usr/local/openssl/lib/:${LD_LIBRARY_PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cryptopp/lib/:${LD_LIBRARY_PATH}"
ENV PATH="${MPIR_PATH}:${OPENSSL_PATH}:${PATH}"

WORKDIR /scale-mamba
ADD SCALE-MAMBA/ .
ADD CONFIG.mine .

RUN make progs

ENV "PATH"="/scale-mamba:${PATH}"
EXPOSE 5000
EXPOSE 8080
VOLUME ["/scale-mamba"]
CMD ["/bin/sh"]