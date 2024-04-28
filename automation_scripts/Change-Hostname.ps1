param
(
    [string]$password = "pasword123",
    [string]$user = "Administrator",
    [string]$hostname = "localhost_1"
)
Write-Host -ForegroundColor Green "Changing_hostname"
$pass=ConvertTo-SecureString $password -AsPlainText -Force
$cred=New-Object System.Management.Automation.PSCredential ($user, $pass)
Rename-Computer -NewName $hostname -DomainCredential $cred

# syncing time
w32tm /config /syncfromflags:manual /manualpeerlist:time.nist.gov
w32tm /config /update
w32tm /resync

# install dot net 4.8
Start-Process C:\vagrant\CoolScripts\dotnet.4.8.exe -ArgumentList "/q /norestart /log c:\temp\" -Wait #Fire a new process to install silently
Write-Host "Installed 4.8 $LASTEXITCODE"