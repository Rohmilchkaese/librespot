FROM alpine:3.21 AS build
RUN apk -U --no-cache add \
	git \
	build-base \
	avahi-dev \
	autoconf \
	automake \
	libtool \
	libdaemon-dev \
	openssl-dev \
	pkgconf \
	libconfig-dev \
	libstdc++ \
	gcc \
	rust \
	cargo

RUN cd /root \
	&& mkdir -p ~/.cargo \
	&& echo $'[net]\n\
	git-fetch-with-cli = true\n'\
	>> ~/.cargo/config.toml \
	&& mkdir -p /root/git \
	&& cd /root/git \
	&& git clone https://github.com/librespot-org/librespot.git . \
	&& git checkout tags/v0.8.0 \
	&& cargo build --release --no-default-features --features "native-tls with-dns-sd"

FROM alpine:3.21
RUN apk -U --no-cache add \
	libtool \
	libconfig-dev \
	avahi-dev \
	dbus

COPY --from=build /root/git/target/release/librespot /usr/bin/librespot
COPY bootstrap.sh /start

RUN chmod +x /start 

ENTRYPOINT [ "/start" ]