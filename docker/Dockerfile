FROM ubuntu:20.04


RUN apt-get update && apt-get install vsftpd-y
RUN ["/bin/bash",'-c', 'useradd -m admin']
RUN  echo  "admin:password" | chpasswd

CMD ["/usr/sbin/vsftpd"]
