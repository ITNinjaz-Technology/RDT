# RDT
Full Powershell Deployment Script Repository Based on @PSAppDeployToolkit and Jason Bergner (https://silentinstallhq.com). This repo is to make it easier to deploy scripts and installations of software easier. All modifications are done so under the same GNU Lesser General Public License by @PSAppDeployToolkit.

# ANTI-VIRUS NOTE!
The script uses the Powershell Execution Piolicy bypass which is a method both administrators and Hackers use except most administrators usually use it in testing and then sign theire script also whitelisting it before deployment. Take this notice as you wish but this script is not malcious but as many tools it can be used to deploy malware but that is inherted from @PSAppDeployToolkit and my use of the Powersehll bypass which is well documented on the potential for abuse. It is a false positive but I am not responsible for anything that happens to your machines. This upload is for educational use only.

# Deploymnet (INSTALL / UNINSTALL)
Deployment is do using a customized script that Automates the process documented on SilentInstallHQ (Owned by Jason Bergner) and the setps on their are customized from the @PSAppDeployToolkit  and to make it even easier to deploy to each machine you only need the included example files and a location to host the download urls for the executables which is documented in the install and uninstall script. Below is an example of a one line powershell you can deploy to each target machine to recieve the deployment. The script does use some methods Hackers use to get the installation completed such as bypassing powershell execution policy.

First you Run #1 and then the Install deployment (#2 and/or #4 to install those programs) and you can run the Uninstall deployment if you want (#3 and/or #5)

# 1. Inital Setup
 * mkdir C:\Windows\Temp\COMPANY\ && powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/ITNinjaz-Technology/PSSD/main/Setup.ps1 -Outfile C:\Windows\Temp\COMPANY\Setup.ps1; Unblock-File -Path C:\Windows\Temp\COMPANY\Setup.ps1 powershell -ExecutionPolicy Bypass -File C:\Windows\Temp\COMPANY\Setup.ps1
 
# 2. Install Driver Booster (Universal Script)
 * powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/ITNinjaz-Technology/RDT/main/Deploy/Install-DriverBooster.ps1 -Outfile C:\COMPANY\Deploy\Install-DriverBooster.ps1; Unblock-File -Path C:\COMPANY\Deploy\Install-DriverBooster.ps1; powershell -ExecutionPolicy Bypass -File C:\COMPANY\Deploy\Install-DriverBooster.ps1


# 3. Uninstall Driver Booster (Universal Script)
 * powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/ITNinjaz-Technology/RDT/main/Deploy/Uninstall-DriverBooster.ps1 -Outfile C:\COMPANY\Deploy\Uninstall-DriverBooster.ps1; Unblock-File -Path C:\COMPANY\Deploy\Uninstall-DriverBooster.ps1; powershell -ExecutionPolicy Bypass -File C:\COMPANY\Deploy\Uninstall-DriverBooster.ps1
 
# 4. Install 7Zip Example (customized)
 * powershell Invoke-WebRequest -Uri https://github.com/ITNinjaz-Technology/RDT/blob/main/Deploy/Install - DriverBooster.ps1 -Outfile C:\COMPANY\Deploy\Install-7ZIP.ps1; Unblock-File -Path C:\COMPANY\Deploy\Install-7ZIP.ps1; powershell -ExecutionPolicy Bypass -File C:\COMPANY\Deploy\Install-7ZIP.ps1
 
# 5. Uninstall 7Zip Example (Customized)
 * powershell Invoke-WebRequest -Uri https://github.com/ITNinjaz-Technology/RDT/blob/main/Deploy/Install - DriverBooster.ps1 -Outfile C:\COMPANY\Deploy\Uninstall-7ZIP.ps1; Unblock-File -Path C:\COMPANY\Deploy\Uninstall-7ZIP.ps1; powershell -ExecutionPolicy Bypass -File C:\COMPANY\Deploy\Uninstall-7ZIP.ps1



#  DEFINITIONS   
+  CMN = Client Machine Name, This is the machine name of the computer the script is running on
+  DST = Deployment Stated Timestamp, This is the timestamp of when the deployment stated
+  CTE = Check TMP Exisits, This is the check of the directory exist where 1 = yes and 0 = no, but it was created. All should equal 0
+  PDE - Perminant Directory Exists, This checks if the perminant directory exists. 1= yes and 0 = no which should be default
+  LDE = Logs Directory Exists, This Checks if the COMPANY logs directory exits. 1 = yesand 0 = no. No is the default
+  BDE = Backups Directory Exists, This Checks if the COMPANY Backups directory exits. 1 = yesand 0 = no. No is the default
+  SDE = Scripts Directory Exists, This Checks if the COMPANY Scripts directory exits. 1 = yesand 0 = no. No is the default
+  DTKDE = Deployment ToolKit Directory Exists, This Checks if the directory exits. 1 = yesand 0 = no. No is the default
+  DTKE = Deployment ToolKit Exists, This Checks if the COMPANY logs directory exits. 1 = yesand 0 = no. No is the default
+  PSDTK = Powershell Deployment Tool Kit
+  SCL = Sucessfully Copy Log
