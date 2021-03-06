#!/bin/bash
#
# Copyright 2020 Delphix
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

if [[ -z "$KVERS" ]]; then
	export KVERS=$(uname -r)
fi

unset PLATFORM
for platform in generic aws gcp azure oracle; do
	if [[ "$KVERS" =~ .*${platform} ]]; then
		PLATFORM="$platform"
		break;
	fi
done

if [[ -z "$PLATFORM" ]]; then
	echo "Error: Unable to determine platform for KVERS=$KVERS." >&2
	exit 1
fi

sed "s/@@KVERS@@/$KVERS/g" "debian/control.$PLATFORM.in" >debian/control
