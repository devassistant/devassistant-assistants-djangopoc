#!/bin/bash

# initialize the database
/usr/bin/initdb -D /var/lib/pgsql/data

# launch postgres to create DB and user and give user privileges to the DB
/usr/bin/postgres -D /var/lib/pgsql/data -p 5432 &
sleep 5

# create a database and a user
createdb {{ name }}

psql -U postgres postgres <<EOF
CREATE USER {{ name }} password 'password';
GRANT ALL PRIVILEGES ON DATABASE {{ name }} TO {{ name }};
EOF

# set permissions to allow logins, trust the bridge
echo "host    all             all             0.0.0.0/0               trust" >> /var/lib/pgsql/data/pg_hba.conf

# listen on all interfaces
echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf
