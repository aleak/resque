# borrowed from ennexa/resque-web

FROM debian:jessie

# Install wget, sox and flite
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ruby ruby-dev zlib1g-dev build-essential

ENV app_dir /resque-web
RUN mkdir -p ${app_dir}

ADD . ${app_dir}
WORKDIR ${app_dir}

RUN gem install bundler --no-document && \
    bundle install -j 4 && \
    apt-get autoremove -y ruby-dev zlib1g-dev build-essential && \
    apt-get clean -y

ENTRYPOINT ["resque-web", "-FL"]

EXPOSE 5678

CMD ["-h"]
