 #!/bin/bash

SERVER_NAME=`echo $0 | awk '{start = match($0, /start/); print substr($0, RSTART+RLENGTH)}' | cut -d. -f1`

case $SERVER_NAME in
	"AdminServer" | "WC_Portal" | "UCM_server1" | "WC_Portlet"  | "soa_server1" | "BpmAdminServer" )
	;;
	*)
		echo "################################################"
		echo ""
		echo "    Input Server Name what you want to startup"
		echo ""
		echo "################################################"
		echo "1. AdminServer"
		echo "2. WC_Portal"
		echo "3. UCM_server1"
		echo "4. WC_Portet"
		echo "5. WC_Collaboration"
		echo "6. soa_server1"

		read SERVER_NAME

		case $SERVER_NAME in
			"AdminServer" | "WC_Portal" | "UCM_server1" | "WC_Portlet" | "soa_server1"| "BpmAdminServer" )
			;;
			*)
				echo $SERVER_NAME 'is wrong. please check the server name'
				exit 1
			;;
		esac
	;;
esac

#if [ $SERVER_NAME == "soa_server1" ]; then
#	DOMAIN_HOME="/oracle/user_projects/domains/bpm_domain"
#	AdminServerURL="t3://localhost:7101"
#	SERVER_NAME="AdminServer"
#else
	DOMAIN_HOME="/oracle/user_projects/domains/base_domain"
	AdminServerURL="t3://localhost:7001"
#fi

SERVER_OS=`uname -o`
echo '#######################################'
echo '    ' $SERVER_NAME' (' $SERVER_OS ')'
echo '#######################################'

PS_ID=`ps -ef|grep oracle|grep java|grep -v grep|grep $SERVER_NAME|awk '{print $2}'`

if [ $PS_ID ]; then
	echo ''
	echo $SERVER_NAME' (PID:' $PS_ID ') is already running ... '
	exit 1
else
	echo $SERVER_NAME' will be start'
fi


SOA_ORACLE_HOME=/oracle/fmw/Oracle_SOA1

#LOG_HOME=$DOMAIN_HOME
LOG_HOME=/oracle/user_projects/logs

#export WLS_USER=weblogic
#export WLS_PW=welcome1

export JAVA_VENDOR=Sun
export JAVA_HOME=/oracle/java/jdk1.8.0_102
export PATH=$JAVA_HOME/bin:$PATH


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
