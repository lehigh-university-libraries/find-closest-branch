#!/bin/sh

# Inspired by https://stackoverflow.com/a/13733096

# Example paths below imagine comparing these files:
# /opt/application/upstream/folder/file
# /opt/application/local/folder/file

COMMON_BASE=$1 # i.e. /opt/application/
UPSTREAM=$2    # i.e. upstream/
LOCAL=$3       # i.e. local/
FILE_PATH=$4    # i.e. folder/file

START=`pwd`
cd $COMMON_BASE$UPSTREAM
git branch -r | grep "release" | grep -v "release-2" | cut -f2 -d "/" | while read rev; do
    git checkout -q $rev

    if [[ ! -f "$COMMON_BASE$UPSTREAM$FILE_PATH" ]]; then
        echo "no file in upstream $COMMON_BASE$UPSTREAM$FILE_PATH" 
        continue
    fi

    lines=$(diff $COMMON_BASE$UPSTREAM$FILE_PATH $COMMON_BASE$LOCAL$FILE_PATH | wc -l)

    if ! [[ "$minlines" ]] || [[ $lines -lt $minlines ]]; then
        minlines=$lines
        commit=$rev
        echo "$lines $rev"
    fi

    [[ $lines -eq 0 ]] && break
done | tail -1

cd $START
