
# Install all fonts in the folder as system fonts

$ExcludedFonts = "Monaco_Linux.ttf",
                 "Somefile.ttf"

$objShell = New-Object -ComObject Shell.Application
$Fonts = $objShell.Namespace(0x14)

$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path

Get-ChildItem $ScriptDir\*.ttf | ForEach-Object {
    if (!($ExcludedFonts -contains $_.Name)) {
        $Fonts.CopyHere($_.FullName)
        Write-Host "Installing" $_.Name
    } else {
        Write-Host "Skipping" $_.Name
    }
}

Write-Host "Completed"
#read-host # pause to show output
