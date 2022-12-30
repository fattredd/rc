

if (!($MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq '')) {
  # If file is invoked directly, not sourced
  if (Read-Host "Update powershell?" -eq 'y') {
    # Update powershell
    Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } - UseMSI"
  }
}

if (!(Get-Command "choco")) {
  # Install chocolatey
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function choco_install( $name, $apps ) {
  Write-Host $name "apps:"
  Write-Host "  " $apps
  if ((Read-Host "Install" $name "apps?") -eq 'y') {
    Write-Host "  Installing" + $apps
    choco install -y $apps
  }
}

if (!($MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq '')) {
  # If file is invoked directly, not sourced
  choco_install "basic" "firefox powertoys 7zip.install git.install"
  choco_install "recreation" "discord parsec"
  choco_install "work" "slack amazon-workspaces"
  choco_install "networking" "wireguard openvpn"
  choco_install "dev" "vscode msys2 cmder"
}
