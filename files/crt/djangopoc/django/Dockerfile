FROM centos:centos7

WORKDIR /srv
RUN yum -y install python-virtualenv httpd mod_wsgi postgresql-devel gcc && virtualenv "{{ topdir }}-virtualenv"

ADD . /srv/{{ topdir }}
WORKDIR /srv
RUN source {{ topdir }}-virtualenv/bin/activate && pip install -r "{{ topdir }}/requirements.txt"
RUN sed -i "s|@PATHS@|`find $(pwd) -type d -path '*lib/*/site-packages'`|" {{ topdir }}/{{ topdir }}.conf
RUN cp {{ topdir }}/{{ topdir }}.conf /etc/httpd/conf.d

EXPOSE 80
CMD source {{ topdir }}-virtualenv/bin/activate && {{ topdir }}/manage.py syncdb --noinput && /usr/sbin/httpd -DFOREGROUND
