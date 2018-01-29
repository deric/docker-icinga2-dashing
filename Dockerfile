FROM debian:stretch as builder
MAINTAINER Tomas Barton <barton.tomas@gmail.com>

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends\
 ruby ruby-dev bundler libssl-dev nodejs build-essential\
  && rm -rf /var/lib/apt/lists/* && mkdir /app

ADD dashing-icinga2/Gemfile /app
WORKDIR /app
RUN bundle

FROM debian:stretch

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends\
 ruby bundler nodejs\
 && rm -rf /var/lib/apt/lists/* && mkdir -p /usr/share/dashing-icinga2

COPY --from=builder /var/lib/gems/2.3.0/ /var/lib/gems/2.3.0/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
ADD dashing-icinga2/ /usr/share/dashing-icinga2/
WORKDIR /usr/share/dashing-icinga2

EXPOSE 8005
ENTRYPOINT /usr/local/bin/dashing start -d -p 8005 --pid /var/run/thin.pid
