#!/bin/bash/

for i in $@
do
vmsize=$(cat /proc/$i/status | grep VmSize | awk '{print $2}')
vmdata=$(cat /proc/$i/status | grep VmData | awk '{print $2}')
vmstk=$(cat /proc/$i/status | grep VmStk | awk '{print $2}')
vmexe=$(cat /proc/$i/status | grep VmExe | awk '{print $2}')
vmpriv=$(($vmdata + $vmstk + $vmexe))
vmlib=$(cat /proc/$i/status | grep VmLib | awk '{print $2}')
vmrss=$(cat /proc/$i/status | grep VmRSS | awk '{print $2}')
vmpte=$(cat /proc/$i/status | grep VmPTE | awk '{print $2}')
echo "Minneinformasjon om prosess med PID $i" > meminfo/$i-$(date +"%Y%m%d").meminfo
echo "VmSize: $vmsize" >> meminfo/$i-$(date +"%Y%m%d").meminfo
echo "Privat virtuelt minne: $vmpriv" >> meminfo/$i-$(date +"%Y%m%d").meminfo
echo "Shared virtuelt minne: $vmlib" >> meminfo/$i-$(date +"%Y%m%d").meminfo
echo "Totalt fysisk minne brukt: $vmrss" >> meminfo/$i-$(date +"%Y%m%d").meminfo
echo "Fysisk minne brukt til page table: $vmpte" >> meminfo/$i-$(date +"%Y%m%d").meminfo
done
