


Set-ExecutionPolicy Bypass -Scope Process -Force;
#iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Create symbolic links from Win folder
Get-ChildItem "..\Win\AppData\Roaming" | 
Foreach-Object {
    echo $_
    Remove-Item -Force -Recurse -Path ~\AppData\Roaming\$_
    new-item -itemtype symboliclink -path ~\AppData\Roaming\$_ -value ..\Win\AppData\Roaming\$_
}
