#!/bin/sh

# Configuring Apache to understand php extensions
echo '
<FilesMatch "\.php$">
   SetHandler application/x-httpd-php
</FilesMatch>
' >> /etc/httpd/conf/httpd.conf


HTTP_CONF_DIR="/etc/httpd/conf.d/vhosts/"
# Configuring Apache Virtual Host
if [ -f /etc/httpd/conf.d/vhosts/virtual_host.conf ]; then
    sed -i "s/SITE_NAME/$SITE_NAME/g" /etc/httpd/conf.d/vhosts/virtual_host.conf
    sed -i "s/USER_FTP/$USER_FTP/g" /etc/httpd/conf.d/vhosts/virtual_host.conf
else
    echo 'Error: File not exists or/and variable not specified'
fi

# Configuring Supervisor Config File
if [ -f /etc/supervisord.conf ]; then
    cp /etc/supervisord.conf /tmp
    sed -i "s/USER_SUPERVISOR/$USER_SUPERVISOR/g" /tmp/supervisord.conf
    sed -i "s/PASS_SUPERVISOR/$PASS_SUPERVISOR/g" /tmp/supervisord.conf
    cp /tmp/supervisord.conf /etc/supervisord.conf
else
    echo 'Error: File not exists or/and variables not specified'
fi    

# Configuring File the handle Apache logrotate file
if [ -f /scripts/compacta_log.sh ]; then
    sed -i "s/USER_FTP/$USER_FTP/g" /scripts/compacta_log.sh
    sed -i "s/PASSWD_FTP/$PASSWD_FTP/g" /scripts/compacta_log.sh
    sed -i "s/USER_SUPERVISOR/$USER_SUPERVISOR/g" /scripts/compacta_log.sh
    sed -i "s/PASS_SUPERVISOR/$PASS_SUPERVISOR/g" /scripts/compacta_log.sh
else
    echo 'Error: File not exists or/and variables not specified'
fi   

#Setting sshd
cp /etc/pam.d/sshd /tmp
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /tmp/sshd
cp /tmp/sshd /etc/pam.d/sshd

cp /etc/ssh/sshd_config /tmp/sshd_config
sed -i 's/#Port 22/Port 2222/g' /tmp/sshd_config
sed -i 's/#UsePrivilegeSeparation yes/UsePrivilegeSeparation no/g' /tmp/sshd_config
cp /tmp/sshd_config /etc/ssh/sshd_config

# Validating if the directory scielo is empty.
if [ ! -f /var/www/scielo/htdocs/versionOverview.txt ]; then
   cd /var/www
   wget https://github.com/scieloorg/Web/archive/$GIT_BRANCH_NAME.zip
   unzip $GIT_BRANCH_NAME.zip
   mv Web-$GIT_BRANCH_NAME/* scielo
   cd scielo
   mkdir bases bases-work serial
   cp -a bases_modelo/* bases
   cp -a bases-work_modelo/* bases-work
   cp -a serial_modelo/* serial
   cd proc
   wget ftp://produtos-scielo:produtos%40scielo@ftp.scielo.br/cisis-product/cisis-64bits-5.7c-lind.tar.gz
   tar -xvzf cisis-64bits-5.7c-lind.tar.gz
   cp cisis/wxis ../cgi-bin/wxis.exe
   chmod 755 ../cgi-bin/wxis.exe
   chown scielo.scielo -R /var/www/scielo
fi

# Configuring files on SciELO Methodology
if [ ! -f /var/www/scielo/htdocs/scielo.def.php ]; then
  mv  /var/www/scielo/htdocs/scielo.def.php.template /var/www/scielo/htdocs/scielo.def.php
  sed -i "s/vm.scielo.br/$SITE_NAME/g" /var/www/scielo/htdocs/scielo.def.php
  sed -i "s/\/home\/scielo\/www/\/var\/www\/scielo/g" /var/www/scielo/htdocs/scielo.def.php
fi

if [ ! -f /var/www/scielo/htdocs/iah/article.def ]; then
   mv /var/www/scielo/htdocs/iah/article.def.template /var/www/scielo/htdocs/iah/article.def
  sed -i "s/\/home\/scielo\/www/\/var\/www\/scielo/g" /var/www/scielo/htdocs/iah/article.def
fi 

if [ ! -f /var/www/scielo/htdocs/iah/iah.def ]; then
  mv  /var/www/scielo/htdocs/iah/iah.def.template /var/www/scielo/htdocs/iah/iah.def
  sed -i "s/www.scielo.br/$SITE_NAME/g" /var/www/scielo/htdocs/iah/iah.def
  sed -i "s/\/home\/scielo\/www/\/var\/www\/scielo/g" /var/www/scielo/htdocs/iah/iah.def
fi

if [ ! -f /var/www/scielo/htdocs/iah/title.def ]; then
   mv /var/www/scielo/htdocs/iah/title.def.template /var/www/scielo/htdocs/iah/title.def
  sed -i "s/\/home\/scielo\/www/\/var\/www\/scielo/g" /var/www/scielo/htdocs/iah/title.def
fi 

exec /usr/bin/supervisord "$@"
