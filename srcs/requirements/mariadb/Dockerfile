FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/mariadb.cnf

COPY tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["sh", "/tmp/setup.sh"]
