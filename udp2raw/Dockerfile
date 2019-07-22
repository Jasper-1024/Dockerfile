FROM alpine:latest
ENV VERSION=20181113.0
RUN wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/$VERSION/  udp2raw_binaries.tar.gz && \
    tar -zxvf udp2raw_binaries.tar.gz && \
    mv udp2raw_amd64 usr/ && \
    rm udp2raw_* && \
    mv /usr/udp2raw_amd64 / && \
    echo '-s' > udp2raw.conf && \
    echo '-l 0.0.0.0:900' >> udp2raw.conf && \
    echo '-r 127.0.0.1:901' >> udp2raw.conf && \
    echo '-k password' >> udp2raw.conf && \
    echo '--cipher-mode aes128cbc' >> udp2raw.conf && \
    echo '--auth-mode hmac_sha1' >> udp2raw.conf && \
    echo '--raw-mode faketcp' >> udp2raw.conf && \
    echo '--seq-mode 3' >> udp2raw.conf && \
    echo '--lower-level auto' >> udp2raw.conf

CMD ./udp2raw_amd64 --conf-file udp2raw.conf