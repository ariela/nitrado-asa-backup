FROM debian:12-slim

RUN apt-get -y update \
    && apt-get install --no-install-recommends -y \
        cron \
        wget \
        xz-utils \
        procps \
    && rm -rf /var/lib/apt/lists/*

COPY docker/entrypoint /usr/local/bin/entrypoint
COPY docker/start /usr/local/bin/start

COPY docker/crontab /var/spool/cron/crontabs/root
RUN crontab /var/spool/cron/crontabs/root

#COPY shell/minutely /usr/local/bin/minutely
#COPY shell/hourly /usr/local/bin/hourly
#COPY shell/daily /usr/local/bin/daily
#COPY shell/monthly /usr/local/bin/monthly

COPY commands/backup /commands/backup

#ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["start"]
