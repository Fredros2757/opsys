#!/bin/bash/

for i in "$@"
do
vmsize=$(grep VmSize /proc/"$i"/status | awk '{print $2}')
vmdata=$(grep VmData /proc/"$i"/status | grep VmData | awk '{print $2}')
vmstk=$(grep VmStk /proc/"$i"/status | grep VmStk | awk '{print $2}')
vmexe=$(grep VmExe /proc/"$i"/status | grep VmExe | awk '{print $2}')
vmpriv=$(("$vmdata" + "$vmstk" + "$vmexe"))
vmlib=$(grep VmLib /proc/"$i"/status | awk '{print $2}')
vmrss=$(grep VmRSS /proc/"$i"/status | awk '{print $2}')
vmpte=$(grep VmPTE /proc/"$i"/status | awk '{print $2}')
echo "Minneinformasjon om prosess med PID $i" > meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "VmSize: $vmsize" >> meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "Privat virtuelt minne: $vmpriv" >> meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "Shared virtuelt minne: $vmlib" >> meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "Totalt fysisk minne brukt: $vmrss" >> meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "Fysisk minne brukt til page table: $vmpte" >> meminfo/"$i"-"$(date +"%Y%m%d")".meminfo
echo "Informasjon om prosessene ($*) har blitt skrevet til filer i mappen meminfo."
done
