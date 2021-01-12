#!/bin/bash

LOG_NAME="minio"

info() {
    [ -t 1 ] && [ -n "$TERM" ] \
        && echo "$(tput setaf 2)[$LOG_NAME]$(tput sgr0) $*" \
        || echo "[$LOG_NAME] $*"
}

err() {
	[ -t 2 ] && [ -n "$TERM" ] \
		&& echo -e "$(tput setaf 1)[$LOG_NAME]$(tput sgr0) $*" 1>&2 \
		|| echo -e "[$LOG_NAME] $*" 1>&2
}

die() {
	err "$@"
	exit 1
}

ok_or_die() {
	if [ $? -ne 0 ]; then
		die $1
	fi
}

if [[ $# -ne 5 ]] ; then
	die "Usage: $0 url access_key secret_key local_path remote_path"
fi

url=$1
access_key=$2
secret_key=$3
local_path=$4
remote_path=$5

info "Will fetch $remote_path to $local_path"

mc alias set s3 $url $access_key $secret_key
ok_or_die "Could not set mc alias"

mc cp -r $local_path s3/$remote_path
ok_or_die "Could not fetch object"
