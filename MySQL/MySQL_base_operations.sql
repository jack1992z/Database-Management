-- mysql -h {hostip} -uUser -pPassword
mysql -h127.0.0.1 -u root -p 123;
EXIT;

-- select dinstinct .. from  .. join ..on ..where ..group by ..having ..order by ..limit ...
-- expalin: from  ..on ..join ..where ..group by ..having ..select dinstinct ..order by ..limit..




show DATABASES;
use mysql;
show tables;
describe mysql;
create database superset;
drop database superset;
delete from employees.salaries;
select * from superset.event;
insert into superset.adj_factor_qfq values('leod',2,'apple');
update mysql.user set password=PASSWORD('newPassword') where user='root';
flush  privileges;

mysqldump -u root -p --opt superset>supersetBAK; 







-- 1. tb describe 
describe user;
select version();
select database();
select * from db\G; 

-- 2.create database table 
create database auth;
use auth;s
create table users(user_name char(16) not null,user_passwd char(48) default '',primary key (user_name));

drop table auth.users;
drop database auth;

insert into users(user_name,user_passwd) values('jack',PASSWORD('6666@'));
describe users;
insert int users value('jake',PASSWORD('88888'));
select * from auth.users;
select user_name,user_passwd from auth.users where user_name='jacktian';
update auth.users set user_passwd = PASSWORD('') where user_name ='jake';
select * from auth.users;

use mysql;
show tables;
update mysql.user set password=password ('666666') where user= 'root';
delete from auth.users where user_name = 'jake';
select user,host,password from mysql.user where user = '';
delete from mysql.user where user = '';
select user,host,password from mysql.user where user = '';


-- 3.lock
select ... for update; -- row lock 
select ... lock in share mode;

select * from information_schema.innodb_trx\G; 
select * from information_schema.innodb_locks\G; 

select * from information_schema.innodb_lock_waits\G; 

select * from sys.innodb_lock_waits\G;

show engine innodb status\G;

select * from  performance_schema.events_statements_current\G; 
show full processlist;

show variables like '%dead%';
show variables like 'innodb_flush_log_trx_commit';
show variables like '%undo%';
select 1073741824/1024/1024;

-- innodb_undo_directory set rollback segment file dir
-- innodb_undo_logs set rollback segment num , default 128
-- innodb_undo_tablespaces  defualt 0, after init not change 

-- 4.ddl Implicitly committed SQL statements
--ddl:
-- alter database, update data directory name, alter event, alter procedure, alter table,
-- alter view , create database,create event,create trigger,create view,
-- drop database,drop event,drop index,drop procedure,drop table,drop trigger,drop view
-- rename table,truncate table

-- Manage statements:
-- analyze table , cache index,check table,
-- load index into cache,optimeize table , repair table 


--5. transaction
-- read uncommitted,  read committed, repeatable read, serializable


-- 6.grant
grant select on auth.* to 'xiaojack'@'localhost' identified by '123.com';
create database mongodb;
grant all on mongodb.* to 'dbuser'@'127.0.0.1' identified by 'pwd@123.com';
show grants for 'dbuser'@'127.0.0.1';
revoke all on auth.* from 'xiaojack'@'localhost';
show grants for 'dbuser'@'127.0.0.1';

---6 sql optimize
select id from dynamic order by rand() limit 1000;
--optimize
select id from dynamic t1 join (select rand() * (select max(id) from dynamic) as nid) t2 on t1.id > t2.nid limit 1000;


select col1 from ta as a where a.id not in (select b.id from tb);
--optimize
select col1 from ta as a left join tb as b on a.id = b.id where b.id is null;

select id,name from product limit 866613, 20
-- optimize
select id,name from product where id> 866612 limit 20

ALTER TABLE `dynamic_201606` ADD FULLTEXT INDEX `idx_user_name` (`user_name`);
--optimize
select id,fnum,fdst from dynamic_201606 where match(user_name) against('zhangsan' in boolean mode);

select user_id,user_project from user_base where age*2=36;
-- optimize
select user_id,user_project from user_base where age=36/2;


