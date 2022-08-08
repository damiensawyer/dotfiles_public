#!/bin/bash
rm -rf ~/.aws
mkdir ~/.aws
gpg -d credentials.asc > credentials
cp credentials ~/.aws
cp config ~/.aws
