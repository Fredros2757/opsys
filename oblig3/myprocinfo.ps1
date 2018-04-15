write-output "1 - Hvem er jeg og hva er navnet på dette scriptet?"
write-output "2 - Hvor lenge er det siden siste boot?"
write-output "3 - Hvor mange prosesser og tråder finnes?"
write-output "4 - Hvor mange context switch'er fant sted siste sekund?"
write-output "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?"
write-output "6 - Hvor mange interrupts fant sted siste sekund?"
write-output "9 - Avslutt dette scriptet"


while ($valg -eq 9 -Or 1 -Or 2 -Or 3 -Or 4 -Or 5 -Or 6) 
{
	
	$valg = Read-Host -Prompt "Hvilken kommando vil du kjøre?   "

	switch ( $valg )
	{

		1 {
			$brukernavn = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
			$scriptnavn = $MyInvocation.MyCommand.Name

			write-output "Brukernavnet er : " $brukernavn
			write-output "Scripter som kjører er: " $scriptnavn		
		}
	
		2 {
			$boot = Get-CimInstance win32_operatingsystem
			$uptime = (Get-Date) - $boot.LastBootUptime
			$utskrift = $uptime.ToString("dd' dager 'hh' timer 'mm' minutter'")
			write-output "Tid siden siste boot er: " $utskrift
		}

		3 {
			$antproc = (Get-Process | Sort-Object name | Measure-Object).Count
			$antthread = (Get-Process | Select-Object -ExpandProperty Threads).Count
			write-output "Antall prosesser som kjører er: " $antproc
			write-output "Antall tråder som kjører er: " $antthread
		}

		4 {
			$antcswitch = ((Get-Counter -Counter "\System\Context Switches/sec").CounterSamples).CookedValue
			write-output "Antall context-switcher i siste sekund var: " $antcswitch
		}
		
		5 {
			$strComputer = "."
			$procs = Get-Process -ComputerName $strComputer
			foreach ($proc in $procs) {
	    			if ($proc.ProcessName -eq "notepad") {
        				$kerneltime += ($proc.PrivilegedProcessorTime.TotalMilliseconds)
       					$usertime += ($proc.UserProcessorTime.TotalMilliseconds)
    				}
			}
			write-output "Tid brukt i kernelmode: " $kerneltime
			write-output "Tid brukt i usermode: " $usertime
		}
	
		6 {
			$interrupts = ((Get-Counter "\Processor(_total)\Interrupts/sec").CounterSamples).CookedValue
			write-output "Antall interrupts i siste sekund: " $interrupts
		}

		9 {
			exit
		}
	}
}