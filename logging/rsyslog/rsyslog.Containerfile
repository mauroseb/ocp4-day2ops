FROM registry.redhat.io/rhel8/rsyslog:latest

MAINTAINER Mauro Oddi <mauro.oddi@gmail.com>

LABEL maintainer="mauro.oddi@gmail.com" name="rsyslog" build-date="02-09-2022" version=0.1.0

ADD rsyslog.conf /etc/rsyslog.conf
ADD rsyslog.Containerfile /

EXPOSE 1514/tcp
