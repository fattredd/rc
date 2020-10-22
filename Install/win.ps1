
mkdir -p C:\bin\bin

# Update the User PATH
[Environment]::SetEnvironmentVariable("Path", $env:Path + 
	";C:\bin;C:\bin\bin",
	[EnvironmentVariableTartget]::Machine
)

# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force;
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install fattredd.cmder.dev -y
choco install curl nvm wget -y
choco install python3 7zip git vlc notepadplusplus -y
choco install googlechrome firefox openssh -y
choco install sysinternals autohotkey ccleaner -y
choco install boost-msvc-14.1 sumatrapdf.install yarn -y
choco install vscode.install

# Create symbolic links from Win folder
<#
Get-ChildItem "..\Win\AppData\Roaming" | 
Foreach-Object {
    echo $_
    Remove-Item -Force -Recurse -Path ~\AppData\Roaming\$_
    new-item -itemtype symboliclink -path ~\AppData\Roaming\$_ -value ..\Win\AppData\Roaming\$_
}
#>

pip install dploy
echo "Go to .rc/Home and run:"
echo "> dploy stow {folders} $env:USERPROFILE"
