#!/usr/bin/env bash

cd /home/jhwang/.jhwangSites
nohup hugo server -w -D > /dev/null 2>1&
