What is methodology SciELO?
============================
The methodology SciELO is a Web Server application using Apache with php 5.2.17 version and also sshd service. Both services are handled by [supervisor](http://supervisord.org/). Once running this container the website SciELO methodology will be contructed and ready to be processed and feed by new bases/periodics and journals.

How to use this image
=======================
Start a methodology SciELO server instance
------------------------------------------

Before running your first methodology SciELO instace is important to choose where data and log directory will be located. Follow the sample:
```
#mkdir /dados
#cd /dados
#mkdir scielo
#mkdir logs
```
In our follow hypothetical example we will consider that /dados is the directory where will be storage our methodology and logs.

Starting a methodology SciELO is simple:
```
docker run --name some-scielo \
       -v /dados/scielo:/var/www/scielo 
	   -v /dados/logs:/var/www/apache 
	   --env INSTANCE_NAME=scielo_ecu 
	   --env USER_SUPERVISOR=root 
	   --env PASS_SUPERVISOR=toor  
	   --env SITE_NAME=www.scielo.ecu 
	   --env USER_FTP=teste 
	   --env PASSWD_FTP=teste 
	   --env USER_PASS=scielo 
	   --env GIT_BRANCH_NAME=scielo_scl 
	   -p 80:80 
	   -p 2222:2222 
	   -d infrascielo/classic-site
```

Environment Variables
=====================
When you start the methodology image, you can adjust the configuration of the methodology instance by passing one or more environment variables on the docker run command line. Do note that none of the variables below will have any effect if you start the container with a data directory that already contains a web structure: any pre-existing web structure will always be left untouched on container startup.

INSTANCE_NAME
-------------
This variable define the log's name and it reflect in some script that compact logs


USER_SUPERVISOR
---------------
This variable define which user can be use to manage supervisor daemon via web

PASS_SUPERVISOR
---------------
This variable define which password belong to user set on variable USER_SUPERVISOR

SITE_NAME 
---------
Very explicit meaning. Define domain site and is used by Apache virtual host and scielo.def.php (methodology config inc)

USER_FTP
--------
Used by compacta_log.sh script to send logs to remote ftp server. This user must be required to SciELO Dev Team.

PASSWD_FTP
----------
Password user by USER_FTP to send compacted apache logs.

GIT_BRANCH_NAME
---------------
This variable define which git branch will be used. Go in https://github.com/scieloorg/Web/branches and choose the correct branch from your Organization (SciELO TI Team can help you with this task)

Important issue
===============
When the container is running, it is important to change the default password from main user called scielo. 
```
docker exec -it <container name>  bash
$ passwd
(current) UNIX password: <type scielo123> 
New password: <type the new password>
Retype new password: <retype>
passwd: all authentication tokens updated successfully.
```

Issues:
========
if you have any problem and/or suggestions please let's us know. Contact us through [Github Issues](https://github.com/scieloorg/metodologia/issues). Contributions are always welcome!
