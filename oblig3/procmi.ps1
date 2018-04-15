foreach ($id in $args) { 
	$fil = "$id-"+(Get-Date -uformat "%Y%m%d")+"-"+(Get-Date -UFormat "%H%M%S")+".meminfo"
	$bruk = (Get-Process | Where-Object {$_.id -eq $id}).VirtualMemorySize/1Mb
    $ws = (Get-Process | Where-Object {$_.id -eq $id}).WorkingSet/1Kb
    write-output "     -----     Informasjon om minnebruk for $id     ------" > $fil
    write-output "   Bruk av virtuelt minne: $bruk Mb" >> $fil
    write-output "   Størrelse på Working Set: $ws Kb" >> $fil
}