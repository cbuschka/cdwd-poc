FROM alpine:3.4
RUN apk --update add openjdk8-jre \
	&& apk add --update curl \
	&& rm -rf /var/cache/apk/*
RUN addgroup app && adduser -D -G app app
WORKDIR /home/app/
USER app

COPY assets/check-if-up.sh /home/app/check-if-up.sh
COPY app.war /home/app/app.war

HEALTHCHECK CMD /home/app/check-if-up.sh

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/home/app/app.war","--spring.profiles.active=docker"]
