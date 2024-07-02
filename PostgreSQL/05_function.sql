-- Active: 1719589117756@@127.0.0.1@5432@postgres@publics

-- 1. create table
create table sensor_stat(  
  sid int,             -- 传感器ID  
  state boolean,       -- 传感器状态，true在线，false离线  
  crt_time timestamp   -- 状态上传时间  
);  

create index idx_sensor_stat_1 on sensor_stat(sid, crt_time desc); 

-- 2.insert into data  1.0l billon /hour
insert into sensor_stat select random()*1000, (random()*1)::int::boolean, clock_timestamp() from generate_series(1,110100000); 

-- 3.etl
create table sensor_stat1 (
  sid int,             -- 传感器ID
  state boolean,       -- 传感器状态，true在线，false离线
  crt_time timestamp   -- 状态上传时间
);

create table sensor_stat2 (
  sid int,             -- 传感器ID
  state boolean,       -- 传感器状态，true在线，false离线
  crt_time timestamp   -- 状态上传时间
);


/*
X86
15TB

1. CENTOS 6.x x64
2 .xfs
3. PostgreSQL 

./configure --prefix=/home/digoal/pgsql9.5.1 --with-blocksize=32 --with-segsize=128 --with-wal-blocksize=32 --with-wal-segsize=64  
make && make install


listen_addresses = '0.0.0.0'            # what IP address(es) to listen on;
fsync=on
port = 1921                             # (change requires restart)
max_connections = 600                   # (change requires restart)
superuser_reserved_connections = 13     # (change requires restart)
unix_socket_directories = '.'   # comma-separated list of directories
unix_socket_permissions = 0700          # begin with 0 to use octal notation
tcp_keepalives_idle = 60                # TCP_KEEPIDLE, in seconds;
tcp_keepalives_interval = 10            # TCP_KEEPINTVL, in seconds;
tcp_keepalives_count = 10               # TCP_KEEPCNT;
shared_buffers = 256GB                   # min 128kB
huge_pages = on                 # on, off, or try
work_mem = 512MB                                # min 64kB
maintenance_work_mem = 1GB              # min 1MB
autovacuum_work_mem = 1GB               # min 1MB, or -1 to use maintenance_work_mem
dynamic_shared_memory_type = posix      # the default is the first option
bgwriter_delay = 10ms                   # 10-10000ms between rounds
bgwriter_lru_maxpages = 1000            # 0-1000 max buffers written/round
bgwriter_lru_multiplier = 2.0
synchronous_commit = off                # synchronization level;
full_page_writes = on                  # recover from partial page writes
wal_buffers = 2047MB                    # min 32kB, -1 sets based on shared_buffers
wal_writer_delay = 10ms         # 1-10000 milliseconds
checkpoint_timeout = 55min              # range 30s-1h
max_wal_size = 512GB
checkpoint_completion_target = 0.9      # checkpoint target duration, 0.0 - 1.0
effective_cache_size = 40GB
log_destination = 'csvlog'              # Valid values are combinations of
logging_collector = on          # Enable capturing of stderr and csvlog
log_directory = 'pg_log'                # directory where log files are written,
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log' # log file name pattern,
log_file_mode = 0600                    # creation mode for log files,
log_truncate_on_rotation = on           # If on, an existing log file with the
log_checkpoints = off
log_connections = off
log_disconnections = off
log_error_verbosity = verbose           # terse, default, or verbose messages
log_timezone = 'PRC'
log_autovacuum_min_duration = 0 # -1 disables, 0 logs all actions and
datestyle = 'iso, mdy'
timezone = 'PRC'
lc_messages = 'C'                       # locale for system error message
lc_monetary = 'C'                       # locale for monetary formatting
lc_numeric = 'C'                        # locale for number formatting
lc_time = 'C'                           # locale for time formatting
default_text_search_config = 'pg_catalog.english'
autovacuum=off

*/

select string_agg(i,'') from (select md5(random()::text) i from generate_series(1,10) t(i)) t(i)

