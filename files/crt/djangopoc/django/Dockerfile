FROM centos:centos7

WORKDIR /srv
RUN yum -y install python-virtualenv httpd mod_wsgi postgresql-devel gcc sudo && \
    virtualenv "{{ topdir }}-virtualenv"

# most developers have uid/gid 1000, so try to create a "developer" user
#  to be used, that would work for most (approach similar to devstep Dockerfile)
#  also, enable tty-less sudo
RUN groupadd -g 1000 developer && \
    useradd developer -u 1000 -g 1000 && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    sed -i "s|^\(Defaults\s*requiretty.*\)|# \1|" /etc/sudoers

ADD . /srv/{{ topdir }}
WORKDIR /srv
RUN source {{ topdir }}-virtualenv/bin/activate && \
    pip install -r "{{ topdir }}/requirements.txt" && \
    sed -i "s|@PATHS@|`find $(pwd) -type d -path '*lib/*/site-packages'`|" {{ topdir }}/{{ topdir }}.conf && \
    cp {{ topdir }}/{{ topdir }}.conf /etc/httpd/conf.d

EXPOSE 80
RUN chown -R developer:developer /srv/{{ topdir }}
USER developer

# activate virtualenv, sync database, possibly remove leftover files from previous apache run
#  and then actually start apache
CMD source {{ topdir }}-virtualenv/bin/activate && \
    {{ topdir }}/manage.py syncdb --noinput && \
    sudo rm -rf /run/httpd/* && \
    sudo /usr/sbin/httpd -DFOREGROUND
