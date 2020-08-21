#!/bin/sh
# This is a comment!
yum install httpd -y
systemctl start httpd
systemctl enable httpd
mkdir -p /home/simple

