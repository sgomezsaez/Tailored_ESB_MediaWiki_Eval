#!/bin/bash

# Install java

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get install python-software-properties -y

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
apt-add-repository -y ppa:webupd8team/java
apt-get install -y oracle-java7-installer

# Install maven

apt-get install maven -y

# Install curl

apt-get install curl openssh-server sshpass -y

# Install python tool for ENV variables

apt-get -y install python-pip
pip install envtpl

# Install servicemix

mkdir /servicemix

curl $SERVICEMIX_PKG_URL | tar -xvz -C /servicemix --strip=1

mkdir /esb

cp org.apache.karaf.features.cfg /servicemix/etc/
cp org.apache.servicemix.nmr.cfg.tpl /esb/
cp org.apache.servicemix.jbi.cfg.tpl /esb/
cp users.properties.tpl /esb/
cp setenv.tpl /esb/
cp run.sh /esb/
cp installer.sh /esb/

chmod +x /esb/installer.sh
chmod +x /esb/run.sh

sh /esb/installer.sh
