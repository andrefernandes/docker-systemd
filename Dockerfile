
FROM andrefernandes/docker-centos7-base:latest

MAINTAINER Andre Fernandes

# swaps fakesystemd for systemd in a Docker-safe way
# see http://jperrin.github.io/centos/2014/09/25/centos-docker-and-systemd/
ENV container docker

# assim tem que ser privileged
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs; yum clean all; \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
#VOLUME ["/run"]

CMD ["/usr/sbin/init"]
#CMD  ["/usr/lib/systemd/systemd"]
