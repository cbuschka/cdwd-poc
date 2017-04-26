FROM nginx:1.10.2-alpine

RUN apk add --update supervisor docker bash \
	&& rm -rf /var/cache/apk/*

ADD assets /assets

# add nginx configs
RUN cp -r /assets/* /

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

