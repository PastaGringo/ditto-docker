FROM denoland/deno:alpine
ARG SENTRY_DSN
ENV SENTRY_DSN $SENTRY_DSN
ARG ADMIN_HEX_KEY
ENV ADMIN_HEX_KEY $ADMIN_HEX_KEY
RUN apk add git curl unzip
RUN git clone https://gitlab.com/soapbox-pub/ditto.git /app
WORKDIR /app
RUN curl -O https://dl.soapbox.pub/main/soapbox.zip
RUN unzip soapbox.zip -d public/
RUN DITTO_NSEC=$(deno task nsec) && \
    echo $DITTO_NSEC && \
    echo "DITTO_NSEC=$DITTO_NSEC" >> .env
RUN deno cache src/server.ts
COPY favicon.ico .
COPY soapbox-logo.svg .
COPY avi.png .
COPY banner.png .
ENV PORT 8000
EXPOSE 8000/tcp
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]