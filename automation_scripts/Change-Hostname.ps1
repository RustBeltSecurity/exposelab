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
w32tm /resync /server:time.nist.gov

# install dot net 4.8
cp C:\vagrant\CoolScripts\ndp48-x86-x64-allos-enu.exe C:\temp
Start-Process C:\temp\ndp48-x86-x64-allos-enu.exe -ArgumentList "/q /norestart /log c:\temp\" -Wait #Fire a new process to install silently
Write-Host "Installed 4.8 $LASTEXITCODE"