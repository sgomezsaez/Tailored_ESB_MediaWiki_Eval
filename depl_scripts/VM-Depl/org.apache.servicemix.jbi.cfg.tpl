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

# When using a forced shutdown of a SA, all pending synchronous exchanges will be canceled after this timeout
# The value is specified in ms, the default value of 0 will wait indefinitely for all exchanges to finish

# The values below can be used to configure the thread pool size for the ServiceMix JBI components.
# - corePoolSize defines the core thread pool size (default is 4)
# - maximumPoolSize defines the maximum thread pool size, -1 means an unbounded thread pool size (default is -1)
# - queueSize defines the executor queue size (default is 1024)
# - allowCoreThreadTimeOut allows the core threads to timeout (defaults to true)
# - keepAliveTime is the amount of milliseconds a thread is kept alive when idle (defaults to 60000)

shutdownTimeout={{ JBI_shutdownTimeout }}
corePoolSize={{ JBI_corePoolSize }}
maximumPoolSize={{ JBI_maximumPoolSize }}
allowCoreThreadTimeOut={{ JBI_allowCoreThreadTimeOut }}
keepAliveTime={{ JBI_keepAliveTime }}
