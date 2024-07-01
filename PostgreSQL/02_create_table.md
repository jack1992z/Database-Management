
create table customer(
    id serial,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50)
);

-- 1. insert data
COPY customer FROM '/home/data/customer.csv' DELIMITER ',' CSV HEADER;
COPY customer(first_name,last_name,email) FROM '/home/data/customers1.csv' DELIMITER ',' CSV HEADER;

-- 2. insert data
pg_dump -d postgres -t customer > /tmp/customer.sql
pg_dump -d postgres -t customer -F t  > /tmp/customer.tar

psql -d postgres < /tmp/customer.sql
pg_restore -d postgres -t customer /tmp/customer.tar

-- 3. insert data
use Arctype UI
