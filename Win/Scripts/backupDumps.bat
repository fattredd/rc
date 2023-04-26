@echo off

set source=C:\Windows\Minidump\*.dmp
set dest=\\10.0.0.19\Other\winDump

for /f "tokens=*" %%i in ('hostname') do (
  set host=%%i
  goto :done
  )
:done

md %dest%\%host%\
echo Copying Minidump files from %source% to %dest%\%host%\
copy %source% %dest%\%host%\
copy C:\Windows\MEMORY.DMP %dest%\%host%\
