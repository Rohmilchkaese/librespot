FROM alpine:3.14 AS build 
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
&& git clone https://github.com/librespot-org/librespot.git .\
&& git checkout tags/v0.3.1 \
&& cargo build --release --no-default-features --features "with-dns-sd"

FROM alpine:3.14
RUN apk -U --no-cache add \
        libtool \
        libconfig-dev \
	avahi-dev \
	dbus
COPY --from=build /root/target/release/librespot /usr/bin/librespot
COPY bootstrap.sh /start
RUN chmod +x /start
ENTRYPOINT [ "/start" ]
