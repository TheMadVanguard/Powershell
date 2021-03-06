# Info
#
# The script pings a list of servers. 
#
# Version 1.0
# Written by Jay

Import-Module ActiveDirectory
Import-Csv "C:\temp\servers.csv"
$servers = get-content C:\temp\servers.csv

$collection = $()
foreach ($server in $servers)
{
    $status = @{ "ServerName" = $server; "TimeStamp" = (Get-Date -f s) }
    if (Test-Connection $server -Count 1 -ea 0 -Quiet)
    { 
        $status["Results"] = "Up"
    } 
    else 
    { 
        $status["Results"] = "Down" 
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus

}

$collection | Sort-Object results | Format-Table -AutoSize -Property Servername,Results