FROM tarampampam/curl:8.1.1-alpine as curl-container

FROM alpine:3.17 as jq-container

ENV JQ_VERSION="1_6"

RUN apk add \
    git \
    build-base \
    clang \
    autoconf \
    automake \
    libtool

WORKDIR /tmp

ENV CC="clang" \
    LDFLAGS="-static" \
    PKG_CONFIG="pkg-config --static"

COPY jq jq

WORKDIR /tmp/jq

RUN ls /tmp/jq

RUN autoreconf -fi \
    && ./configure --disable-maintainer-mode \
		&& make LDFLAGS=-all-static -j8 \
		&& make check

FROM alpine:3.17

# import from builder
COPY --from=curl-container /bin/curl /bin/curl
COPY --from=jq-container /tmp/jq/jq /bin/jq

ENTRYPOINT ["sh"]
