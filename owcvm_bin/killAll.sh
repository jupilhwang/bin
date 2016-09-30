#!/bin/sh

DOMAIN_HOME=/oracle/user_projects/domains/base_domain
AdminServerURL=t3://localhost:7001

export WLS_USER=weblogic
export WLS_PW=welcome1

PS_ID=`ps -ef|grep Dweblogic.Name|grep -v grep|awk '{print $2}'`

echo "$SERVER_NAME is alredy running. process id is $PS_ID"

#nohup $DOMAIN_HOME/bin/stopWebLogic.sh > $DOMAIN_HOME/$SERVER_NAME.log &
kill -9 $PS_ID
