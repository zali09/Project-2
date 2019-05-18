#!/bin/ksh
#
#  The script for auto check FS and paging the 
#  system dump size is OK
#
#
#  *****************


#check FS is mounted
for fs1 in `lsfs -a | awk '{print $3}' |sed -n '1!p'`
do
 df -g |grep -i $fs1 >/dev/null 2>&1
   if [ $? -ne 0 ];  then
   echo "This FS is not mounted  " $fs1
  fi
done

# check FS is exist in /etc/filesystem
for fs2 in `df -g |awk '{print $7}' |sed -n '1!p'`
 do
  if [ $fs2 == "%Iused" ]; then
     continue
   else
      if [ $fs2 == "/" ]; then
        continue
      else
   lsfs -a |grep -i $fs2 >/dev/null 2>&1
     if [ $? -ne 0 ];  then
     echo "This FS is not exist in FS file  " $fs2
     fi
  fi
  fi
done

# check FS is Auto-mounted
for fs3 in `lsfs | awk '$7 == "no"' | awk '{print $3}'`
do
echo "This filesystem is not Auto-mounted   " $fs3
done

#Check Paging is Auto-actived
for ps1 in `lsps -a | sed -n '1!p' | awk '$7 == "no"' | awk '{print $1}'`
 do
 echo "This paging is not Auto-active mode    " $ps1
 done

#Check Paging is Active
for ps2 in `lsps -a | sed -n '1!p' | awk '$6 == "no"' | awk '{print $1}'`
 do
 echo "This paging is not active   " $ps2
 done
