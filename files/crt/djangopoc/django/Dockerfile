FROM fedora

WORKDIR /srv
RUN yum install python-virtualenv && virtualenv "{{ topdir }}"

WORKDIR /srv/{{ topdir }}
ADD . /srv/{{ topdir }}/{{ topdir }}
RUN source bin/activate && pip install -r "{{ topdir }}/requirements.txt"

EXPOSE 8000
CMD source /srv/{{ topdir }}/bin/activate && \
 /srv/{{ topdir }}/{{ topdir }}/manage.py runserver 0.0.0.0:8000
