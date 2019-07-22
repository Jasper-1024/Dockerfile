FROM alpine:latest

LABEL maintainer="jasperhale <ljy087621@gmail.com>"

ENV version 1.1.1

RUN set -xe \
    && apk update \
	&& apk add --no-cache --update aria2 darkhttpd \
	&& mkdir -p aria2/conf aria2/conf-temp aria2/downloads aria-ng \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip \
	&& unzip AriaNg-${version}.zip -d aria-ng \
	&& rm -rf AriaNg-${version}.zip

COPY init.sh /aria2/init.sh
COPY conf-temp /aria2/conf-temp

WORKDIR /
VOLUME ["/aria2/conf", "/aria2/downloads"]
EXPOSE 6800 80 8080

CMD ["/aria2/init.sh"]