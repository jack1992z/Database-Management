
# 1. install
sudo apt install postgresql
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh


Import the repository signing key:
sudo apt install curl ca-certificates
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

sudo apt-get update
sudo apt-get install postgresql postgresql-client

Linux:
sudo -i -u postgres
psql

windows:
Program Files ->  PostgreSQL 12.3 -> SQL Shell(psal)

start stop restart:
sudo /etc/init.d/postgresql start
sudo /etc/init.d/postgresql stop
sudo /etc/init.d/postgresql restart


help
\h for help with SQL commands
\? for help with psql commands
\g  or terminate with semicolon to execute query
\p to quit

select usename,passwd
from pg_shadow
where ueesname = 'postgres';

-- change password
alter user postgres with password 'new_password';

