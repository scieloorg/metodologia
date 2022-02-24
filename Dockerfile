FROM centos:7
MAINTAINER Infrastructure SciELO <infra@scielo.org>

ENV INSTANCE_NAME scielo_br
ENV USER_SUPERVISOR root
ENV PASS_SUPERVISOR toor
ENV SITE_NAME www.scielo.br
ENV USER_FTP user_ftp
ENV PASSWD_FTP passwd_ftp
ENV USER_PASS scielo123
ENV GID 1000
ENV GIT_BRANCH_NAME scielo_scl

# Resolving dependencies from php 5.2.17.
RUN yum -y update && \
    yum install -y wget gcc libxml2-devel openssl openssl-devel openssl-libs curl libcurl-devel libjpeg-turbo-devel libpng-devel freetype-devel libxslt libxslt-devel expat-devel patch wget glibc.i686 zlib-devel curl-devel perl bzip2-devel.x86_64 openssh-server.x86_64 openssh-clients ftp rsync zip unzip glibc.i686 && \
    yum clean all

RUN yum install -y openssl098e-0.9.8e-20.el6.centos.1 autoconf automake && \
    yum clean all

RUN yum install -y epel-release libmcrypt-devel

# Downloading httpd 
RUN wget -O /usr/src/httpd-2.2.34.tar.gz  https://archive.apache.org/dist/httpd/httpd-2.2.34.tar.gz && \
    cd /usr/src && \
    tar -zxvf httpd-2.2.34.tar.gz 

# Configuring, compiling and installing
RUN cd /usr/src/httpd-2.2.34 && \
    ./configure --prefix=/usr --enable-layout=RedHat --enable-mods-shared=all && \
    make && make install

# Installing php 5.2.17 from source, uncompress
RUN wget -O /usr/src/php-5.2.17.tar.gz http://museum.php.net/php5/php-5.2.17.tar.gz && \
    cd /usr/src && \
    tar -zxvf php-5.2.17.tar.gz 

# Patching: https://stackoverflow.com/questions/28211039/phpbrew-5-3-10-build-error-dereferencing-pointer-to-incomplete-type/34107461
RUN cd /usr/src/php-5.2.17 && \
    curl -s https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt | patch -p0

# Compiling and installing php from source
RUN cd /usr/src/php-5.2.17 && \ 
    ./configure --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/usr/com --mandir=/usr/share/man --infodir=/usr/share/info --cache-file=../config.cache --with-libdir=lib64 --with-config-file-path=/etc --with-config-file-scan-dir=/etc/php.d --with-pic --disable-rpath --without-pear --with-bz2 --with-curl --with-exec-dir=/usr/bin --with-freetype-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --without-gdbm --with-gettext --with-iconv --with-jpeg-dir=/usr --without-openssl --with-zlib --with-layout=Redhat --enable-exif --enable-ftp --enable-magic-quotes --enable-sockets --enable-wddx  --without-mime-magic --without-sqlite --with-libxml-dir=/usr --with-apxs2=/usr/sbin/apxs --without-mysql --disable-dom --disable-dba --without-unixODBC --disable-pdo --disable-xmlreader --disable-xmlwriter --disable-json -with-xsl --enable-dom && \
   make && make install


#Install Supervisord
RUN yum -y install supervisor

# Creating sshd pid directory
RUN mkdir -p /var/run/sshd 

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Directory where application web and log will be save.
VOLUME /var/www/scielo
VOLUME /var/www/apache

# Create directory where virtual host will be save. Create directory scripts and supervisor log
RUN mkdir -p /etc/httpd/conf.d/vhosts \
    && mkdir /scripts \
    && touch /run/httpd.pid \
    && mkdir -p /var/log/supervisor

# Remove original httpd.conf file to accept new one.
RUN rm -f /etc/httpd/conf/httpd.conf

# copy http files
COPY conf/httpd.conf.template /etc/httpd/conf/httpd.conf 
COPY conf/vhosts.conf.template /etc/httpd/conf.d/vhosts/vhosts.conf 
COPY conf/virtual_host.conf.template /etc/httpd/conf.d/vhosts/virtual_host.conf 
COPY scripts/compacta_log.sh.template /scripts/compacta_log.sh 
COPY conf/supervisord.conf.template /etc/supervisord.conf
COPY conf/php.ini /etc/php.ini

## Suppress error message 'Could not load host key: ...'
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_dsa_key -C '' -N ''

# Avoiding error: Starting httpd: /usr/sbin/httpd: error while loading shared libraries: libapr-1.so.0: cannot open shared object file: No such file or directory 
RUN yum install -y apr-util

##Creating user and group do execute the container
RUN groupadd -f -g $GID scielo && \
    useradd -c "SciELO User" -u $GID -g scielo scielo && \
    echo "scielo:$USER_PASS" | chpasswd

RUN chown -R scielo.scielo /var/log/supervisor && \
    touch /var/run/supervisord.pid && \
    chown scielo.scielo /var/run/supervisord.pid && \
    chown scielo.scielo -R /etc/httpd && \
    chown scielo.scielo -R /var/log/httpd && \
    chown scielo.scielo -R /run/httpd.pid && \
    chown scielo.scielo -R /scripts && \
    chown scielo.scielo /etc/supervisord.conf && \
    chown scielo.scielo /var/run/sshd && \
    chown scielo.scielo /etc/pam.d/sshd && \
    chown scielo.scielo -R /etc/ssh  && \
    chown scielo.scielo -R /var/www 

RUN ln -s /var/log/httpd /etc/httpd/logs

EXPOSE 80
EXPOSE 22

COPY docker-entrypoint.sh /docker-entrypoint.sh

USER scielo

ENTRYPOINT ["/docker-entrypoint.sh"]