select * from A left join B on B.name = A.namewhere B.name is null union all select * from B;



create TABLE user_index(
    id int auto_increment primary key,
    first_name varchar(16),
    last_name VARCHAR(16),
    id_card VARCHAR(18),
    information text
);
alter table user_index
add key name (first_name,last_name),
add UNIQUE KEY (id_card),
add FULLTEXT KEY (information);

show create table user_index：

-- create unique index name_index on tb(name);
-- alter table tb add unique index name_index(name);
-- alter table tb add index dept_name_index(dept,name)
-- drop index name_index on tb;
-- show index from tb;




CREATE TABLE user_index2 (
    id INT auto_increment PRIMARY KEY,
    first_name VARCHAR (16),
    last_name VARCHAR (16),
    id_card VARCHAR (18),
    information text,
    KEY name (first_name, last_name),
    FULLTEXT KEY (information),
    UNIQUE KEY (id_card)
);
alter table user_index drop KEY name;
alter table user_index drop KEY id_card;
alter table user_index drop KEY information;

alter table user_index
MODIFY id int,
drop PRIMARY KEY

CREATE TABLE innodb1 (
    id INT auto_increment PRIMARY KEY,
    first_name VARCHAR (16),
    last_name VARCHAR (16),
    id_card VARCHAR (18),
    information text,
    KEY name (first_name, last_name),
    FULLTEXT KEY (information),
    UNIQUE KEY (id_card)
);
insert into innodb1 (first_name,last_name,id_card,information) values ('zhan','san','1001','HuaShanPai');
expalin select * from innodb1 where id < 20;

-- 增加一个没有建立索引的字段
alter table innodb1 add sex char(1);
EXPLAIN SELECT * from innodb1 where sex='male';

select * from user where id = 20-1;
select * from user where id+1 = 20;

select * from article where title like '%mysql%';
select * from article where title like 'mysql%';

alter table person add index(first_name,last_name);

show variables like 'query_cache_type';
show variables like 'query_cache_size';
set global query_cache_size=64*1024*1024;
show variables like 'query_cache_size';

select sql_cache * from user;
reset query cache;


create table article(
    id int auto_increment PRIMARY KEY,
    title varchar(64),
    content text
)PARTITION by HASH(id) PARTITIONS 10

create table article_key(
    id int auto_increment,
    title varchar(64),
    content text,
    PRIMARY KEY (id,title)  --  
)PARTITION by KEY(title) PARTITIONS 10

create table article_range(
    id int auto_increment,
    title varchar(64),
    content text,
    created_time int,   -- 
    PRIMARY KEY (id,created_time)   --  
)charset=utf8
PARTITION BY RANGE(created_time)(
    PARTITION p201808 VALUES less than (1535731199),    -- select UNIX_TIMESTAMP('2018-8-31 23:59:59')
    PARTITION p201809 VALUES less than (1538323199),    -- 2018-9-30 23:59:59
    PARTITION p201810 VALUES less than (1541001599) -- 2018-10-31 23:59:59
);

insert into article_range values(null,'MySQL优化','内容示例',1535731180);
flush tables; 

create table article_list(
    id int auto_increment,
    title varchar(64),
    content text,
    status TINYINT(1),  -- 0- 1 -2
    PRIMARY KEY (id,status) --
)charset=utf8
PARTITION BY list(status)(
    PARTITION writing values in(0,1),   --
    PARTITION published values in (2)   --
);
insert into article_list values(null,'mysql优化','内容示例',0);
flush tables;

alter table article_range add partition(
    partition p201811 values less than (1543593599) -- select UNIX_TIMESTAMP('2018-11-30 23:59:59')
    -- more
);

alter table article_range drop PARTITION p201808;
alter table article_key coalesce partition 6



