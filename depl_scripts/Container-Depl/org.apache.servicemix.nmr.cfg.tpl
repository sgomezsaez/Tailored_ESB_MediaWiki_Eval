################################################################################
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
################################################################################

# The values below can be used to configure the thread pool size for NMR endpoints.
# - corePoolSize defines the core thread pool size (default is 4)
# - maximumPoolSize defines the maximum thread pool size, -1 means an unbounded thread pool size (default is -1)
# - queueSize defines the executor queue size (default is 1024)
# - allowCoreThreadTimeOut allows the core threads to timeout (defaults to true)
# - keepAliveTime is the amount of milliseconds a thread is kept alive when idle (defaults to 60000)
#
# Endpoints are provided a ThreadPool with specific configuration.  If no configuration
# can be found for the endpoint name, the default one can be used.
# A given thread pool can be configured by prefixing the above properties with the name followed by a dot.
# For example:
#   foo.bar.corePoolSize=16
#

shutdownTimeout={{ NMR_shutdownTimeout }}
corePoolSize={{ NMR_corePoolSize }}
maximumPoolSize={{ NMR_maximumPoolSize }}
allowCoreThreadTimeOut={{ NMR_allowCoreThreadTimeOut }}
keepAliveTime={{ NMR_keepAliveTime }}
