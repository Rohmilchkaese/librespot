FROM alpine:3.15
RUN apk -U --no-cache add \
	librespot

COPY bootstrap.sh /start
RUN chmod +x /start
ENTRYPOINT [ "/start" ]