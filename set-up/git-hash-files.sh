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
            sha=$(git rev-parse "HEAD:$file")
            echo "$file: $sha" 1>&2
            echo -n $sha
        fi
    else
        echo "string: $file" 1>&2
        echo -n "$file"
    fi
done | git hash-object --stdin
