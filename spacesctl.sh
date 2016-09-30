#!/bin/bash
DATE=`date +%A" "%d-%b-%Y-%X`
DATESTAMP=`date +%d-%b-%Y-%T`
clear
echo " ************   Oracle WebCenter Administration Menu       ******************"
echo " "
echo "0.  STOP  ALL - [Stop  Database,Listener,AdminServer,WC_Spaces, UCM_Server1] "
echo "1.  START ALL - [Start Database,Listener,AdminServer,WC_Spaces, UCM_Server1] "
echo " "
echo "2.  START Oracle Database and Listener "
echo "3.  START Oracle Weblogic Server [AdminServer]"
echo "4.  START Oracle ECM [UCM_server1] "
echo "5.  START Oracle WebCenter Utils [WC_Utilities] "
echo "6.  START Oracle WebCenter Collaboration [WC_Collaboration] "
echo "7.  START Oracle WebCenter Portlet [WC_Portlet] "
echo "8.  START Oracle WebCenter Spaces [WC_Spaces] "
echo "9.  START Apache Server"
echo " "
echo "10. STOP Oracle ECM [UCM_server1] "
echo "11. STOP Oracle WebCenter Utils [WC_Utilities] "
echo "12. STOP Oracle WebCenter Collaboration [WC_Collaboration] "
echo "13. STOP Oracle WebCenter Portlet [WC_Portlet] "
echo "14. STOP Oracle WebCenter Spaces [WC_Spaces] "
echo "15. STOP Oracle Weblogic Server [AdminServer] "
echo "16. STOP Apache Server "
echo "17. STOP Oracle Database and Listener "
echo " "
echo "X.  EXIT from this Menu "
echo "  ****************************************************************************"

export ORACLE_HOME=/oracle/product/11.2.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=orcl
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/ctx/lib:$LD_LIBRARY_PATH
export DOMAIN_HOME=/webcenter/user_projects/domains/base_domain

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

echo "Starting WebLogic Admin Server ..."
nohup ./startWebLogic.sh > ~/WLS_Admin.out &
admin_run=`grep -i "Server started in RUNNING mode" ~/WLS_Admin.out|grep -v grep |awk 'END{print NR}'`
while [ $admin_run -eq 0 ]
do
sleep 5;
admin_run=`grep -i "Server started in RUNNING mode" ~/WLS_Admin.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting the Apache Server ..."
sudo /etc/init.d/httpd start;

echo "Starting UCM_server1...."
nohup ./startManagedWebLogic.sh UCM_server1 > ~/UCM_server1.out &
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ~/UCM_server1.out|grep -v grep |awk 'END{print NR}'`
while [ $ucm_run -eq 0 ]
do
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ~/UCM_server1.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting WC_Utilites...."
nohup ./startManagedWebLogic.sh WC_Utilities > ~/WC_Utilities.out &
sleep 5;
util_run=`grep -i "Server started in RUNNING mode" ~/WC_Utilities.out|grep -v grep |awk 'END{print NR}'`
while [ $util_run -eq 0 ]
do
sleep 5;
util_run=`grep -i "Server started in RUNNING mode" ~/WC_Utilities.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting WC_Collaboration...."
nohup ./startManagedWebLogic.sh WC_Collaboration > ~/WC_Collaboration.out &
sleep 5;
collab_run=`grep -i "Server started in RUNNING mode" ~/WC_Collaboration.out|grep -v grep |awk 'END{print NR}'`
while [ $collab_run -eq 0 ]
do
sleep 5;
collab_run=`grep -i "Server started in RUNNING mode" ~/WC_Collaboration.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting WC_Portlet...."
nohup ./startManagedWebLogic.sh WC_Portlet > ~/WC_Portlet.out &
sleep 5;
portlet_run=`grep -i "Server started in RUNNING mode" ~/WC_Portlet.out|grep -v grep |awk 'END{print NR}'`
while [ $portlet_run -eq 0 ]
do
sleep 5;
portlet_run=`grep -i "Server started in RUNNING mode" ~/WC_Portlet.out|grep -v grep |awk 'END{print NR}'`
done

echo "Starting Spaces...."
nohup ./startManagedWebLogic.sh WC_Spaces > ~/WC_Spaces.out &
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" ~/WC_Spaces.out|grep -v grep |awk 'END{print NR}'`
while [ $spaces_run -eq 0 ]
do
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" ~/WC_Spaces.out|grep -v grep |awk 'END{print NR}'`
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
nohup ./startWebLogic.sh > ~/WLS_Admin.out &
sleep 5;
admin_run=`grep -i "Server started in RUNNING mode" ~/WLS_Admin.out|grep -v grep |awk 'END{print NR}'`
while [ $admin_run -eq 0 ]
do
sleep 5;
admin_run=`grep -i "Server started in RUNNING mode" ~/WLS_Admin.out|grep -v grep |awk 'END{print NR}'`
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
nohup ./startManagedWebLogic.sh UCM_server1 > ~/UCM_server1.out &
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ~/UCM_server1.out|grep -v grep |awk 'END{print NR}'`
while [ $ucm_run -eq 0 ]
do
sleep 5;
ucm_run=`grep -i "Server started in RUNNING mode" ~/UCM_server1.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;



