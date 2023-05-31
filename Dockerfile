FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum update -y && yum install httpd curl wget unzip -y

MAINTAINER nithin

EXPOSE 80

WORKDIR /var/www/html/

RUN rm -rf *

ADD https://www.free-css.com/assets/files/free-css-templates/download/page288/convid.zip .

RUN unzip convid.zip

RUN mv html/* .

RUN systemctl start httpd

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
