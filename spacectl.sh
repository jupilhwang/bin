#!/bin/bash
DATE=`date +%A" "%d-%b-%Y-%X`
DATESTAMP=`date +%d-%b-%Y-%T`
clear
echo " ****************************   Oracle WebCenter Administration Menu       *******************************"
echo " "
echo "                                           "$DATE"                                                          "
echo " "
echo "0.  STOP  ALL - [Stop  Database,Listener,AdminServer,OHS,WC_Spaces, UCM_Server1] "
echo "1.  START ALL - [Start Database,Listener,AdminServer,OHS,WC_Spaces, UCM_Server1] "
echo " "
echo "2.  START Oracle Database and Listener "
echo "3.  START Oracle Weblogic Server [AdminServer]"
echo "4.  START Oracle ECM [UCM_server1] "
echo "5.  START Oracle WC_Spaces [WC_Spaces] "
echo "6.  START OHS [Oracle HTTP Server ] "

echo " "
echo "7. STOP  Oracle ECM [UCM_server1] "
echo "8. STOP  Oracle WC_Spaces [WC_Spaces] "
echo "9. STOP  Oracle Weblogic Server [AdminServer] "
echo "10. STOP  OHS [Oracle HTTP Server ] "
echo "11. STOP  Oracle Database and Listener "
echo " "
echo "X.  EXIT from this Menu "
echo "  *********************************************************************************************************"

export ORACLE_HOME=/u01/app/oracle/product/db11gR2
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=owcdb01
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export DOMAIN_HOME=/u01/app/oracle/product/PS3_RC6/fmwhome/user_projects/domains/webcenter

ADMIN_PORT=7001
SPACES_PORT=8888
COLLAB_PORT=8890
PORTLET_PORT=8889
UTIL_PORT=8891
UCM_PORT=16200
IBR_PORT=16250

#echo "\n X.  Exit from Menu"
echo "Enter the Administration Option (X to exit menu): "
read ADMINTASK
#
if [[ -z $ADMINTASK ]]; then
   echo "Please enter a numeric value from the Menu!"
else
case $ADMINTASK in

#---------------------------------------------------------------------------------------------

"1")
clear
#
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then echo "Database Listener Already RUNNING."
else echo "Starting Infrastructure Database Listener..."
$ORACLE_HOME/bin/lsnrctl start
fi

db_num=`ps -ef|grep pmon |grep -v grep |awk 'END{print NR}'`

if [ $db_num -gt 0 ]
then echo "Database Already RUNNING."
else echo "Starting Oracle Database ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
startup
EOF
#

sleep 10
echo "Database Services Successfully Started. "
#
fi

admin_num=`ps -ef|grep "$ADMIN_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $admin_num -gt 0 ]
then echo "WebLogic Admin Server Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting WebLogic Admin Server...."
nohup ./startWebLogic.sh > weblogic.out &
admin_run=`grep -i RUNNING weblogic.out|grep -v grep |awk 'END{print NR}'`
while [ $admin_run -eq 0 ]
do
sleep 5;
admin_run=`grep -i RUNNING weblogic.out|grep -v grep |awk 'END{print NR}'`
done


echo "Starting the OHS - Oracle HTTP Server .."
/u01/app/oracle/product/PS3_RC6/fmwhome/Oracle_WT1/instances/instance1/bin/opmnctl startall

echo "Starting UCM_server1...."
nohup ./startManagedWebLogic.sh UCM_server1 > ucm.out &
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ucm.out|grep -v grep |awk 'END{print NR}'`
while [ $ucm_run -eq 0 ]
do
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ucm.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting Spaces...."
nohup ./startManagedWebLogic.sh WC_Spaces > spaces.out &
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" spaces.out|grep -v grep |awk 'END{print NR}'`
while [ $spaces_run -eq 0 ]
do
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" spaces.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;

#---------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------
"2")
clear
#
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then echo "Database Listener Already RUNNING."
else echo "Starting Infrastructure Database Listener..."
$ORACLE_HOME/bin/lsnrctl start
fi

db_num=`ps -ef|grep pmon |grep -v grep |awk 'END{print NR}'`

