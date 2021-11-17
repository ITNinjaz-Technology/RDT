# PSSD
Full Powershell Deployment Script Repository Based on @PSAppDeployToolkit and Jason Bergner (https://silentinstallhq.com). This repo is to make it easier to deploy scripts and installations of software easier. All modifications are done so under the same GNU Lesser General Public License by @PSAppDeployToolkit

# Deploymnet (INSTALL)
Deployment Scripts Below will work for deploying the software or configurations. The first order is to create the temporary deployment folder and these steps asume you have the ability to pass script to a machine by reverse shell or logon scripts. After creating the directory for temporary use we download the the setup script, then unblock it, and than we deploy the script with a bypass method (Not Security Software may detect this as malicous). Also Make sure to change COMPANY to your company name.

The second script is an example of deployment of software created from the tutorial for 7Zip deployment from SilentDeployHQ.com

+ 1. mkdir C:\Windows\Temp\COMPANY\ && powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/ITNinjaz-Technology/PSSD/main/Setup.ps1 -Outfile C:\Windows\Temp\COMPANY\Setup.ps1; Unblock-File -Path C:\Windows\Temp\COMPANY\Setup.ps1 powershell -ExecutionPolicy Bypass -File C:\Windows\Temp\COMPANY\Setup.ps1

 2. powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/ITNinjaz-Technology/PSSD/main/deploy/561651/Install-7ZIP.ps1 -Outfile C:\COMPANY\Deploy\Install-7ZIP.ps1; Unblock-File -Path C:\COMPANY\Deploy\Install-7ZIP.ps1; powershell -ExecutionPolicy Bypass -File C:\COMPANY\Deploy\Install-7ZIP.ps1


#####################
##   DEFINITIONS   ##
#####################
#  CMN = Client Machine Name, This is the machine name of the computer the script is running on
#  DST = Deployment Stated Timestamp, This is the timestamp of when the deployment stated
#  CTE = Check TMP Exisits, This is the check of the directory exist where 1 = yes and 0 = no, but it was created. All should equal 0
#  PDE - Perminant Directory Exists, This checks if the perminant directory exists. 1= yes and 0 = no which should be default
#  LDE = Logs Directory Exists, This Checks if the COMPANY logs directory exits. 1 = yesand 0 = no. No is the default
#  BDE = Backups Directory Exists, This Checks if the COMPANY Backups directory exits. 1 = yesand 0 = no. No is the default
#  SDE = Scripts Directory Exists, This Checks if the COMPANY Scripts directory exits. 1 = yesand 0 = no. No is the default
#  DTKDE = Deployment ToolKit Directory Exists, This Checks if the directory exits. 1 = yesand 0 = no. No is the default
#  DTKE = Deployment ToolKit Exists, This Checks if the COMPANY logs directory exits. 1 = yesand 0 = no. No is the default
#  PSDTK = Powershell Deployment Tool Kit
#  SCL = Sucessfully Copy Log
