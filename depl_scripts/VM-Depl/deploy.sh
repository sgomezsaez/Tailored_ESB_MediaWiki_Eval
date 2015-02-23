#!/bin/bash

IPADD=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

# Calculation of Sys Memory
MAX_MEM_ESB_PERCENTAGE=80
MIN_MEM_ESB_PERCENTAGE=25
MEM_METRIC="M"
SYS_MEMORY_TOTAL=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')
MAX_MEMORY_ESB=$(($MAX_MEM_ESB_PERCENTAGE*$SYS_MEMORY_TOTAL))
MAX_MEMORY_ESB_BYTES=$(bc <<< "scale = 2; $MAX_MEMORY_ESB / 100")
MAX_MEMORY_ESB_MBYTES=$(bc <<< "scale = 2; $MAX_MEMORY_ESB_BYTES / 1024")
MAX_MEMORY_ESB_MBYTES=$(echo $MAX_MEMORY_ESB_MBYTES | awk '{print int($MAX_MEMORY_ESB_MBYTES+0.5)}')

MIN_MEMORY_ESB=$(($MIN_MEM_ESB_PERCENTAGE*$SYS_MEMORY_TOTAL))
MIN_MEMORY_ESB_BYTES=$(bc <<< "scale = 2; $MIN_MEMORY_ESB / 100")
MIN_MEMORY_ESB_MBYTES=$(bc <<< "scale = 2; $MIN_MEMORY_ESB_BYTES / 1024")
MIN_MEMORY_ESB_MBYTES=$(echo $MIN_MEMORY_ESB_MBYTES | awk '{print int($MIN_MEMORY_ESB_MBYTES+0.5)}')

echo "Configuring Java Heap Memory for ESB: $MIN_MEM_ESB_PERCENTAGE% of Systems Memory : $MIN_MEMORY_ESB_MBYTES"

# Configuration
#export SERVICEMIX_PKG_URL=http://archive.apache.org/dist/servicemix/servicemix-4/4.5.3/apache-servicemix-4.5.3.tar.gz
export SERVICEMIX_PKG_URL=http://archive.apache.org/dist/servicemix/servicemix-4/4.5.3/apache-servicemix-minimal-4.5.3.tar.gz
#export SERVICEMIX_PKG_URL=http://archive.apache.org/dist/servicemix/servicemix-4/4.5.3/apache-servicemix-full-4.5.3.tar.gz
export ID="i-5c80b0ed-d1dc-4268-b4b9-9bb4"
export Name=""
export CPU_SHARED=""
export features="camel-core,camel-http,camel-jetty"
#export features=""
export JBI_allowCoreThreadTimeOut="true"
export JBI_corePoolSize="10"
export JBI_keepAliveTime="60000"
export JBI_maximumPoolSize="-1"
export JBI_queueSize="1024"
export JBI_shutdownTimeout="0"
export JVM_MAX_MEM="$MAX_MEMORY_ESB_MBYTES$MEM_METRIC"
export JVM_MAX_PERM_MEM="$MAX_MEMORY_ESB_MBYTES$MEM_METRIC"
export JVM_MIN_MEM="$MIN_MEMORY_ESB_MBYTES$MEM_METRIC"
export JVM_PERM_MEM="$MIN_MEMORY_ESB_MBYTES$MEM_METRIC"
export MAX_MEM=""
export NMR_allowCoreThreadTimeOut="true"
export NMR_corePoolSize="10"
export NMR_keepAliveTime="60000"
export NMR_maximumPoolSize="-1"
export NMR_queueSize="1024"
export NMR_shutdownTimeout="0"
export SERVICEMIX_PASSWORD="smx"
export SERVICEMIX_USER="smx"



# Prepare

source ./prepare.sh
sudo cp ./*.jar /servicemix/deploy/


# Start

sh /esb/run.sh 
# Ports: 8101 8181 22