#---------------------------------------------------------------------------------------------


"5")

util_num=`netstat -nl|grep "$UTIL_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $util_num -gt 0 ]
then echo "WC_Utilities Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting WC_Utilites...."
nohup ./startManagedWebLogic.sh WC_Utilities > ~/WC_Utilities.out &
sleep 5;
util_run=`grep -i "Server started in RUNNING mode" ~/WC_Utilities.out|grep -v grep |awk 'END{print NR}'`
while [ $util_run -eq 0 ]
do
sleep 5;
util_run=`grep -i "Server started in RUNNING mode" ~/WC_Utilities.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;



#---------------------------------------------------------------------------------------------


"6")

collab_num=`netstat -nl|grep "$COLLAB_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $collab_num -gt 0 ]
then echo "WC_Collaboration Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting WC_Collaboration...."
nohup ./startManagedWebLogic.sh WC_Collaboration > ~/WC_Collaboration.out &
sleep 5;
collab_run=`grep -i "Server started in RUNNING mode" ~/WC_Collaboration.out|grep -v grep |awk 'END{print NR}'`
while [ $collab_run -eq 0 ]
do
sleep 5;
collab_run=`grep -i "Server started in RUNNING mode" ~/WC_Collaboration.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;



#---------------------------------------------------------------------------------------------


"7")

portlet_num=`netstat -nl|grep "$PORTLET_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $portlet_num -gt 0 ]
then echo "WC_Portlet Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin

echo "Starting WC_Portlet...."
nohup ./startManagedWebLogic.sh WC_Portlet > ~/WC_Portlet.out &
sleep 5;
portlet_run=`grep -i "Server started in RUNNING mode" ~/WC_Portlet.out|grep -v grep |awk 'END{print NR}'`
while [ $portlet_run -eq 0 ]
do
sleep 5;
portlet_run=`grep -i "Server started in RUNNING mode" ~/WC_Portlet.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;



#---------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------

"8")

spaces_num=`netstat -nl|grep "$SPACES_PORT" |grep -v grep |awk 'END{print NR}'`

if [ $spaces_num -gt 0 ]
then echo "WC_Spaces Already RUNNING."
else echo "."
cd $DOMAIN_HOME/bin
echo "Starting WC_Spaces...."
nohup ./startManagedWebLogic.sh WC_Spaces > ~/WC_Spaces.out &
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" ~/WC_Spaces.out|grep -v grep |awk 'END{print NR}'`
while [ $spaces_run -eq 0 ]
do
sleep 5;
spaces_run=`grep -i "Server started in RUNNING mode" ~/WC_Spaces.out|grep -v grep |awk 'END{print NR}'`
done

fi
;;


#--------------------------------------------------------------------------------------------
"9")

echo "Starting Apache Server...."
sudo /etc/init.d/httpd start;

;;
#--------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
"10")
echo "Stopping  Oracle UCM [UCM_server1] ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh UCM_server1
;;

#---------------------------------------------------------------------------------------------
"11")
echo "Stopping  Oracle WebCenter Utilites [WC_Utilities] ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh WC_Utilities
;;
#---------------------------------------------------------------------------------------------
"12")
echo "Stopping  Oracle WebCenter Collaboration [WC_Collaboration] ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh WC_Collaboration
;;
#---------------------------------------------------------------------------------------------
"13")
echo "Stopping  Oracle WebCenter Portlet [WC_Portlet] ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh WC_Portlet
;;
#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
"14")
echo "Stopping  WC_Spaces ... "
cd $DOMAIN_HOME/bin
./stopManagedWebLogic.sh WC_Spaces
;;
#---------------------------------------------------------------------------------------------

"15")
echo "Stopping Admin Server [WLS_Admin] ..."
cd $DOMAIN_HOME/bin
./stopWebLogic.sh
;;

#--------------------------------------------------------------------------------------------
"16")
echo "Stopping the Apache Server"
sudo /etc/init.d/httpd stop;
;;
#---------------------------------------------------------------------------------------------

"17")
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
./stopManagedWebLogic.sh WC_Collaboration
./stopManagedWebLogic.sh WC_Utilities
./stopManagedWebLogic.sh WC_Portlet
./stopWebLogic.sh
sudo /etc/init.d/httpd stop

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

