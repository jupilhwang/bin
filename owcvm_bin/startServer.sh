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

export JAVA_VENDOR=Oracle
export JAVA_HOME=/oracle/java/jdk1.8.0_102
export PATH=$JAVA_HOME/bin:$PATH

### JVM HEAP Memory Setting
case $SERVER_NAME in
	"AdminServer")
		export USER_MEM_ARGS="-Xms512m -Xmx1G"
		;;
	"WC_Portal" )
		export USER_MEM_ARGS="-Xms1G -Xmx2G"
		;;
	"UCM_server1")
		export USER_MEM_ARGS="-Xms512m -Xmx1G"
		;;
	"WC_Portlet" )
		export USER_MEM_ARGS="-Xms512m -Xmx1G"
		;;
	*)
		export USER_MEM_ARGS="-Xms512m -Xmx1G"
		;;
esac

export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+AlwaysPreTouch -XX:+UnlockCommercialFeatures -XX:+ResourceManagement"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:NewRatio=12"		#Defualt 8(linux), 2(solaris)
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:SurvivorRatio=10"	#Defualt 8
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseCompressedOops"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:SoftRefLRUPolicyMSPerMB=0"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+ParallelRefProcEnabled"


#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseConcMarkSweepGC"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseParNewGC"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+CMSParallelRemarkEnabled"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:CMSInitiatingOccupancyFraction=75"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseCMSInitiatingOccupancyOnly"
### end : CMS GC

### start : G1 GC option ##
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseG1GC -XX:+ExplicitGCInvokesConcurrent -XX:+ParallelRefProcEnabled -XX:+UseStringDeduplication -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:+UnlockDiagnosticVMOptions -XX:G1SummarizeRSetStatsPeriod=1"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:MaxGCPauseMillis=200"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:InitiatingHeapOccupancyPercent=45"	#Default 45
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:ConcGCThreads=8"
### end : G1 GC option ##

### start : Parallel GC
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseParallelGC"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:ParallelGCThreads=8"	#Default
#export JAVA_OPTIONS="$JAVA_OPTIONS -Xnoclassgc"
### end : Parallel GC

export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+HeapDumpOnOutOfMemoryError"

export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+PrintGC -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintHeapAtGC -XX:+PrintGCCause -XX:+PrintTenuringDistribution -XX:+PrintReferenceGC -XX:+PrintAdaptiveSizePolicy -XX:+PrintGCApplicationStoppedTime"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseGCLogFileRotation"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:NumberOfGCLogFiles=10"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:GCLogFileSize=50m"
export JAVA_OPTIONS="$JAVA_OPTIONS -Xloggc:=${LOG_HOME}/${SERVER_NAME}_GC_`date '+%y%m%d_%H%M%S'`.gc"

export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseLargePages"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:LargePageSizeInBytes=4m"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+UseAdaptiveSizePolicy"

# JIT compiler
#if [ $SERVER_NAME != "AdminServer" ]; then
#        export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+AggressiveOpts"
#        export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+AggressiveHeap"
#fi

export JAVA_OPTIONS="$JAVA_OPTIONS -XX:CompileThreshold=8000"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:+TieredCompilation"
export JAVA_OPTIONS="$JAVA_OPTIONS -XX:ReservedCodeCacheSize=256m"
#export JAVA_OPTIONS="$JAVA_OPTIONS -XX:CodeCacheMinimumFreeSpace=16m"

## jps options
export JAVA_OPTIONS="$JAVA_OPTIONS -Djps.auth.debug=false"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djps.app.credential.overwrite.allowed=true"

### jbo ampooling
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.ampooling=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.dofailover=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.doconnectionpooling=true"
#export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.ampool.initpoolsize=100"
#export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.ampool.maxpoolsize=16384"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.ampool.maxinactiveage=180000"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.ampool.monitorsleepinterval=90000"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djbo.txn.disconnect_level=1"

#export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.threadpool.MinPoolSize=50"
#export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.threadpool.MaxPoolSize=50"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.SocketReaders=5000" # CPU count / 2

export JAVA_OPTIONS="$JAVA_OPTIONS -D_Offline_FileDataArchive=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djava.net.preferIPv4Stack=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djava.net.preferIPv6Addresses=false"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dcom.bea.wlw.netui.disableInstrumentation=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.configuration.schemaValidationEnabled=false"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.security.SSL.ignoreHostnameVerification=true"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.connector.ConnectionPoolProfilingEnabled=false"
export JAVA_OPTIONS="$JAVA_OPTIONS -Dweblogic.system.BootIdentityFile=$DOMAIN_HOME/boot.properties"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djava.security.egd=file:/dev/./urandom"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djavax.management.builder.initial=weblogic.management.jmx.mbeanserver.WLSMBeanServerBuilder"
export JAVA_OPTIONS="$JAVA_OPTIONS -Djava.io.tmpdir=/oracle/tmp"

## jconsole through JMX
#export JAVA_OPTIONS="$JAVA_OPTIONS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8999 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
######

export JAVA_OPTIONS="$JAVA_OPTIONS -da:org.apache.xmlbeans..."

XENGINE_DIR="${SOA_ORACLE_HOME}/soa/thirdparty/edifecs/XEngine"
if [ -d ${XENGINE_DIR}/bin ]; then
        export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${XENGINE_DIR}/bin:/oracle/fmw/Oracle_ECM1/ucm/idc/components/NativeOsUtils/lib/linux64/7.2.1.1"
fi

echo 'USER_MEM_ARGS : '
echo ${USER_MEM_ARGS}
echo 'JAVA_OPTIONS : '
echo ${JAVA_OPTIONS}

case $SERVER_NAME in
	"AdminServer")
		nohup $DOMAIN_HOME/startWebLogic.sh > $LOG_HOME/$SERVER_NAME.log  &
	;;
	"WC_Spaces")
                ### start: content coherenec
                export JAVA_OPTIONS="$JAVA_OPTIONS -Dtangosol.coherence.management=all -Dtangosol.coherence.log=stdout"
		export JAVA_OPTIONS="$JAVA_OPTIONS -DContentTypeLazyCaching=true -DAllowWildcardSearch=true"
		nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh $SERVER_NAME $AdminServerURL > $LOG_HOME/$SERVER_NAME.log &
	;;
        *)
		nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh $SERVER_NAME $AdminServerURL > $LOG_HOME/$SERVER_NAME.log &
        ;;
esac

echo ''
echo $SERVER_NAME ' is starting ...........................'
echo ''
echo 'LogFiles' $LOG_HOME/$SERVER_NAME.log
echo ''

tail -f $LOG_HOME/$SERVER_NAME.log
