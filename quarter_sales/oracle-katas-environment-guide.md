# Oracle environment for katas

This is a guide to setup an environemnt suitable for Oracle database katas.

## Install vagrant

https://www.vagrantup.com/docs/installation/

## Using a vagrant box

Choose a home directory for the katas, for example :

```
SQL_KATA_HOME=~/katas/sql
mkdir -p ${SQL_KATA_HOME}
cd ${SQL_KATA_HOME}
```

Create in this directory a file named Vagrantfile with the following content :

```
Vagrant.configure(2) do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "danmikita/centos"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 1521, host: 1521

end
```

Startup the vagrant vm:
```
vagrant up
```

## Setup the vm

### Install utPLSQL

Download at http://sourceforge.net/projects/utplsql/files/
into ${SQL_KATA_HOME}/utplsql

Login to the running vm:
```
vagrant ssh
```

Then log in with oracle user
```
sudo su -
su - oracle
```
Set up Oracle environment variables

```
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export PATH=$PATH:$ORACLE_HOME/bin
```

#### Create user

login to SQL*Plus
```
sqlplus / as sysdba
```

and issue the following statements:
```
create user utp identified by utp default tablespace
  users temporary tablespace temp;

grant create session, create table, create procedure,
  create sequence, create view, create public synonym,
  drop public synonym to utp;

alter user utp quota unlimited on users;

grant execute on utl_file to utp;

exit
```

*Alternatively utPLSQL may be installed in SYSTEM schema*

#### Install

cd to the utPLSQL storing the source files, startup SQL*Plus as user UTP, run the install script :

```
cd ${SQL_KATA_HOME}/utplsql/code
sqlplus utp/utp
SQL> @ut_i_do install
exit
```

### Environment files for user vagrant

Logout from the vm and login again as vagrant user
```
vagrant ssh
```

Make sure the file _/u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh_ exists and contains the following :

```
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export PATH=$ORACLE_HOME/bin:$PATH
```

Make sure the following is part of the ~/.bash_profile
```
if [ -f /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh ]; then
	. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
fi
```

### Working with a kata

Clone a kata in ${SQL_KATA_HOME}
```
git clone git@github.com:smorineau/fizzbuzz.git
```

Access the VM and cd to the kata files location.
Shared folders in vagrant map the host folder holding the Vagrantfile with the guest folder /vagrant. The host folder _${SQL_KATA_HOME}/fizzbuzz_ should be visible from the guest at location _/vagrant/fizzbuzz_
```
vagrant ssh
cd /vagrant/fizzbuzz
```

You may test if everything is setup correctly by running the tests :
```
make test
```
