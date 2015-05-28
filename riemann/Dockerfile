FROM mojotech/clojure:latest
MAINTAINER mojotech <ops+docker@mojotech.com>

RUN apt-get install -y --no-install-recommends -t local riemann

ADD . /root/

EXPOSE 5556

ENTRYPOINT ["/root/run-riemann.sh"]
