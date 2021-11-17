#Author: Christopher Sparrowgrove (info@itninjaztech.com)
#Name: MSP Remote Deployment Tools  (R-DepTools aka RDT) V 0.1.00
#Desc: Initial Setup script for new clients onboarding. This creates a folder called RDTANY  
#Desc: and downloads a copy of the Powershell Deployment Toolkit from Github and creates additional folders

#########################
##  COMPANY VARIABLES  ##
#########################
$RDT_TMP_DIR = "C:\Windows\Temp\COMPANY\";                 $RDT_TMP_LOG= "C:\Windows\Temp\COMPANY\Deployment.log"; 
$RDT_VERSION= "RDT - V 0.1.00";                            $RDT_DIR = "C:\COMPANY";
$RDT_LOGS = "C:\COMPANY\Logs";                             $RDT_BKUPS = "C:\COMPANY\Backups";   
$RDT_SCRIPTS = "C:\COMPANY\Scripts";                       $RDT_DEPLOY = "C:\COMPANY\Deploy";
$PSADT_DIR = "C:\COMPANY\Deploy\PSADT";                    $PSADT_FILE = "C:\COMPANY\Deploy\PSADT\PSAppDeployToolkit_v3.8.3.zip";
$PSADT_URI = "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/3.8.3/PSAppDeployToolkit_v3.8.3.zip";
$RDT_DEFAULT_LOG ="C:\COMPANY\Logs\RDT-DEPLOYMENT.log";

######################
## START DEPLOYMENT ##
######################

if(Get-Item -Path $RDT_TMP_DIR -ErrorAction Ignore) { #Check if TMP dir exisists
	Write-Output $RDT_VERSION >> $RDT_TMP_LOG; #Log Version Set Above
	Write-Output "CMN: $env:computername" >> $RDT_TMP_LOG; #Log Machine Name
	Write-Output "DS: "$(Get-Date) >> $RDT_TMP_LOG; #Log Time Started
	Write-Output "-------------------------" >> $RDT_TMP_LOG; #Add Line Break To Log
	Write-Output "CTE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before 
else { #if not exist 
	New-Item $RDT_TMP_DIR  -ItemType Directory; #Create TMP dir 
	Write-Output $RDT_VERSION >> $RDT_TMP_LOG; #Log Version Set Above
    Write-Output "CMN: $env:RDTutername" >> $RDT_TMP_LOG; #Log Machine Name
	Write-Output "DS: " $(Get-Date) >> $RDT_TMP_LOG; #Log Time Started
	Write-Output "-------------------------" >> $RDT_TMP_LOG; #Add Line Break To Log
	Write-Output "CTE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $RDT_DIR -ErrorAction Ignore) { #Check if RDT dir exists
	Write-Output "PDE: 1" >> $RDT_TMP_LOG;} #Log Directory Already Existed
else { #if not
	New-Item $RDT_DIR -ItemType Directory;  #Create RDT dir
	Write-Output "PDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $RDT_LOGS -ErrorAction Ignore) { #Check if Logs dir exists
	Write-Output "LDE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before
else { #if not
	New-Item $RDT_LOGS -ItemType Directory; #Create Logs dir
	Write-Output "LDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $RDT_BKUPS -ErrorAction Ignore) { #Check if Backups dir exists
	Write-Output "BDE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before
else { #if not
	New-Item $RDT_BKUPS -ItemType Directory; #Create Backups dir
	Write-Output "BDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $RDT_SCRIPTS -ErrorAction Ignore) { #Check if Scripts dir exists
	Write-Output "SDE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before
else { #if not
	New-Item $RDT_SCRIPTS -ItemType Directory; #Create Scripts dir
	Write-Output "SDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $RDT_DEPLOY -ErrorAction Ignore) { #Check if Deploy dir exists
	Write-Output "DDE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before 
else { #if not
	New-Item $RDT_DEPLOY -ItemType Directory; #Create Deploy dir
	Write-Output "DDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $PSADT_DIR -ErrorAction Ignore) { #Check if PS Deploymet Toolkit dir exists
	Write-Output "DTKDE: 1" >> $RDT_TMP_LOG;} #Log Directory Existed Before 
else { #if not
	New-Item $PSADT_DIR -ItemType Directory; #Create PS Deploymet Toolkit dir
	Write-Output "DTKDE: 0" >> $RDT_TMP_LOG;} #Log Directory Was Created
	
if(Get-Item -Path $PSADT_FILE -ErrorAction Ignore) { #Check if PS Deployment Toolkit exists 
	Write-Output "DTKE: 1" >> $RDT_TMP_LOG;} #Log File Existed Before 
else { #Download File
    $client = new-object System.Net.WebClient
    $client.DownloadFile($PSADT_URI, $PSADT_FILE);
    Write-Output "DTKE: 0" >> $RDT_TMP_LOG;} #Log File Was Created 
}

Unblock-File -Path $PSADT_FILE; Write-Output "Unblocked-PSDTK: 1" >> $RDT_TMP_LOG; #Log File Was Unblocked 
Expand-Archive -Path $PSADT_FILE -Destination $PSADT_DIR -Force; Write-Output "Extract-PSDTK: 1" >> $RDT_TMP_LOG #Log Extraction
Write-Output "Deployment Ended:" $(Get-Date) >> $RDT_TMP_LOG; #Log Time Ended

Copy-Item -Path $RDT_TMP_LOG -Destination $RDT_DEFAULT_LOG #Copy Log to RDT Logs Dir As New Name
if(Get-Item -Path $RDT_DEFAULT_LOG -ErrorAction Ignore) { #Check if New Log exists 
	Write-Output "SCL: 1" >> $RDT_DEFAULT_LOG; Write-Output "-------------------------" >> $RDT_DEFAULT_LOG} 
else { 
	Copy-Item -Path $RDT_TMP_LOG -Destination $RDT_DEFAULT_LOG #Copy Log to RDT Logs Dir
	Write-Output "SCL: 0" >> $RDT_DEFAULT_LOG; #Log Copied Over
    Write-Output "-------------------------" >> $RDT_DEFAULT_LOG; #Add Line Break To Log
    } 
