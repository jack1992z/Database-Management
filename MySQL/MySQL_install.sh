
#!/bin/bash
binDir='/usr/local/mysql'
dataDir='/bigdata/mysql/mysqldata'
mysqlPassword='CDE#4rfv@'

BASE=$(cd `dirname $0` && pwd)
cd $BASE

release=$(uname -r |awk -F'.' '{print $4}')
if ["X${relase}" != 'Xel7' ];then
   echo "[ERROR] OS version: ${release}, Non-EL7, exit the installation"
   exit 1
fi

keyword='/mysql'
if ! echo "${binDir}" |grep ${keyword} &>/dev/null;then
   echo "[ERROR] ${binDir} Misconfigured, ${keyword} is not included."
   exit 1
fi

if ! echo "${dataDir}" |grep ${keyword} &>/dev/null; then
  echo "[ERROR] ${dataDir} Misconfigured, ${keyword} is not included."
  exit 1
fi

echo "[INFO] Stop the MySQL process and clean up the directory:  ${binDir}, ${dataDir}..."
service mysql stop &>/dev/null
test -d ${binDir} && rm -rf ${binDir}
test -d ${dataDir} && rm -rf ${dataDir}

echo "[INFO] start tar MySQL package, please wait ..."
tar zxf mysql-5.7.25-linux-glibc2.12-x86_64.tar.gz && mv mysql-5.7.25-linux-glibc2.12-x86_64 ${binDir}

echo "[INFO] create MySQL group and user ..."
groupadd mysql 2>/dev/null
useradd -r -g mysql mysql 2>/dev/null

echo "[INFO] create a MySQL data directory ..."
mkdir -p ${dataDir} && chown -R mysql:mysql ${dataDir}
chown -R mysql:mysql ${binDir}

echo "[INFO] creat MySQL profiles:/etc/my.cnf ..."
cat >/etc/my.cnf <<EOF
[mysqld]
character-set-server=utf8
server-id = 1
lower_case_table_names=1
basedir=${binDir}
datadir=${dataDir}
user=mysql
symbolic-links=0
federated
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

[client]
default-character-set=utf8

[mysqld_safe]
default-storage-engine=INNODB
character-set-server=utf8
collation-server=utf8_general_ci
EOF

echo "[INFO] init MySQL ..."
${binDir}/bin/mysld --default-file=/etc/my.cnf=/etc/my.cnf --basedir=${binDir} --dataDir=${dataDir} --user=mysql --initialize-insecure

echo "[INFO] add the MySQL service,and boot up ..."
ln -sf ${binDir}/bin/mysql /usr/local/bin/mysql
ln -sf ${binDir}/support-files/mysql.server /etc/init.d/mysql
/usr/bin/systemctl enable mysql

echo "[INFO] start MySQL service ..."
service mysql start
if [$? -ne 0 ];then
   echo "[ERROR] MySQL fails to start, check the mysql logs: .err file in ${dataDir} "
   exit 2
fi

echo "[INFO] change MySQL user password ..."
${binDir}/bin/mysql -uroot <<EOF
SET PASSWORD = PASSWORD('${mysqlPassword}');
ALTER USER 'root'@'localhost' PASSWORD EXPIRE NEVER;
create database hive;
create database range;
create user 'hive' identified by '123456@';
grant all on *.* to hive@'%' indentified by '123456@';
grant all on *.* to root@'%' identified by '123456@';
UPDATE mysql.user SET Grant_priv='Y',Super_priv='Y' WHERE User='root';
FLUSH PRIVILEGES;
EOF

echo "[INFO] install complete"
exit 0