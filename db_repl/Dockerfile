FROM postgres:16

COPY init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

RUN apt-get update && \
    apt-get install -y postgresql-client

CMD ["/usr/local/bin/init.sh"]
