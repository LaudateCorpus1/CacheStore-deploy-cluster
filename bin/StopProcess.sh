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

PGID_FILE=$1

if [ -e  $PGID_FILE ]; then
    PGID=$(cat $PGID_FILE)

    kill -- -$PGID

    KILL_RESULT=$(ps -ao 'pgid=' | grep $PGID)
    while [ -n "$KILL_RESULT" ]; do
        KILL_RESULT=$(ps -ao 'pgid' | grep $PGID)
    done

    rm -v $PGID_FILE
else
    echo "Could not find $PGID_FILE"
fi