-- install
'''
tar xzvf mysql-5.7.23-linux-glibc2.12-x86_64.tar.gz -C /export/server
cd /export/server
mv mysql-5.7.23-linux-glibc2.12-x86_64 mysql
groupadd mysql
useradd -r -g mysql mysql
cd /export/server
chown -R mysql:mysql mysql/
chmod -R 755 mysql/

mkdir /export/data/mysql

#init
cd /export/server/mysql
./bin/mysqld --basedir=/export/server/mysql --datadir=/export/data/mysql --u

set my.cnf
vim /etc/my.cnf
[mysqld]
basedir=/export/server/mysql
datadir=/export/data/mysql
socket=/tmp/mysql.sock
user=mysql
server-id=10 # 服务id，在集群时必须唯一，建议设置为IP的第四段
port=3306
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd

[mysqld_safe]
log-error=/export/data/mysql/error.log
pid-file=/export/data/mysql/mysql.pid

#
# include all files from the config directory
#
!includedir /etc/my.cnf.d

cp /export/server/mysql/support-files/mysql.server /etc/init.d/mysqld

service mysqld start


set profile:
/etc/profile
# mysql env
MYSQL_HOME=/export/server/mysql
MYSQL_PATH=$MYSQL_HOME/bin
PATH=$PATH:$MYSQL_PATH
export PATH

sudo source /etc/profile

mysql -uroot -p

set password=password('root');
flush privileges;

use mysql;
update user set host='%' where user='root';
flush privileges;


Configure the master-slave nodes:
set master my.cnf:
[mysqld]
basedir=/export/server/mysql
datadir=/export/data/mysql
socket=/tmp/mysql.sock
user=mysql
server-id=10
port=3306
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd

log-bin=mysql-bin    # 开启二进制日志
expire-logs-days=7  # 设置日志过期时间，避免占满磁盘
binlog-ignore-db=mysql    # 不使用主从复制的数据库
binlog-ignore-db=information_schema
binlog-ignore-db=performation_schema
binlog-ignore-db=sys
binlog-do-db=test    #使用主从复制的数据库

[mysqld_safe]
log-error=/export/data/mysql/error.log
pid-file=/export/data/mysql/mysql.pid

#
# include all files from the config directory
#
!includedir /etc/my.cnf.d

restart master:
service mysqld restart
show variables like 'log_bin';

grant replication slave on *.* to 'backup'@'%' identified by '1234'

use mysql;
select user,authentication_string,host from user;

CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) CHARSET=utf8;

service mysqld restart


mysqldump -uroot -proot -hlocalhost test > /export/data/test.sql
set slave:
slave my.ini   [mysqld]:
log-bin=mysql
server-id=1 # 192.168.19.1

show VARIABLES like 'log_bin';

Configure synchronous replication with the master:
stop slave; 
change master to
    master_host='192.168.19.10',    -- master IPC 
    master_user='backup',            -- master user 
    master_password='1234',
    master_log_file='mysql-bin.000002', -- master上 show master status \G 
    master_log_pos=154;

start slave node, show status:
start slave;
show slave status \G


unlock tables;
use test
insert into article (title,content) values ('mysql master and slave','record the cluster building succeed!:)');

insert into article (title,content) values ('mysql master and slave','record the cluster building succeed!:)');


show slave status;


set profiling=on;
show variables like 'profiling';
insert into article values (null,'test profile',':)');
show profiles;
show variables like 'max_connections';
show variables like 'table_open_cache';
show variables like 'key_buffer_size';
show variables like 'innodb_buffer_pool_size';



mysqlslap --auto-generate-sql -uroot -proot
mysqlslap --auto-generate-sql --concurrency=100 -uroot -proot
mysqlslap --auto-generate-sql --concurrency=150 -uroot -proot
mysqlslap --auto-generate-sql --concurrency=150 --iterations=10 -uroot -proot
mysqlslap --auto-generate-sql --concurrency=150 --iterations=3 --engine=innodb -uroot -proot
mysqlslap --auto-generate-sql --concurrency=150 --iterations=3 --engine=myisam -uroot -proot


--- mysql -u root --host=127.0.0.1 --port=3307 -e 'SELECT VERSION();'
--- mysql -u root --host=127.0.0.1 --port=3306 -e 'CREATE DATABASE pymysqlreplication_test;'
--- mysql -u root --host=127.0.0.1 --port=3307 -e "CREATE DATABASE pymysqlreplication_test;"

'''










