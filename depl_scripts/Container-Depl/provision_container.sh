#!/bin/bash
set -e

# Run Script ./provision_container.sh > provision_containers.log 2>&1 &

CONTAINER_NUMBER=4
SMX_SSH_HOST_INIT_PORT=8181
SMX_SSH_CONTAINER_INIT_PORT=8101
SMX_HTTP_HOST_INIT_PORT=8500
SMX_HTTP_CONTAINER_PORT=8500

IPADD=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')


# Max and Min System and ESB container Percentage Utilization
MAX_MEM_SYS_PERCENTAGE=80
MIN_MEM_SYS_PERCENTAGE=25
MAX_MEM_ESB_PERCENTAGE=80
MIN_MEM_ESB_PERCENTAGE=25
MEM_METRIC="M"

SYS_MEMORY_TOTAL=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')

# Calculation of Percentage Max Total Sys Memory that will be consumed
MAX_MEMORY_SYS=$(($MAX_MEM_SYS_PERCENTAGE*$SYS_MEMORY_TOTAL))
MAX_MEMORY_SYS_BYTES=$(bc <<< "scale = 2; $MAX_MEMORY_SYS / 100")
MAX_MEMORY_SYS_MBYTES=$(bc <<< "scale = 2; $MAX_MEMORY_SYS_BYTES / 1024")
MAX_MEMORY_SYS_MBYTES=$(echo $MAX_MEMORY_SYS_MBYTES | awk '{print int($MAX_MEMORY_SYS_MBYTES+0.5)}')

# Calculation of Percentage Min Total Sys Memory that will be consumed
MIN_MEMORY_SYS=$(($MIN_MEM_SYS_PERCENTAGE*$SYS_MEMORY_TOTAL))
MIN_MEMORY_SYS_BYTES=$(bc <<< "scale = 2; $MIN_MEMORY_SYS / 100")
MIN_MEMORY_SYS_MBYTES=$(bc <<< "scale = 2; $MIN_MEMORY_SYS_BYTES / 1024")
MIN_MEMORY_SYS_MBYTES=$(echo $MIN_MEMORY_SYS_MBYTES | awk '{print int($MIN_MEMORY_SYS_MBYTES+0.5)}')

echo "Total Memory Consumed by all ESB Containers:"
echo "Max: $MAX_MEMORY_SYS_MBYTES MB"
echo "Min: $MIN_MEMORY_SYS_MBYTES MB"

# Calculating Percentage Max Memory per Container
MAX_MEMORY_ESB_CONTAINER_PERCENTAGE=$(($MAX_MEM_SYS_PERCENTAGE / $CONTAINER_NUMBER))
MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(($MAX_MEMORY_SYS_MBYTES*$MAX_MEMORY_ESB_CONTAINER_PERCENTAGE))
MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(bc <<< "scale = 2; $MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES / 100")
MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(echo $MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES | awk '{print int($MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES+0.5)}')

# Calculating Percentage Min Memory per Container
MIN_MEMORY_ESB_CONTAINER_PERCENTAGE=$(($MIN_MEM_SYS_PERCENTAGE/$CONTAINER_NUMBER))
MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(($MIN_MEMORY_SYS_MBYTES*$MIN_MEMORY_ESB_CONTAINER_PERCENTAGE))
MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(bc <<< "scale = 2; $MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES / 100")
MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES=$(echo $MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES | awk '{print int($MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES+0.5)}')

echo "Memory available per container:"
echo "Max: $MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES MB"
echo "Min: $MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES MB"

#ServiceMix Configuration
CPU_SHARED=""
features="camel-core,camel-http,camel-jetty"
JBI_allowCoreThreadTimeOut="true"
JBI_corePoolSize="100"
JBI_keepAliveTime="60000"
JBI_maximumPoolSize="-1"
JBI_queueSize="1024"
JBI_shutdownTimeout="0"
MAX_MEM=""
NMR_allowCoreThreadTimeOut="true"
NMR_corePoolSize="100"
NMR_keepAliveTime="60000"
NMR_maximumPoolSize="-1"
NMR_queueSize="1024"
NMR_shutdownTimeout="0"
SERVICEMIX_PASSWORD="smx"
SERVICEMIX_USER="smx"

# Input port forwarding in format -p $IPADD:$HOST_PORT:$CONTAINER_PORT

sudo docker build -t servicemix/full .

DOCKER_RUN_ENV="-e JVM_MAX_MEM=$MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES$MEM_METRIC -e JVM_MAX_PERM_MEM=$MAX_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES$MEM_METRIC -e JVM_MIN_MEM=$MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES$MEM_METRIC -e JVM_PERM_MEM=$MIN_MEMORY_AVAILABLE_PER_CONTAINER_MBYTES$MEM_METRIC -e features=$features -e JBI_allowCoreThreadTimeOut=$JBI_allowCoreThreadTimeOut -e JBI_corePoolSize=$JBI_corePoolSize -e JBI_keepAliveTime=$JBI_keepAliveTime -e JBI_maximumPoolSize=$JBI_maximumPoolSize -e JBI_queueSize=$JBI_queueSize -e JBI_shutdownTimeout=$JBI_shutdownTimeout -e NMR_allowCoreThreadTimeOut=$NMR_allowCoreThreadTimeOut -e NMR_corePoolSize=$NMR_corePoolSize -e NMR_keepAliveTime=$NMR_keepAliveTime -e NMR_maximumPoolSize=$NMR_maximumPoolSize -e NMR_queueSize=$NMR_queueSize -e NMR_shutdownTimeout=$NMR_shutdownTimeout -e SERVICEMIX_PASSWORD=$SERVICEMIX_PASSWORD -e SERVICEMIX_USER=$SERVICEMIX_USER"

echo "Docker Environment Variables: $DOCKER_RUN_ENV"

for i in $(seq 0 $(($CONTAINER_NUMBER - 1)));
do
	PORT_FORWARDING="-p $IPADD:$(($SMX_HTTP_HOST_INIT_PORT + $i)):$(($SMX_HTTP_CONTAINER_PORT + $i)) -p $IPADD:$(($SMX_SSH_HOST_INIT_PORT + $i)):$SMX_SSH_CONTAINER_INIT_PORT"
	echo $PORT_FORWARDING
	sudo docker run -d $PORT_FORWARDING $DOCKER_RUN_ENV -t -net host servicemix/full
done
