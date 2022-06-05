FROM alpine:3.16 AS build 
RUN apk -U --no-cache add \
	git \
	build-base \
    avahi-dev \
	autoconf \
	automake \
	libtool \
	libdaemon-dev \
	libressl-dev \
	libconfig-dev \
	libstdc++ \
	gcc \
	rust \
	cargo 

RUN cd /root \ 
	&& ls -al /root \
	&& mkdir -p ~/.cargo \
	&& echo $'[net]\n\
	git-fetch-with-cli = true\n'\
	>> ~/.cargo/config.toml \
	&& mkdir -p /root/git \
	&& cd /root/git \
	&& git clone https://github.com/librespot-org/librespot.git . \
	&& git checkout tags/v0.4.1 \
	&& cargo build --release --no-default-features --features "with-dns-sd"

FROM alpine:3.16
RUN apk -U --no-cache add \
    libtool \
    libconfig-dev \
	avahi-dev \
	dbus
COPY --from=build /root/git/target/release/librespot /usr/bin/librespot
COPY bootstrap.sh /start
RUN chmod +x /start
ENTRYPOINT [ "/start" ]
