#!/bin/bash
# quick way to commit all changes
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters. Pass only commit message. Use double quotes if multiple words"
    exit 1
fi
git add -A && git ci -m "$1"
