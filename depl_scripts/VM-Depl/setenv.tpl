#!/bin/sh
#
#    Licensed to the Apache Software Foundation (ASF) under one or more
#    contributor license agreements.  See the NOTICE file distributed with
#    this work for additional information regarding copyright ownership.
#    The ASF licenses this file to You under the Apache License, Version 2.0
#    (the "License"); you may not use this file except in compliance with
#    the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

#
# handle specific scripts; the SCRIPT_NAME is exactly the name of the Karaf
# script; for example karaf, start, stop, admin, client, ...
#
# if [ "$KARAF_SCRIPT" == "SCRIPT_NAME" ]; then
#   Actions go here...
# fi

#
# general settings which should be applied for all scripts go here; please keep
# in mind that it is possible that scripts might be executed more than once, e.g.
# in example of the start script where the start script is executed first and the
# karaf script afterwards.
#

#
# The following section shows the possible configuration options for the default 
# karaf scripts
#
# export JAVA_MIN_MEM # Minimum memory for the JVM
# export JAVA_MAX_MEM # Maximum memory for the JVM
# export JAVA_PERM_MEM # Minimum perm memory for the JVM
# export JAVA_MAX_PERM_MEM # Maximum memory for the JVM
# export KARAF_HOME # Karaf home folder
# export KARAF_DATA # Karaf data folder
# export KARAF_BASE # Karaf base folder
# export KARAF_OPTS # Additional available Karaf options

{% if JVM_MIN_MEM is defined %}
export JAVA_MIN_MEM={{ JVM_MIN_MEM }}
{% endif %}
{% if JVM_MAX_MEM is defined %}
export JAVA_MAX_MEM={{ JVM_MAX_MEM }}
{% endif %}
{% if JVM_PERM_MEM is defined %}
export JAVA_PERM_MEM={{ JVM_PERM_MEM }}
{% endif %}
{% if JVM_MAX_PERM_MEM is defined %}
export JAVA_MAX_PERM_MEM={{ JVM_MIN_MEM }}
{% endif %}

