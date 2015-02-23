#!/bin/bash
# quizas seria buena meter las variables featuresBoot and repositoriesBoot 
#cp /esb/org.apache.karaf.features.cfg.tpl /servicemix/etc/
#envtpl /servicemix/etc/org.apache.karaf.features.cfg.tpl 

# This script will install the requested features. 

cp /esb/org.apache.servicemix.nmr.cfg.tpl /servicemix/etc/
cp /esb/org.apache.servicemix.jbi.cfg.tpl /servicemix/etc/
cp /esb/users.properties.tpl /servicemix/etc/
cp /esb/setenv.tpl /servicemix/bin/
envtpl /servicemix/etc/org.apache.servicemix.nmr.cfg.tpl 
envtpl /servicemix/etc/org.apache.servicemix.jbi.cfg.tpl
envtpl /servicemix/etc/users.properties.tpl
envtpl /servicemix/bin/setenv.tpl
echo "ServiceMix starting..."
/servicemix/bin/servicemix server 


