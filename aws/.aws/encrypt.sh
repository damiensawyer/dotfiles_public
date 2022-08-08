#!/bin/bash
rm credentials.asc
gpg -ca --cipher-algo AES-256 credentials

