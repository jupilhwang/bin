#!/usr/bin/env bash

docker run -p 50000:50000 -p 9090:8080 --name jenkins -v /home/jhwang/.jenkins:/var/jenkins_home jenkins:alpine

