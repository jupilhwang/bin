#!/bin/bash

VBoxID=`ps -ef|grep virtualbox|grep w7|grep -v grep|awk '{print $2}'`
echo "VirtualBox PID is "$VBoxID

if [$VBoxID == ''] 
then
	VBoxManage startvm w7
else
	VBoxManage controlvm w7 savestate
fi

