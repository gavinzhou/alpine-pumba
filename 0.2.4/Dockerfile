FROM alpine:3.4

MAINTAINER Gavin Zhou <gavin.zhou@gmail.com>

ENV GOSU_VERSION=1.9 \
 PUMBA_VERSION=0.2.4

RUN set -x \
    && addgroup pumba && adduser -s /bin/ash -D -G pumba pumba \
    && apk add --no-cache iproute2 \
    && apk add --no-cache --virtual .gosu-deps dpkg gnupg openssl ca-certificates make gcc musl-dev curl \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -q -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && wget -q -O /usr/bin/pumba "https://github.com/gaia-adm/pumba/releases/download/$PUMBA_VERSION/pumba_linux_amd64" \
    && curl -sSL https://github.com/Yelp/dumb-init/archive/master.tar.gz | tar -xz \
    && cd dumb-init-master && gcc -std=gnu99 -s -Wall -Werror -O3 -o /sbin/dumb-init /dumb-init-master/dumb-init.c \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc /dumb-init-master* \
    && chmod +x /usr/local/bin/gosu && chmod +x /usr/bin/pumba \
    && gosu nobody true \
    && apk del .gosu-deps

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pumba", "--help"]
