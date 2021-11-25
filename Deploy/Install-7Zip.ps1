#Author: Christopher Sparrowgrove (info@itninjaztech.com)
#Name: RDT 7-ZIP Interactive Deployment V 1.0
#Desc: Initial Setup for All Clients and Sets up the ITNINJAZ folders and the Deployment Tool. This can be used to reset the client fter a delete or purge


#########################
##  COMPANY VARIABLES  ##
#########################
$RDT_DIR = "C:\COMPANY";                    $RDT_DEPLOY = "C:\COMPANY\Deploy";    
$RDT_LOGS = "C:\COMPANY\Logs";              $7ZIP_DIR = "C:\COMPANY\Deploy\7Zip";
$7ZIP_64DWNLD = "https://example.com/EXE/7z1900-x64.msi"
$7ZIP_32DWNLD = "https://example.com/EXE/7z1900-x32.msi"
$7ZIP_REG = "https://raw.githubusercontent.com/ITNinjaz-Technology/RDT/main/7-ZIP-FileAssoc.reg"
$7ZIP_DPLY_SCPT = "https://raw.githubusercontent.com/ITNinjaz-Technology/RDT/main/7-Zip-Package.ps1"


if(!(Test-Path -Path $RDT_DIR )){ exit;}
if(!(Test-Path -Path $RDT_DEPLOY )){ exit;}
if(!(Test-Path -Path $RDT_LOGS )){ exit;}

##########################
### START 7-ZIP Deploy ###
##########################

if(Get-Item -Path $7ZIP_DIR -ErrorAction Ignore) {Write-Output "7Zip Dir: 1" >> $RDT_LOGS"\7Zip.log"} #Check if AppDeploymentToolkit Exists
else {New-Item -Path $RDT_DEPLOY -Name "7Zip" -ItemType "directory"; Write-Output "7Zip Dir: 0" >> $RDT_LOGS"\7Zip.log"} #Copy AppDeploymentToolkit

if(Get-Item -Path $7ZIP_DIR"\AppDeployToolkit" -ErrorAction Ignore) {Write-Output "7Zip AppDeployToolKit Dir: 1" >> $RDT_LOGS"\7Zip.log"} #Check if AppDeploymentToolkit Exists
else {Copy-Item -Path $RDT_DEPLOY"\PSADT\Toolkit\AppDeployToolkit" -Destination $7ZIP_DIR"\AppDeployToolkit" -Recurse; Write-Output "7Zip AppDeployToolKit Dir: 0" >> $RDT_LOGS"\7Zip.log"} #Copy AppDeploymentToolkit

if(Get-Item -Path $7ZIP_DIR"\Files" -ErrorAction Ignore) {Write-Output "7Zip Files Dir: 1" >> $ITNT_LOGS"\7Zip.log"} #Check if 7Zip Files Exists
else {copy-Item -Path $RDT_DEPLOY"\PSADT\Toolkit\Files" -Destination $7ZIP_DIR"\Files" -Recurse; Write-Output "7Zip Files Dir: 0" >> $RDT_LOGS"\7Zip.log"} 

if(Get-Item -Path $7ZIP_DIR"\SupportFiles" -ErrorAction Ignore) {Write-Output "7Zip SupportFiles Dir: 1" >> $RDT_LOGS"\7Zip.log"} #Check if 7Zip SupportFiles Exists
else {copy-Item -Path $RDT_DEPLOY"\PSADT\Toolkit\SupportFiles" -Destination $7ZIP_DIR"\SupportFiles" -Recurse; Write-Output "7Zip SupportFiles Dir: 0" >> $RDT_LOGS"\7Zip.log"} 

if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit") #Check if System is 64bit - Added to save space from downloading both version to system
{ if(Get-Item -Path $7ZIP_DIR"\Files\7ZipInstaller-x64.msi" -ErrorAction Ignore) {Write-Output "7ZipInstallerx64.msiExists: 1" >> $RDT_LOGS"\Install.log"} #Check if 7z1900-x64.msi Exists
  else {Invoke-WebRequest -Uri $7ZIP_64DWNLD -Outfile $7ZIP_DIR"\Files\7ZipInstaller-x64.msi"; Write-Output "7ZipInstallerx64.msi Exists: 0" >> $RDT_LOGS"\7Zip.log"} }
else #Check if System is 32bit
{ if(Get-Item -Path $7ZIP_DIR"\Files\7ZipInstallerx32.msi" -ErrorAction Ignore) {Write-Output "7ZipInstallerx32.msi  Exists: 1" >> $RDT_LOGS"\7Zip.log"} #Check if 7z1900-x32.msi Exists
  else {Invoke-WebRequest -Uri $7ZIP_32DWNLD -Outfile $7ZIP_DIR"\Files\7ZipInstallerx32.msi"; Write-Output "7ZipInstallerx32.msi Exists: 0" >> $RDT_LOGS"\7Zip.log"} }

if(Get-Item -Path $7ZIP_DIR"\SupportFiles\7ZipFileAssoc.reg" -ErrorAction Ignore) {Write-Output "7ZipFileAssoc.reg Exists: 1" >> $RDT_LOGS"\7Zip.log"} #Check if 7ZipFileAssoc.reg Exists
else {Invoke-WebRequest -Uri $7ZIP_REG -Outfile $7ZIP_DIR"\SupportFiles\7ZipFileAssoc.reg"; Write-Output "7ZipFileAssoc.reg Exists: 0" >> $RDT_LOGS"\7Zip.log"}

if(Get-Item -Path $7ZIP_DIR"\7-Zip-Package.ps1" -ErrorAction Ignore) {Write-Output "7-Zip-Package.ps1 Exists: 1" >> $RDT_LOGS"\7Zip.log"} #Check if 7-Zip-Package.ps1 Exists
else {Invoke-WebRequest -Uri $7ZIP_DPLY_SCPT -Outfile $7ZIP_DIR"\7-Zip-Package.ps1"; Write-Output "7-Zip-Package.ps1 Exists: 0" >> $RDT_LOGS"\7Zip.log"}

Powershell.exe -ExecutionPolicy Bypass $7ZIP_DIR"\7-Zip-Package.ps1" -DeploymentType "Install" -DeployMode "Interactive"
