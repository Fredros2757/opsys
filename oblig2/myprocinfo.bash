#!/bin/bash

echo "1 - Hvem er jeg og hva er navnet på dette scriptet?"
echo "2 - Hvor lenge er det siden siste boot?"
echo "3 - Hvor mange prosesser og tråder finnes?"
echo "4 - Hvor mange context switch'er fant sted siste sekund?"
echo "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
echo "6 - Hvor mange interrupts fant sted siste sekund?"
echo "9 - Avslutt dette scriptet"
echo "Kommando: "

read valg

while [ $valg != 9 ]
do
case $valg in
     1)
	  jeg=$(whoami)
	  fil=$(basename $0)
          echo "Navnet på dette scriptet er: " 
	  echo $fil
	  echo "Jeg er: "
	  echo $jeg
          ;;
     2)
	  sisteboot=$(uptime -s)
	  echo "Siste boot var: $sisteboot"
	  current=$(date +%s)
	  bootcheck=$(cat /proc/stat | grep btime | awk '{print $2}')
	  total=$(($current - $bootcheck))
	  dager=$(($total / 86400))
	  rest=$(($total - ($dager * 86400)))
	  timer=$(($rest / 3600))
	  rest2=$(($rest - ($timer * 3600)))
	  minutter=$(($rest2 / 60))
	  sekunder=$((rest2 - ($minutter * 60)))
	  echo "$dager dager, $timer timer, $minutter minutter, $sekunder sekunder siden."
	  ;;
     3)
	  antproc=$(ps aux --no-heading | wc -l)
	  antthread=$(ps aux --no-heading -T | wc -l)
	  echo "Antall prosesser som kjører er: "
          echo $antproc
          echo "Antall tråder som kjører er: "
	  echo $antthread
	  ;;
     4)
	  ctxtswitch1=$(cat /proc/stat | grep ctxt | awk '{print $2}')
          sleep 1
	  ctxtswitch2=$(cat /proc/stat | grep ctxt | awk '{print $2}')
	  ctxtdiff=$(($ctxtswitch2 - $ctxtswitch1))
          echo "Antall context switcher i siste sekund var: "
	  echo $ctxtdiff
          ;;
     5)
	  usertid1=$(cat /proc/stat | grep -w cpu | awk '{print $2}')
	  kerneltid1=$(cat /proc/stat | grep -w cpu | awk '{print $4}')

	  sleep 1

	  usertid2=$(cat /proc/stat | grep -w cpu | awk '{print $2}')
          kerneltid2=$(cat /proc/stat | grep -w cpu | awk '{print $4}')

	  usersec=$(($usertid2 - $usertid1))
	  kernelsec=$(($kerneltid2 - $kerneltid1))
	  totalsec=$(($usersec + $kernelsec))

	  echo "Andel av CPU-tid i usermode: "
	  echo "$usersec av $totalsec"
	  echo "Andel av CPU-tid i kernelmode: "
	  echo "$kernelsec av $totalsec"
	  ;;
     6)
	  interrupt1=$(cat /proc/stat | grep intr | awk '{print $2}')
          sleep 1
          interrupt2=$(cat /proc/stat | grep intr | awk '{print $2}')
          intrpt=$(($interrupt2 - $interrupt1))
          echo "Antall interrupts i siste sekund var: "
          echo $intrpt
	  ;;
     *)
	  echo "Ugyldig input"
	  ;;
esac
echo "Ny kommando: "
read valg
done
