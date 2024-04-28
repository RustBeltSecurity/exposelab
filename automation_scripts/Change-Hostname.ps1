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
$myURL="https://go.microsoft.com/fwlink/?linkid=2088631"
$myOutFile="C:\temp\dotnet.4.8.exe"

    if ( !(test-path -path $myOutFile)  ) {
        New-Item -Path 'c:\temp' -ItemType Directory
        $response = Invoke-WebRequest $myURL -UseBasicParsing
        [IO.File]::WriteAllBytes($myOutFile, $response.Content)
    }


    if ( (test-path -path $myOutFile)  ) {
       Write-Host "Installing 4.8"
    Start-Process C:\temp\dotnet.4.8.exe -ArgumentList "/q /norestart /log c:\temp\" -Wait #Fire a new process to install silently
    Write-Host "Installed 4.8 $LASTEXITCODE"
}