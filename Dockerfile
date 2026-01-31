FROM rust:alpine3.21 AS build

ARG LIBRESPOT_VERSION=0.8.0

RUN apk -U --no-cache add \
	git \
	build-base

RUN mkdir -p /root/git \
	&& cd /root/git \
	&& git clone https://github.com/librespot-org/librespot.git . \
	&& git checkout tags/v${LIBRESPOT_VERSION} \
	&& cargo build --release --no-default-features --features "with-libmdns,rustls-tls-webpki-roots"

FROM alpine:3.21

COPY --from=build /root/git/target/release/librespot /usr/bin/librespot

ENTRYPOINT [ "/usr/bin/librespot" ]
