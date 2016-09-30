#!/bin/bash

LOG_HOME='/oracle/user_projects/logs'
LOG_AdminServer=$LOG_HOME'/AdminServer.log'
LOG_UCM_server1=$LOG_HOME'/UCM_server1.log'
LOG_WC_Spaces=$LOG_HOME'/WC_Spaces.log'
LOG_WC_Portlet=$LOG_HOME'/WC_Portlet.log'
LOG_WC_Utilitites=$LOG_HOME'/WC_Utilities.log'

startAdminServer
sleep 2
#tail -f $LOG_AdminServer | sed -n '/RUNNING/ q' && kill $!
tail -f $LOG_AdminServer | grep -m 1 -q RUNNING && kill $$!
echo "AdminServer        .............. RUNNING" 

startUCM_server1
sleep 2
#tail -f $LOG_UCM_server1 | sed -n '/RUNNING/ q' && kill $!
tail -f $LOG_UCM_server1 | grep -m 1 -q RUNNING && kill $$!
echo "UCM Server1        .............. RUNNING"

startWC_Spaces
sleep 2
#tail -f $LOG_WC_Spaces | sed -n '/RUNNING/ q' && kill $!
tail -f $LOG_WC_Spaces | grep -m 1 -q RUNNING && kill $$!
echo "WC_Spaces        .............. RUNNING"

killall tail

startWC_Portlet
startWC_Utilities