if [ $db_num -gt 0 ]
then echo "Database Already RUNNING."
else echo "Starting Oracle Database ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
startup
EOF
#
sleep 10
echo "Database Services Successfully Started. "
#
fi
;;
#---------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------
"3")
echo "Starting WLS_Admin ...."

admin_num=`netstat -nl|grep "$ADMIN_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $admin_num -gt 0 ]
then echo "WebLogic Admin Server Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting WebLogic Admin Server...."
nohup ./startWebLogic.sh > weblogic.out &
sleep 5;
admin_run=`grep -i "Server started in RUNNING mode" weblogic.out|grep -v grep |awk 'END{print NR}'`
while [ $admin_run -eq 0 ]
do
sleep 5;
admin_run=`grep -i "Server started in RUNNING mode" weblogic.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;
#---------------------------------------------------------------------------------------------

"4")

ucm_num=`netstat -nl|grep "$UCM_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $ucm_num -gt 0 ]
then echo "UCM_server1 Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting UCM_server1...."
nohup ./startManagedWebLogic.sh UCM_server1 > ucm.out &
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ucm.out|grep -v grep |awk 'END{print NR}'`
while [ $ucm_run -eq 0 ]
do
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ucm.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;



#---------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------

"5")

spaces_num=`netstat -nl|grep "$SPACES_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $spaces_num -gt 0 ]
then echo "WC_Spaces Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin
echo "Starting WC_Spaces...."
nohup ./startManagedWebLogic.sh WC_Spaces > spaces.out &
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" spaces.out|grep -v grep |awk 'END{print NR}'`
while [ $spaces_run -eq 0 ]
do
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" spaces.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;


#--------------------------------------------------------------------------------------------
"6")

echo "Starting the OHS - Oracle HTTP Server...."
/u01/app/oracle/product/PS3_RC6/fmwhome/Oracle_WT1/instances/instance1/bin/opmnctl startall;

;;
#--------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
"7")
echo "Stopping  Oracle UCM [UCM_server1] ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh UCM_server1
;;

#---------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------
"8")
echo "Stopping  WC_Spaces ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh WC_Spaces
;;
#---------------------------------------------------------------------------------------------

"9")
echo "Stopping Admin Server [WLS_Admin] ..."
cd $DOMAIN_HOME/bin
./stopWebLogic.sh
;;

#--------------------------------------------------------------------------------------------
"10")
echo "Stopping  the OHS [Oracle Http Server]"
/u01/app/oracle/product/PS3_RC6/fmwhome/Oracle_WT1/instances/instance1/bin/opmnctl stopall;
;;
#---------------------------------------------------------------------------------------------

"11")
echo "Stopping Oracle Database and Listener ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
shutdown immediate
EOF
#

$ORACLE_HOME/bin/lsnrctl stop
sleep 10;
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then kill -9 `ps -deafw | grep "$ORACLE_HOME" | grep -v grep |  awk '{print $2}' | paste -s -d" " -`
fi
;;


"0")
clear

cd $DOMAIN_HOME/bin

echo "Stopping Database,OHS,WLS_Admin,WC_Spaces, UCM_Server1 ..."
./stopManagedWebLogic.sh WC_Spaces
./stopManagedWebLogic.sh UCM_server1
./stopWebLogic.sh
/u01/app/oracle/product/PS3_RC6/fmwhome/Oracle_WT1/instances/instance1/bin/opmnctl stopall

echo "Stopping Oracle Database and Listener ..."
$ORACLE_HOME/bin/sqlplus "/ as sysdba" <<EOF
#connect sys/welcome1 as sysdba
shutdown immediate
EOF
#
$ORACLE_HOME/bin/lsnrctl stop
sleep 10;
lsnr_num=`ps -ef|grep tnslsnr |grep -v grep |awk 'END{print NR}'`

if [ $lsnr_num -gt 0 ]
then kill -9 `ps -deafw | grep "$ORACLE_HOME" | grep -v grep |  awk '{print $2}' | paste -s -d" " -`
fi
;;

"X")
clear
exit
;;
esac
fi
/home/oracle/spacesctl.sh

