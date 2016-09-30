#!/bin/bash

SERVER_NAME=`echo $0 | awk '{start = match($0, /stop/); print substr($0, RSTART+RLENGTH)}' | cut -d. -f1`

case $SERVER_NAME in
	"AdminServer" | "WC_Spaces" | "UCM_server1" | "WC_Portlet" | "WC_Utilities" | "soa_server1" )
	;;
	*)
		echo '################################################'
		echo ''
		echo "    Input Server Name what you want to shutdown"
		echo ''
		echo '################################################'
		echo "1. AdminServer"
		echo "2. WC_Spaces"
		echo "3. UCM_server1"
		echo "4. WC_Portet"
		echo "5. WC_Utilities"
		echo "6. IBR_server1"
		echo "7. WC_Collaboration"
		echo "8. soa_server1"

		read SERVER_NAME

		case $SERVER_NAME in 
			"AdminServer" | "WC_Spaces" | "UCM_server1" | "WC_Portlet" | "WC_Utilities" | "soa_server1" )
				;;
			*)	
				echo $SERVER_NAME 'is wrong. please check the server name'
				exit 1	
			;;
		esac
	;;
esac

SERVER_OS=`uname -o`
echo '#######################################'
echo '    ' $SERVER_NAME' (' $SERVER_OS ')'
echo '#######################################'

PS_ID=`ps -ef|grep oracle|grep java|grep -v grep|grep $SERVER_NAME|awk '{print $2}'`

if [ $PS_ID ]; then
	echo $SERVER_NAME' (PID:' $PS_ID ') will be shutdown'
else
	echo '' 
	echo $SERVER_NAME' is not running ... '
	exit 1
fi


DOMAIN_HOME=/oracle/user_projects/domains/wc_domain
AdminServerURL=t3://localhost:7001

export WLS_USER=weblogic
export WLS_PW=welcome1

echo ''
echo $SERVER_NAME ' shutdown ...........................'
echo ''

case $SERVER_NAME in
#	"AdminServer")
#		$DOMAIN_HOME/bin/stopWebLogic.sh
#	;;
	*)
#		$DOMAIN_HOME/bin/stopManagedWebLogic.sh $SERVER_NAME $AdminServerURL $WLS_USER $WLS_PW FORCESHUTDOWN


        . $DOMAIN_HOME/bin/setDomainEnv.sh
        java weblogic.Admin -url $AdminServerURL -username $WLS_USER -password $WLS_PW FORCESHUTDOWN $SERVER_NAME
	
        ;;
esac

