#!/bin/bash
if [ "$SSMTP_HOSTNAME" != "" ]
then
  sed -i "/^#rewriteDomain=/c rewriteDomain=$SSMTP_HOSTNAME" /etc/ssmtp/ssmtp.conf
  sed -i "/^hostname=/c hostname=$SSMTP_HOSTNAME" /etc/ssmtp/ssmtp.conf
fi

if [ "$SSMTP_MAILHUB" != "" ]
then
  sed -i "/^mailhub=/c mailhub=$SSMTP_MAILHUB" /etc/ssmtp/ssmtp.conf
fi

if [ "$SSMTP_AUTHUSER" != "" ]
then
  echo "AuthUser=$SSMTP_AUTHUSER" >> /etc/ssmtp/ssmtp.conf
  echo "AuthPass=$SSMTP_AUTHPASSWD" >> /etc/ssmtp/ssmtp.conf
fi
