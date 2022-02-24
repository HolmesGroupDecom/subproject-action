#!/bin/bash

# Hash files or directories by combining the hash information git already has
# Any arguments after -- will be added to the hash (as strings)

set -euo pipefail


files="true"

for file in "$@"
do
    if [ $files = "true" ]
    then
        if [ "$file" = "--" ]
        then
            files="false"
        else
            git rev-parse "HEAD:$file"
        fi
    else
        echo -n "$file"
    fi
done | git hash-object --stdin
