FROM alpine:3.8

ENV VERSION v1.5

WORKDIR /srv

RUN set -xe && \
    mkdir overture && \
    cd /srv/overture && \
    apk add --no-cache unzip curl && \
    curl -fsSLO --compressed "https://github.com/shawn1m/overture/releases/download/${VERSION}/overture-linux-amd64.zip" && \
    curl https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt | base64 -d | sort -u | sed '/^$\|@@/  d'| sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/##;   s#https:\/\/##;' | sed '/\*/d; /apple\.com/d; /sina\.cn/  d; /sina\.com\.cn/d; /baidu\.com/d; /qq\.com/d' | sed '/  ^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' | grep '^  [0-9a-zA-Z\.-]\+$' | grep '\.' | sed 's#^\.\+##' | sort   -u > gfwlist.txt && \
    curl https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt >    china_ip_list.txt && \
    unzip -o "overture-linux-amd64.zip" -d /srv/overture  &&   \
    rm -rf "overture-linux-amd64.zip" && \
    apk del unzip && \
    sed -i 's/ip_network_primary_sample/china_ip_list.txt/  g' config.json && \
    sed -i 's/domain_alternative_sample/gfwlist.txt/g'   config.json && \
    echo '#!/bin/sh' > update.sh && \
    echo "curl https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt | base64 -d | sort -u | sed   '/^$\|@@/d'| sed 's#!.\+##; s#|##g; s#@##g; s#http:\/\/  ##; s#https:\/\/##;' | sed '/\*/d; /apple\.com/d; /  sina\.cn/d; /sina\.com\.cn/d; /baidu\.com/d; /qq\.com/  d' | sed '/^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+$/d' |   grep '^[0-9a-zA-Z\.-]\+$' | grep '\.' | sed 's#^\.\+##'   | sort -u > gfwlist.txt" >> update.sh && \
    echo "curl https://raw.githubusercochina_ip_list/master/china_ip_list.txt >>  china_ip_list.txt" >> update.sh &&   \
  chmod u+x update.sh && \
  echo '0 2 * * *  sh  /srv/overture/update.sh'>>/var/spool/cron/crontabs/root

CMD crond && cd /srv/overture && ./overture-linux-amd64 -l overture.log