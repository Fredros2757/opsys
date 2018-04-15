
#Kanskje ikke på den måten som var ment, men teknisk sett 1 linje? ;D
$procs = (Get-Process chrome).id; foreach ($proc in $procs) { $antthread = ((Get-Process | Where-Object {$_.id -eq $proc}).Threads).Count; write-output "chrome $proc $antthread" }