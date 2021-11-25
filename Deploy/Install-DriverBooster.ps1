
#Author: Christopher Sparrowgrove (info@itninjaztech.com)
#Name: RDT Interactive Deployment V 1.0
#Desc: Initial Setup for All Clients and Sets up the ITNINJAZ folders and the Deployment Tool. This can be used to reset the client fter a delete or purge

#############################
##  APPLICATION VARIABLES  ##
#############################
$APP_NAME ="IOBit";                                   #Application Name (No Slashes In Name)
$x64_INSTALLER_NAME = "driver_booster_setup.exe";     #Installer Exact Name (With extention)
$x32_INSTALLER_NAME = "driver_booster_setup.exe";     #Installer Exact Name (With extention)
$INSTALLER_SCRIPT_NAME = "DriverBooster-Package.ps1"; #Installer Exact Name (With extention)

$x64_DWNLD_LINK = "https://YOURFILEHOST.COM/download/driver_booster_setup.exe";
$x32_DWNLD_LINK = "https://YOURFILEHOST.COM/download/driver_booster_setup.exe";
$DPLY_SCPT = "https://YOURFILEHOST.COM/Deploy/DriverBooster-Package.ps1";

#########################
##  COMPANY VARIABLES  ##
#########################
$RDT_DIR = "C:\COMPANY\";                     #Default Company Path                      
$RDT_DEPLOY = "C:\COMPANY\Deploy";            #Default Deployment Path
$RDT_LOGS = "C:\COMPANY\Logs";                #Default Logs Path         


########################
### START APP Deploy ### DO NOT EDIT BELOW HERE
########################

$TIMESTAMP = Get-Date -Format "MM/dd/yyyy HH:mm K";

#RDT Readiness Check
if(!(Test-Path -Path $RDT_DIR )){ exit;}
if(!(Test-Path -Path $RDT_DEPLOY )){ exit;}
if(!(Test-Path -Path $RDT_LOGS )){ exit;}

# Deployment Readiness Check
if(Get-Item -Path $RDT_DEPLOY"\"$APP_NAME -ErrorAction Ignore) 
    {
        Write-Output "[$TIMESTAMP ] Directory $RDT_DEPLOY\$APP_NAME\ Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
    }
else 
    {
        New-Item -Path $RDT_DEPLOY"\"$APP_NAME -ItemType "directory"; 
        Write-Output "[$TIMESTAMP ] Directory $RDT_DEPLOY\$APP_NAME\ Was Created" >> $RDT_LOGS"\"$APP_NAME".log"
    } 

#AppDeploymentToolkit
if(Get-Item -Path $RDT_DEPLOY"\"$APP_NAME"\AppDeployToolkit" -ErrorAction Ignore) 
    {
        Write-Output "[$TIMESTAMP ] Directory $RDT_DEPLOY\$APP_NAME\AppDeployToolKit\ Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
    }
else 
    {
        Copy-Item -Path $RDT_DEPLOY"\PSADT\Toolkit\AppDeployToolkit" -Destination $RDT_DEPLOY"\"$APP_NAME"\AppDeployToolkit" -Recurse; 
        Write-Output "[$TIMESTAMP ] Directory $RDT_DEPLOY\$APP_NAME\AppDeployToolKit\ Was Created" >> $RDT_LOGS"\"$APP_NAME".log"
    }

# Files Directory
if(Get-Item -Path $RDT_DEPLOY"\"$APP_NAME"\Files" -ErrorAction Ignore) 
    {
        Write-Output "[$TIMESTAMP] Directory $RDT_DEPLOY\$APP_NAME\Files\ Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
    } 
else 
    {
        Copy-Item -Path $RDT_DEPLOY"\PSADT\Toolkit\Files" -Destination $RDT_DEPLOY"\"$APP_NAME"\Files" -Recurse; 
        Write-Output "[$TIMESTAMP] Directory $RDT_DEPLOY\$APP_NAME\Files\ Was Created" >> $RDT_LOGS"\"$APP_NAME".log"
    } 


if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit") #Check if System is 64bit - Added to save space from downloading both version to system
    { 
        if(Get-Item -Path $DEPLOY_DIR"\"$APP_NAME"\Files\"$x64_INSTALLER_NAME -ErrorAction Ignore) 
            {
                Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$APP_NAME\$x64_INSTALLER_NAME Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
            } 
        else 
            {
                Invoke-WebRequest -Uri $x64_DWNLD_LINK -Outfile $RDT_DEPLOY"\"$APP_NAME"\Files\"$x64_INSTALLER_NAME; 
                Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$APP_NAME\$x64_INSTALLER_NAME Was Downloaded" >> $RDT_LOGS"\"$APP_NAME".log"
            } 
    }
else #Check if System is 32bit
    { 
        if(Get-Item -Path $DEPLOY_DIR"\"$APP_NAME"\Files\"$x32_INSTALLER_NAME -ErrorAction Ignore) 
            {
                Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$APP_NAME\$x32_INSTALLER_NAME Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
            } 
        else 
            {
                Invoke-WebRequest -Uri $x32_DWNLD_LINK -Outfile $DEPLOY_DIR"\Files\"$x32_INSTALLER_NAME; 
                Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$APP_NAME\$x32_INSTALLER_NAME Was Downloaded" >> $RDT_LOGS"\"$APP_NAME".log"
            } 
    }

if(Get-Item -Path $RDT_DEPLOY"\"$INSTALLER_SCRIPT_NAME -ErrorAction Ignore) 
    {
        Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$INSTALLER_SCRIPT_NAME Already Exists" >> $RDT_LOGS"\"$APP_NAME".log"
    } 
else 
    {
        Invoke-WebRequest -Uri $DPLY_SCPT -Outfile $RDT_DEPLOY"\"$APP_NAME"\"$INSTALLER_SCRIPT_NAME; 
        Write-Output "[$TIMESTAMP ] File $RDT_DEPLOY\$INSTALLER_SCRIPT_NAME Was Downloaded" >> $RDT_LOGS"\"$APP_NAME".log"
    }

Powershell.exe -ExecutionPolicy Bypass $RDT_DEPLOY"\"$APP_NAME"\"$INSTALLER_SCRIPT_NAME -DeploymentType "Install" -DeployMode "Interactive"
