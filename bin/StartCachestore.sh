#!/bin/bash


# Copyright 2012-2015 Viant.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.


BASE_DIR=$(dirname $0)/..

source $BASE_DIR/bin/Bootstrap.sh

#jmxremote pw
if [ -f "$BASE_DIR/dist/resources/jmxremote.password" ]; then
	chmod 700 "$BASE_DIR/dist/resources/jmxremote.password"
else
	>"$BASE_DIR/dist/resources/jmxremote.password"
	chmod 700 "$BASE_DIR/dist/resources/jmxremote.password"
fi

#jmxremote access
if [ ! -f "$BASE_DIR/dist/resources/jmxremote.access" ]; then
	>"$BASE_DIR/dist/resources/jmxremote.access"
fi

# Min, max, total JVM size (-Xms -Xmx)
JVM_SIZE="-server -Xms8g -Xmx12g"

MAINCLASS="com.sm.store.server.grizzly.RemoteScan4ReplicaServer"

echo "Using classpath: $CLASSPATH"
echo "Using main class: $MAINCLASS"

ps -o 'pgid=' $$ | sed 's/^\s*//' > $BASE_DIR/cachestore.pgid
java  $OPTS $JVM_SIZE -cp $CLASSPATH $MAINCLASS $@
