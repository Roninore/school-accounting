FROM debian:10

RUN apt update && apt install wget -y && apt install locales -y

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN wget https://repo.postgrespro.ru/1c-15/keys/pgpro-repo-add.sh

RUN sh pgpro-repo-add.sh

RUN apt-get install postgrespro-1c-15-contrib -y

RUN /opt/pgpro/1c-15/bin/pg-setup initdb

RUN /opt/pgpro/1c-15/bin/pg-setup service enable

RUN /opt/pgpro/1c-15/bin/pg-setup service start

USER postgres

CMD ["/opt/pgpro/1c-15/bin/postgres", "-D", "/var/lib/pgpro/1c-15/data"]