create unlogged table test(crt_time timestamp, info text default '53d3ec7adbeacc912a45bdd8557b435be848e4b1050dc0f5e46b75703d4745833541b5dabc177db460b6b1493961fc72c478daaaac74bcc89aec4f946a496028d9cff1cc4144f738e01ea36436455c216aa697d87fe1f87ceb49134a687dc69cba34c9951d0c9ce9ca82bba229d56874af40498dca5f
d8dfb9c877546db76c35a3362d6bdba6472d3919289b6eaeeab58feb4f6e79592fc1dd8253fd4c588a29');

alter table test alter column info set storage plain;
insert into test select now() from generate_series(1,1000);
select ctid from test limit 1000;


/*
do language plpgsql
$$

declare
i int;
sql text;
begin
  for i in 1..42 loop
    sql := 'create unlogged table test'||i||' (like test including all) tablespace tbs1';
    execute sql;
    sql := 'create index idx_test'||i||' on test'||i||' using brin (crt_time) with (pages_per_range=512) tablespace tbs1';
    execute sql;
  end loop;
  for i in 43..84 loop
    sql := 'create unlogged table test'||i||' (like test including all) tablespace tbs2';
    execute sql;
    sql := 'create index idx_test'||i||' on test'||i||' using brin (crt_time) with (pages_per_range=512) tablespace tbs2';
    execute sql;
  end loop;
  for i in 85..128 loop
    sql := 'create unlogged table test'||i||' (like test including all) tablespace tbs3';
    execute sql;
    sql := 'create index idx_test'||i||' on test'||i||' using brin (crt_time) with (pages_per_range=512) tablespace tbs3';
    execute sql;
  end loop;
end;

$$
;

vi test.sql
insert into test(crt_time) values (now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()),(now()); 

for ((i=1;i<=128;i++)) do sed "s/test/test$i/" test.sql > ./test$i.sql; done
do language plpgsql
$$

declare
i int;
sql text;
begin
  for i in 1..128 loop
    sql := 'truncate test'||i;
    execute sql;
  end loop;
end;

$$
;
*/


/*
vi test.sh
#!/bin/bash

if [ $# -ne 5 ]; then
  echo "please use: $0 ip port dbname user pwd"
  exit 1
fi

IP=$1
PORT=$2
DBNAME=$3
USER=$4
PASSWORD=$5

export PGPASSWORD=$PASSWORD

DEP_CMD="psql"
which $DEP_CMD
if [ $? -ne 0 ]; then
  echo -e "dep commands: $DEP_CMD not exist."
  exit 1
fi

truncate() {
psql -h $IP -p $PORT -U $USER $DBNAME <<EOF
do language plpgsql \$\$
declare
i int;
sql text;
begin
  for i in 1..128 loop
    sql := 'truncate test'||i;
    execute sql;
  end loop;
end;
\$\$;
checkpoint;
\q
EOF
}

# truncate data first
truncate

START=`date +%s`
echo "`date +%F%T` $START"

for ((x=1;x>0;x++))
do
# ------------------------------------------------------
echo "Round $x test start: `date +%F%T` `date +%s`"

for ((i=1;i<=128;i++))
do
  pgbench -M prepared -n -r -f ./test$i.sql -h $IP -p $PORT -U $USER $DBNAME -c 1 -j 1 -t 1572864 >>./$i.log 2>&1 & 
done

wait
echo "Round $x test end: `date +%F%T` `date +%s`"
# ------------------------------------------------------

if [ $((`date +%s`-$START)) -gt 86400 ]; then
  echo "end `date +%F%T` `date +%s`"
  echo "duration second: $((`date +%s`-$START))"
  exit 0
fi

echo "Round $x test end, start truncate `date +%F%T` `date +%s`"
truncate
echo "Round $x test end, end truncate `date +%F%T` `date +%s`"

done

nohup ./test.sh xxx.xxx.xxx.xxx 1921 postgres postgres postgres >./test.log 2>&1 &


*/
select min(crt_time),max(crt_time) from test1;


--------------------------------------------------


select
  depname,
  empno,
  salary,
  avg(salary) over (partition by depname) as avg_salary
from empsalary;

select
  depname,
  empno,
  salary,
  rangk() over(partition by depname order by salary desc)
from empsalary;

select
  salary,
  sum(salary) over() as sum_salary
from empsalary;

select
  salary,
  sum(salary) over(order by salary) as sum_salary
from empsalary;

select
  depname,
  empno,
  salary,
  enroll_date
from (
    select depname,empno,salary,enroll_date,
           rank() over(partition by depname order by salary desc,empno) as pos
    from empsalary
)as t
where pos < 3;

select
  sum(salary) over w,
  avg(salary) over w,
from empsalary
window w as (paritition by depname order by salary desc);





















