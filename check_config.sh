#!/bin/ksh
#
#  The script will capture server configuration outputs
#
#
#  *****************

# Constants
    # color names
    YELLOW="\033[1;33m"
    WHITE="\033[1;37m"
    GREEN="\033[1;32m"
    RED="\033[1;31m"
    CYAN="\033[01;36m"
    INPUTBOX="\033[04;47m"
    RSTCOLOR="\033[0m"
    BLUE="\033[1;34m"
    RW=`printf "\174"`
    BOLD="\033[1m"

conf_start()
{
>/tmp/`hostname`.config.txt
echo "===========================Server configuration output================"  >>/tmp/`hostname`.config.txt
echo "===========================lsmcode==================================" >>/tmp/`hostname`.config.txt
lsmcode -c >>/tmp/`hostname`.config.txt
echo "================= df-g ========================" >>/tmp/`hostname`.config.txt
echo "========================== last reboot; df -g count ==========" >>/tmp/`hostname`.config.txt
df -g >>/tmp/`hostname`.config.txt
df -k |wc -l >>/tmp/`hostname`.config.txt
echo "================== date =======================" >>/tmp/`hostname`.config.txt
date >>/tmp/`hostname`.config.txt
echo "================== Mount =======================" >>/tmp/`hostname`.config.txt
mount >>/tmp/`hostname`.config.txt
echo "================== last reboot =======================" >>/tmp/`hostname`.config.txt
who -b >>/tmp/`hostname`.config.txt
echo "================== lsfs =======================" >>/tmp/`hostname`.config.txt
lsfs >>/tmp/`hostname`.config.txt
echo "================== IP details =======================" >>/tmp/`hostname`.config.txt
ifconfig -a >>/tmp/`hostname`.config.txt
echo "====================netstat=====================" >>/tmp/`hostname`.config.txt
netstat -nr >>/tmp/`hostname`.config.txt
echo "==================== lspv =====================" >>/tmp/`hostname`.config.txt
lspv >>/tmp/`hostname`.config.txt
echo "=================== lsvg -o ======================" >>/tmp/`hostname`.config.txt
lsvg -o >>/tmp/`hostname`.config.txt
echo "==================lsvg -l allvgs=======================" >>/tmp/`hostname`.config.txt
for i in `lsvg -o `; do echo "============ $i ============="; lsvg -Ll $i; done >>/tmp/`hostname`.config.txt
echo "==================lsvg -p allvgs=======================" >>/tmp/`hostname`.config.txt
for i in `lsvg -o `; do echo "============ $i ============="; lsvg -p $i; done >>/tmp/`hostname`.config.txt
echo "==================== bootlist =====================" >>/tmp/`hostname`.config.txt
bootlist -m normal -o >>/tmp/`hostname`.config.txt
echo "==================== bootinfo -p =====================" >>/tmp/`hostname`.config.txt
bootinfo -p >>/tmp/`hostname`.config.txt
echo "==================== bootinfo -K =====================" >>/tmp/`hostname`.config.txt
bootinfo -K >>/tmp/`hostname`.config.txt
echo "=================== oslevel -r ======================" >>/tmp/`hostname`.config.txt
oslevel -r >>/tmp/`hostname`.config.txt
echo "================== oslevel -rq =======================" >>/tmp/`hostname`.config.txt
oslevel -rq >>/tmp/`hostname`.config.txt
echo "================== Adapter =======================" >>/tmp/`hostname`.config.txt
lsdev -Cc adapter >>/tmp/`hostname`.config.txt
echo "==================== Disk =====================" >>/tmp/`hostname`.config.txt
lsdev -Cc disk >>/tmp/`hostname`.config.txt
echo "=================== lscfg ======================" >>/tmp/`hostname`.config.txt
lscfg >>/tmp/`hostname`.config.txt
echo "===================lsslot output======================" >>/tmp/`hostname`.config.txt
lsslot -c slot >>/tmp/`hostname`.config.txt
echo "=================== lsvg -p rootvg ======================" >>/tmp/`hostname`.config.txt
lsvg -p rootvg >>/tmp/`hostname`.config.txt
echo "=================== rootvgdisks LV information  ======================" >>/tmp/`hostname`.config.txt
lsvg -p rootvg | grep -i hdisk | awk '{print $1}' | xargs -I{} -t lspv -l {} >>/tmp/`hostname`.config.txt
echo "===================== Cluster ====================" >>/tmp/`hostname`.config.txt
lssrc -g cluster >>/tmp/`hostname`.config.txt
echo "======================== All Active services info ===========================" >>/tmp/`hostname`.config.txt
lssrc -a |grep "active" >>/tmp/`hostname`.config.txt
echo "=================== fibre cards wwn ======================" >>/tmp/`hostname`.config.txt
for i in `lsdev -Cc adapter | grep fcs | awk '{print $1}'`; do echo $i;lscfg -vl $i | grep -i net; done >>/tmp/`hostname`.config.txt
echo "=========== passwd file ==========================" >>/tmp/`hostname`.config.txt
cat /etc/passwd >>/tmp/`hostname`.config.txt
echo "=================================================" >>/tmp/`hostname`.config.txt
echo "==========Group file=============================" >>/tmp/`hostname`.config.txt
cat /etc/group >>/tmp/`hostname`.config.txt
echo "==================== Memory =====================" >>/tmp/`hostname`.config.txt
lsattr -El mem0|awk '{print $1"  " $2}' >>/tmp/`hostname`.config.txt
echo "================ Paging Space ===================" >>/tmp/`hostname`.config.txt
lsps -a >>/tmp/`hostname`.config.txt
echo "=================================================">>/tmp/`hostname`.config.txt
echo "=================== lsvg =========================">>/tmp/`hostname`.config.txt
lsvg >>/tmp/`hostname`.config.txt
echo "==================Prtconf========================">>/tmp/`hostname`.config.txt
prtconf >>/tmp/`hostname`.config.txt
echo "================================================">>/tmp/`hostname`.config.txt
echo "==================OSLEVEL -S========================">>/tmp/`hostname`.config.txt
oslevel -s>>/tmp/`hostname`.config.txt
echo "================================================">>/tmp/`hostname`.config.txt
echo "==================nfs start========================">>/tmp/`hostname`.config.txt
exportfs -v | grep -v "exportfs:" >>/tmp/`hostname`.config.txt
echo "==========================nfs end======================">>/tmp/`hostname`.config.txt
echo "==========================Ifix Info======================">>/tmp/`hostname`.config.txt
emgr -l >>/tmp/`hostname`.config.txt
echo "================================================">>/tmp/`hostname`.config.txt
echo "==========================Lppchk======================">>/tmp/`hostname`.config.txt
lppchk -v >>/tmp/`hostname`.config.txt
echo "================================================">>/tmp/`hostname`.config.txt
echo "==================EtherChannel Informationt========================">>/tmp/`hostname`.config.txt
lsdev -Cc adapter | grep -i EtherChannel | awk '{print $1}' > ether
for et in `cat ether`
do
echo "Etherchannel Adapter : $et"
pr=`lsattr -El $et | egrep -i 'adapter_names' | awk '{print $2}'`
sc=`lsattr -El $et | egrep -i 'backup_adapter' | awk '{print $2}'`
echo "-----------------start$et-----------------------------"
echo "Primary Adapter : $pr"
echo "Backup Adapter : $sc"
echo "----------------end$et------------------------------"
done >>/tmp/`hostname`.config.txt
rm ether
echo "=========================Etherchannel End =========================">>/tmp/`hostname`.config.txt
echo "==================BootList Information========================">>/tmp/`hostname`.config.txt
bootlist -m normal -o >>/tmp/`hostname`.config.txt
echo "==================BootList Information Ends========================">>/tmp/`hostname`.config.txt
echo "==================Boot Info=======================">>/tmp/`hostname`.config.txt
bootinfo -v >>/tmp/`hostname`.config.txt
echo "==================Boot Info End=======================" >>/tmp/`hostname`.config.txt
echo "==================End Report=======================" >>/tmp/`hostname`.config.txt
}

HST=`hostname`
ls -l /tmp/$HST.config.txt > /dev/null 2>&1
if [ $? -eq 0 ];  then
CDT=`date | awk '{print $3}'`
FDT=`ls -l /tmp/$HST.config.txt |awk '{print $7}'`
CDT=$CDT-1
 if [ $FDT -ge $CDT ]; then
 tput cup 29 70;echo ${BOLD}${GREEN} "file is latest"${RSTCOLOR}
 read
 tput cup 29 70;echo "                                            "
 exit 0
 fi
else
conf_start
fi

