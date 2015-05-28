FROM mojotech/clojure:latest
MAINTAINER mojotech <ops+docker@mojotech.com>

RUN apt-get install -y --no-install-recommends -t local datomic-pro

ADD . /root/

EXPOSE 4334

ENTRYPOINT ["/root/run-datomic.sh"]
