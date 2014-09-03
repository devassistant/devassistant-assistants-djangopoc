FROM centos:centos7

# we don't want real systemd in the image
RUN yum update -y fakesystemd

# now install postgresql
RUN yum -y install postgresql postgresql-server postgresql-contrib

# configure DB
ADD ./db_setup.sh /usr/local/bin/
USER postgres
RUN /bin/bash /usr/local/bin/db_setup.sh

EXPOSE 5432
CMD /usr/bin/postgres -D /var/lib/pgsql/data
