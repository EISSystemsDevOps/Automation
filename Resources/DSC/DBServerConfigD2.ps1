Configuration DBServerConfigD2
{
   param 
   ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Admincreds,

       # [Int]$RetryCount=20,
       # [Int]$RetryIntervalSec=30,

       # [Parameter(Mandatory)]
       # [String]$StorageAccountName,

       # [Parameter(Mandatory)]
       # [String]$StorageAccountContainer,

       # [Parameter(Mandatory)]
       # [String]$StorageAccountKey,
        
        [Parameter(Mandatory=$false)]
        [String]$StorageAccountContainerBackups='backups',

        [Parameter(Mandatory=$false)]
        [String]$BackupFileName='paragon_test_20160427-blob.bak',
        
        [Parameter(Mandatory=$false)]
        [String]$SourceDBName='paragon_test'



    ) 

    Import-DscResource -ModuleName PSDesiredStateConfiguration, xPendingReboot #, xAzureStorage #xSQLServer    
    #Get-DscResource xSQLServerSetup |select -expand properties   
    #$admincreds=Get-Credential
    #$domainname='IRMCHOSTED.COM'
   
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
    $Username=$DomainName+'\'+$Admincreds.Username
    $Pass=$Admincreds.getnetworkcredential().password
	Node ("localhost")
 	{
        LocalConfigurationManager
        {
           RebootNodeIfNeeded = $true
        }

#PARAGON Server Common Config 
#Set-ParagonServerCommonConfig
 		Script Set-ParagonPowerPlan
        	{
	            SetScript = { Powercfg -SETACTIVE SCHEME_MIN }
	            TestScript = { return ( Powercfg -getactivescheme) -like "*High Performance*" }
	            GetScript = { return @{ Powercfg = ( "{0}" -f ( powercfg -getactivescheme ) ) } }
        	}

#Set-ParagonMSDTCConfig
        #SET-ITEMPROPERTY HKLM:\software\microsoft\ole -name "EnableDCOM" -value "Y" -ErrorAction Stop
        Registry EnableDCOM
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\ole"
            ValueName = "EnableDCOM"
            ValueData = "Y"
        }
        #SET-ITEMPROPERTY HKLM:\software\microsoft\ole -name "LegacyImpersonationLevel" -value 2 -type "Dword" -ErrorAction SilentlyContinue
        Registry LegacyImpersonationLevel
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\ole"
            ValueName = "LegacyImpersonationLevel"
            ValueData = "2"
            ValueType ="Dword"
        }
 
        #SET-ITEMPROPERTY HKLM:\software\microsoft\ole -name "LegacyAuthenticationLevel" -value 2 -type "Dword" -ErrorAction SilentlyContinue
        Registry LegacyAuthenticationLevel
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\ole"
            ValueName = "LegacyAuthenticationLevel"
            ValueData = "2"
            ValueType ="Dword"
        }
        
        #SET-ITEMPROPERTY HKLM:\software\microsoft\ole -name "MachineLaunchRestriction" `
        #            -value ([byte[]](0x01,0x00,0x04,0x80,0x90,0x00,0x00,0x00,0xa0,0x00,0x00,0x00,0x00, `
        #            0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x02,0x00,0x7c,0x00,0x05,0x00,0x00,0x00,0x00, `
        #            0x00,0x14,0x00,0x1f,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00, `
        #            0x00,0x00,0x00,0x00,0x00,0x18,0x00,0x0b,0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00, `
        #            0x00,0x00,0x0f,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x18,0x00,0x1f, `
        #            0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
        #            0x02,0x00,0x00,0x00,0x00,0x18,0x00,0x1f,0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00, `
        #            0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x2f,0x02,0x00,0x00,0x00,0x00,0x18,0x00,0x1f, `
        #            0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x32, `
        #            0x02,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
        #            0x02,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
        #            0x02,0x00,0x00)) -ErrorAction Stop
<#   
        Registry MachineLaunchRestriction
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\ole"
            ValueName = "MachineLaunchRestriction"
            ValueData = $value
        }
#>


        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "networkdtcaccess" -value "1" -ErrorAction Stop
        Registry networkdtcaccess
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "networkdtcaccess"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "networkdtcaccessadmin" -value "1" -ErrorAction Stop
        Registry networkdtcaccessadmin
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "networkdtcaccessadmin"
            ValueData = "1"
        }
        
        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "networkdtcaccessinbound" -value "1" -ErrorAction Stop
        Registry networkdtcaccessinbound
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "networkdtcaccessinbound"
            ValueData = "1"
        }
        
        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "networkdtcaccessoutbound" -value "1" -ErrorAction Stop
        Registry networkdtcaccessoutbound
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "networkdtcaccessoutbound"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "networkdtcaccesstransactions" -value "1" -ErrorAction Stop
        Registry networkdtcaccesstransactions
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "networkdtcaccesstransactions"
            ValueData = "1"
        }	        

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "XAtransactions" -value "1" -ErrorAction Stop
        Registry XAtransactions
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "XAtransactions"
            ValueData = "1"
        }	        

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC\security -name "LuTransactions" -value "1" -ErrorAction Stop
        Registry LuTransactions
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "LuTransactions"
            ValueData = "1"
        }	        

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC -name "turnoffrpcsecurity" -value "1" -ErrorAction Stop
        Registry turnoffrpcsecurity
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "turnoffrpcsecurity"
            ValueData = "1"
        }	        

        #SET-ITEMPROPERTY HKLM:\software\microsoft\MSDTC -name "AllowonlySecureRPCCalls" -value "0" -ErrorAction Stop
        Registry AllowonlySecureRPCCalls
        {
            Ensure = "Present"
            Key = "HKLM:\software\microsoft\MSDTC\security"
            ValueName = "AllowonlySecureRPCCalls"
            ValueData = "1"
        }

   		Script Restart-MSDTCService
       	{
            SetScript = { 
                Start-Sleep	-seconds 30 
                RESTART-SERVICE "MSDTC" 
            }
            TestScript = { $False }
            GetScript = { <# This must return a hash table #> }
       	}
#Set-ParagonTSConfig
        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fAutoClientDrives" -Value 1 -ErrorAction Stop
        Registry fAutoClientDrives
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fAutoClientDrives"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fAutoClientLpts" -Value 1 -ErrorAction Stop
        Registry fAutoClientLpts
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fAutoClientLpts"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableAudioCapture" -Value 1 -ErrorAction Stop
        Registry fDisableAudioCapture
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableAudioCapture"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableCam" -Value 1 -ErrorAction Stop
        Registry fDisableCam
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableCam"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableCcm" -Value 1 -ErrorAction Stop
        Registry fDisableCcm
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableCcm"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableCdm" -Value 0 -ErrorAction Stop
        Registry fDisableCdm
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableCdm"
            ValueData = "0"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableCpm" -Value 1 -ErrorAction Stop
        Registry fDisableCpm
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableCpm"
            ValueData = "1"
        }

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "fDisableLPT" -Value 1 -ErrorAction Stop
        Registry fDisableLPT
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fDisableLPT"
            ValueData = "1"
        }
        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fsinglesessionperuser" -value 0 -ErrorAction Stop
        Registry fsinglesessionperuser
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = "fsinglesessionperuser"
            ValueData = "0"
        }


#Set-ParagonDisallowAnimations
        #SET-ITEMPROPERTY -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DWM' -name "DisallowAnimations" -Value 1 -ErrorAction Stop
        Registry DisallowAnimations
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DWM"
            ValueName = "DisallowAnimations"
            ValueData = "1"
        }
#New-ParagonDataCollectorSet
#Need to review this one, as it will not have SQL installed initially which is required to determine instance names for DCS


#End of Paragon Common Config

#DB Server Specific below

 
		#Install Storage Services
		WindowsFeature Storage-Services
		{
			Ensure = "Present"
			Name = "Storage-Services"
		}

		#Install .NET Framework Core
		WindowsFeature NETFrameworkCore
		{
			Ensure = "Present"
			Name = "NET-Framework-Core"
		}
	
		#Install NET-Framework-45-Core
		WindowsFeature NET-Framework-45-Core
		{
			Ensure = "Present"
			Name = "NET-Framework-45-Core"
		}


		#Install Failover-Clustering
		WindowsFeature Failover-Clustering
		{
			Ensure = "Present"
			Name = "Failover-Clustering"
		}

		#Install RDC
		WindowsFeature RDC
		{
			Ensure = "Present"
			Name = "RDC"
		}

		#Install FS-SMB1
		WindowsFeature FS-SMB1
		{
			Ensure = "Present"
			Name = "FS-SMB1"
		}

		#Install Server-Gui-Mgmt-Infra
		WindowsFeature Server-Gui-Mgmt-Infra
		{
			Ensure = "Present"
			Name = "Server-Gui-Mgmt-Infra"
		}

		#Install Server-Gui-Shell
		WindowsFeature Server-Gui-Shell
		{
			Ensure = "Present"
			Name = "Server-Gui-Shell"
		}
<#
		#Had an issue with this returning an error, even though PS is installed OOB
		#Install  PowerShell
		WindowsFeature  PowerShell
		{
			Ensure = "Present"
			Name = " PowerShell"
		}
#>
		#Install PowerShell-V2
		WindowsFeature PowerShell-V2
		{
			Ensure = "Present"
			Name = "PowerShell-V2"
		}

		#Install PowerShell-ISE
		WindowsFeature PowerShell-ISE
		{
			Ensure = "Present"
			Name = "PowerShell-ISE"
		}
		
		#Install WoW64-Support
		WindowsFeature WoW64-Support
		{
			Ensure = "Present"
			Name = "WoW64-Support"
		}

		#Install XPS-Viewer
		WindowsFeature XPS-Viewer
		{
			Ensure = "Present"
			Name = "XPS-Viewer"
		}


		#Install NET-WCF-TCP-PortSharing45
		WindowsFeature NET-WCF-TCP-PortSharing45


		{
			Ensure = "Present"
			Name = "NET-WCF-TCP-PortSharing45"
		}

          Script Output-SQLAcct
        {
                Setscript=
                {
                    $tempPath='C:\temp'
                    if (!(Test-path $tempPath))
		            {
        		        $temppathfoldercreateresult = New-Item $tempPath -type Directory
                        write-output $temppathfoldercreateresult
		            } 

                    $username=$using:username
                    $username|out-file 'C:\temp\username1.txt' -Force

                }
                GetScript = {<# This must return a hash table #> }
                TestScript=
                {
                    $tempPath='C:\temp\username1.txt'
                    if ((Test-path $tempPath))
		            {
                        $true
		            }    
                    else
                    {
                        $false
                    }
                }

        }

        #to be used as part of sql install 


		Script Configure-StoragePool
        	{
	            SetScript = { 
		        $PhysicalDisks = Get-StorageSubSystem -FriendlyName "Storage Spaces*" | Get-PhysicalDisk -CanPool $True
                $DataDisks = $PhysicalDisks | Where-Object FriendlyName -in('PhysicalDisk2','PhysicalDisk3')
                $LogDisks = $PhysicalDisks | Where-Object FriendlyName -in('PhysicalDisk4')
                $SystemDisks = $PhysicalDisks | Where-Object FriendlyName -in('PhysicalDisk5')

		        If($DataDisks.Count -gt 1)
			    {
			        $totalstorageconfigresult = New-StoragePool -FriendlyName "SQLData1Pool01A" -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks $DataDisks | New-VirtualDisk -FriendlyName "SQLData1Disk01A" -Size 2044GB -ProvisioningType Fixed -ResiliencySettingName Simple|Initialize-Disk -PassThru | New-Partition -DriveLetter 'F' -UseMaximumSize
			        write-output $totalstorageconfigresult
                    start-sleep -s 30
			        $Partition = get-partition| Where-Object DriveLetter -eq "F" 
				
                    if ($Partition)
	   			    {
					    $formatvolumeresult = $Partition|Format-Volume -Confirm:$False -AllocationUnitSize 64KB
                        write-output $formatvolumeresult
				    }
			    }
			    else
		        {
           		    Write-Output "$(get-date) : All 4 data disks are not available. Please review to confirm disks were created successfully. Details of disks are below"
           		    Write-Error($DataDisks) -ErrorAction Stop
           		}
	
                If($LogDisks)
			    {
			        $totalstorageconfigresult2 = New-StoragePool -FriendlyName "SQLLogsPool01A" -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks $LogDisks | New-VirtualDisk -FriendlyName "SQLLogs1Disk01A" -Size 1022GB -ProvisioningType Fixed -ResiliencySettingName Simple|Initialize-Disk -PassThru | New-Partition -DriveLetter 'G' -UseMaximumSize
			        write-output $totalstorageconfigresult2
                    start-sleep -s 30
			        $Partition = get-partition| Where-Object DriveLetter -eq "G" 
				    if ($Partition)
 				    {
					    $formatvolumeresult2 = $Partition|Format-Volume -Confirm:$False -AllocationUnitSize 64KB
                        write-output $formatvolumeresult2
  				    }
			    }
			    else
		        {
           		Write-Output "$(get-date) : Two log disks are not available. Please review to confirm disk are created successfully. Details of disks are below"
           		Write-Error($PhysicalDisks) -ErrorAction Stop
           		}
           			
		        If($SystemDisks)
			    {
                    $totalstorageconfigresult3 = New-StoragePool -FriendlyName "SQLSystemDBPool01A" -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks $SystemDisks | New-VirtualDisk -FriendlyName "SQLSystemDBDisk01A" -Size 1022GB -ProvisioningType Fixed -ResiliencySettingName Simple|Initialize-Disk -PassThru | New-Partition -DriveLetter 'H' -UseMaximumSize
			      	write-output $totalstorageconfigresult3
                    start-sleep -s 30
			        $Partition = get-partition| Where-Object DriveLetter -eq "H" 
				    if ($Partition)
 				    {
					    $formatvolumeresult2 = $Partition|Format-Volume -Confirm:$False -AllocationUnitSize 64KB
                        write-output $formatvolumeresult2
  				    }
			    }
			    else
		        {
           		Write-Output "$(get-date) : Two system disks are not available. Please review to confirm disk are created successfully. Details of disks are below"
           		Write-Error($SystemDisks) -ErrorAction Stop
           		}

		    } #End of Set script for ConfigureStoragePool
	            TestScript = { 
                    $Storagepools=get-storagepool |Where-object friendlyname -in ('SQLData1Pool01A','SQLLogsPool01A','SQLSystemDBPool01A') -erroracction silentlycontinue
                    if($StoragePools.count -eq 3)
                    {
                        $True
                    }
                    else
                    {
                        $False
                    }
                } #End of Test Script
	            GetScript = { <# This must return a hash table #> }
                DependsOn = "[Script]Output-SQLAcct" 
        	} #End of ConfigureStoragePool 

		Script Configure-MountPoints
        	{
	            SetScript = { 

                #Configure MountPoint
    	        $DataPath ='C:\DataRoot\Data1'
		        $LogPath ='C:\DataRoot\Logs'
		        $SystemDBPath = 'C:\DataRoot\SystemDB'
		        Write-Output ("$(get-date) : Set-AzureParagonNthDBStorageConfiguration: Configuring Mount Point Folder Structure")
		        #Create directories for Data, Log, System DB
		        if (!(Test-path $DataPath))
		        {
    		        $datapathfoldercreateresult = New-Item $DataPath -type Directory
                    write-output $datapathfoldercreateresult
		        }
		        if (!(Test-path $LogPath))
		        {
    		        $logpathfoldercreateresult = New-Item $LogPath -type Directory
                    write-output $logpathfoldercreateresult
		        }
		        if (!(Test-path $SystemDBPath))
		        {
    		        $systemdbpathfoldercreateresult = New-Item $SystemDBPath -type Directory
                    write-output $systemdbpathfoldercreateresult
		        }
		        Write-Output ("$(get-date) : Set-AzureParagonNthDBStorageConfiguration: Mount Point directories created.")		
		
		        #Mount volumes to access path directories
		        $fdrive=get-partition -DriveLetter f
                $datampdrive=$fdrive|where-object AccessPaths -like "$DataPath\"
                if($datampdrive -eq $Null)
                {
    		        $partitiondatapathresult = Get-Partition -DriveLetter F |Add-PartitionAccessPath -PartitionNumber 2 -AccessPath $DataPath
                    write-output $partitiondatapathresult
                }
                $gdrive=get-partition -DriveLetter g
                $logmpdrive=$gdrive|where-object AccessPaths -like "$LogPath\"
                if($Logmpdrive -eq $Null)
                {
    		        $partitionlogpathresult = Get-Partition -DriveLetter G |Add-PartitionAccessPath -PartitionNumber 2 -AccessPath $LogPath
                    write-output $partitionlogpathresult
                }
                $hdrive=get-partition -DriveLetter h
                $systemdbmpdrive=$hdrive|where-object AccessPaths -like "$SystemDBPath\"
                if($systemdbmpdrive -eq $Null)
                {
	    	        $partitionsystpathresult = Get-Partition -DriveLetter H |Add-PartitionAccessPath -PartitionNumber 2 -AccessPath $SystemDBPath
                    write-output $partitionsystpathresult
                }
		        Write-Output ("$(get-date) : Set-AzureParagonNthDBStorageConfiguration: Partitions mounted to mount point directories.")		
                }
	            TestScript = {

                $fdrive=get-partition -DriveLetter f -erroracction silentlycontinue
                $gdrive=get-partition -DriveLetter g -erroracction silentlycontinue 
                $hdrive=get-partition -DriveLetter h -erroracction silentlycontinue

                $datampdrive=$fdrive|where-object AccessPaths -eq 'C:\DataRoot\Data1\'
                $logmpdrive=$gdrive|where-object AccessPaths -eq 'C:\DataRoot\logs\'
                $systemmpdrive=$hdrive|where-object AccessPaths -eq 'C:\DataRoot\systemDB\'

                    if($datampdrive -ne $Null -and $logmpdrive -ne $null -and $systemmpdrive -ne $null)
                    {
                        $true
                    }
                    else
                    {
                        $False
                    }
                 }#End of TestScript 
	            GetScript = {<# This must return a hash table #> }
                DependsOn = "[Script]Configure-StoragePool"
        	}#End of script ConfigureMountPoints

    #Setup tempdb folders on D drive with scheduled task to auto recreate at startup
        Script Create-TempDBFolders
        {
            SetScript = 
            {
			    
				#Define variables for tempdb startup script
				$tempDbDatafolder="D:\TempDB\MSSQL\Data"
				$tempDbLogfolder="D:\TempDB\MSSQL\Logs"
				$backupfolder="C:\DataRoot\SystemDB\Backup"
				$tempdbStartupScriptDest = 'C:\DataRoot\Data1\Scripts'
				$Action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'C:\DataRoot\Data1\Scripts\SQL-startup.ps1'
				$Trigger = New-ScheduledTaskTrigger -AtStartup
                $username=$using:username
                #$username= get-content 'C:\temp\username1.txt'
                $Pass=$using:pass
				#Sqlstartup script definition in array
				$sqlstartupscript = @()
				$sqlstartupscript +={
                    $tempDbDatafolder="D:\TempDB\MSSQL\Data"
                    $tempDbLogfolder="D:\TempDB\MSSQL\Logs"
					$SQLService='MSSQL$PARLIVE'
					if (!(test-path -path $tempDbDatafolder)) 
					{
					Stop-Service $SQLService
					New-Item -ItemType directory -Path $tempDbDatafolder
					if (!(test-path -path $tempDbLogfolder)) 
					{
					New-Item -ItemType directory -Path $tempDbLogfolder
					}
					Start-Service $SQLService
					}			    
		        		                }
				#Check if TempDB folders exist, if not, create them
				if (!(test-path -path $tempDbDatafolder)) 
				{
			    	$tempDbDatafoldercreateresult = New-Item -ItemType directory -Path $tempDbDatafolder
				}
				if (!(test-path -path $tempDbLogfolder)) 
				{
		    		$tempDbLogfoldercreateresult = New-Item -ItemType directory -Path $tempDbLogfolder
				}
				#Create backup folder needed for SQL install as default backup directory
				if (!(test-path -path $backupfolder)) 
				{
			    	$backupfoldercreateresult = New-Item -ItemType directory -Path $backupfolder
				}
				#Create TempDB scheduled task to recreate folder structure upon reboot	#
				if(!(Get-ScheduledTask -TaskName 'TempDB Folder Structure Create' -ErrorAction SilentlyContinue))
				{
				    #$registerschedtaskresult = Register-ScheduledTask -Action $Action -Trigger $trigger -TaskName "TempDB Folder Structure Create" -Description "Create TempDB Folder Structure on D Drive and restart SQL"
                    $registerschedtaskresult = Register-ScheduledTask -Action $Action -Trigger $trigger -TaskName "TempDB Folder Structure Create" -Description "Create TempDB Folder Structure on D Drive and restart SQL" -User $UserName -Password $Pass
                }
				#Create directory for tempdb Startup script
				if (!(test-path -path $tempdbStartupScriptDest )) 
				{
			    	$tempdbStartupScriptDestcreateresult = New-Item -ItemType directory -Path $tempdbStartupScriptDest 
				}
				#Dynamically create PS1 file C:\DataRoot\Scripts\sql-startup.ps1
				$createsqlstartupscriptresult = $sqlstartupscript|Out-File C:\DataRoot\Data1\Scripts\sql-startup.ps1 -Force
            }
            TestSCript = 
            {
                $tempDbDatafolder="D:\TempDB\MSSQL\Data"
	            #Check if TempDB folders exist, if not, create them
				if ((test-path -path $tempDbDatafolder -erroraction silentlycontinue)) 
				{
			    	$true
				}
                else
                {
                    $false
                }
            }
            GetScript ={<# This must return a hash table #>}
            DependsOn = "[Script]Configure-MountPoints"
        }

    
    #Install SQL using script method
    #C:\SQLServer_12.0_Full\setup.exe /q /Action=Install /IACCEPTSQLSERVERLICENSETERMS /UpdateEnabled=True /UpdateSource=C:\SQLServer_12.0_Full\CU /FEATURES=SQLEngine,FullText,RS,IS,BC,Conn,ADV_SSMS /ASCOLLATION=Latin1_General_BIN /InstanceName=PARLIVE /SQLBACKUPDIR=C:\DataRoot\SystemDB\Backup /INSTALLSQLDATADIR=C:\DataRoot\SystemDB /SQLSYSADMINACCOUNTS='+$LocalAdminSQL +' /SQLSVCSTARTUPTYPE=AUTOMATIC /SQLTEMPDBDIR=D:\TempDB\MSSQL\Data /SQLTEMPDBLOGDIR=D:\TempDB\MSSQL\Logs /SQLUSERDBDIR=C:\DataRoot\Data1 /SQLUSERDBLOGDIR=C:\DataRoot\Logs /RSINSTALLMODE=FilesOnlyMode
<#
        Script InstallSQLServer
        {
            SetScript = 
            {
                $Localadminsql=Get-Content C:\temp\username1.txt
                $ArgumentList= "/q /Action=Install /IACCEPTSQLSERVERLICENSETERMS /UpdateEnabled=True /UpdateSource=C:\SQLServer_12.0_Full\CU /FEATURES=SQLEngine,FullText,RS,IS,BC,Conn,ADV_SSMS /SQLCOLLATION=Latin1_General_BIN /InstanceName=PARLIVE /SQLBACKUPDIR=C:\DataRoot\SystemDB\Backup /INSTALLSQLDATADIR=C:\DataRoot\SystemDB /SQLSYSADMINACCOUNTS=$LocalAdminSQL /SQLSVCSTARTUPTYPE=AUTOMATIC /SQLTEMPDBDIR=D:\TempDB\MSSQL\Data /SQLTEMPDBLOGDIR=D:\TempDB\MSSQL\Logs /SQLUSERDBDIR=C:\DataRoot\Data1 /SQLUSERDBLOGDIR=C:\DataRoot\Logs /RSINSTALLMODE=FilesOnlyMode"
                Start-Process C:\SQLServer_12.0_Full\setup.exe  -ArgumentList $ArgumentList -Wait            }
            TestScript = 
            {
                $SQLInstalled=[System.Data.Sql.SqlDataSourceEnumerator]::Instance.GetDataSources()
                if ($SQLInstalled.InstanceName -eq 'PARLIVE')
                {
                    $True
                }
                else
                {
                    $False
                }
            }
            GetScript ={<# This must return a hash table #>#}
               # DependsOn = "[Script]Configure-MountPoints"
        }#end of InstallSQLServer
#>
        xPendingReboot CheckBeforeBeginning
        { 
            Name = "Check for a pending reboot before changing anything"

        }

#        xPendingReboot PostSQLInstall
#        { 
#            Name = "Check for a pending reboot after SQL install"
#            DependsOn = "[Script]InstallSQLServer"
#        }

#Create BizTalk DB
<#        Script CreateBizTalkDb
        {
                SetScript =
                {
    				Start-Service $SQLService
                    ipmo sqlps
                    $ServerInstanceName='DB01\PARLIVE'
                    $BizTalkDBName='Parbiz'
                    $Query="Create database "+$BizTalkDBName
      	            #Invoke SQL CMd to create database
		            $SqlCreateDB=Invoke-Sqlcmd -ServerInstance $ServerInstanceName -Database master -Query $Query
                }
                TestScript =
                {
                    ipmo sqlps
                    $ServerInstanceName='DB01\PARLIVE'
                    $BizTalkDBName='Parbiz'
                    if($GetSQLDBResults=get-sqldatabase -ServerInstance $ServerInstanceName -Name $BizTalkDBName -ErrorAction SilentlyContinue)
		            {
			            $true
		            } 
		            else
			        {
                        $false
			        }
                }
                GetScript =	{ @{} }
                DependsOn="[Script]InstallSQLServer"
        }#End of script
               
#Open ports in firewall to allow connection inbound to SQL
#port for browser 1434 and dynamic port for PARLIVE, read from registry
        Script OpenSQLPortsFirewall
        {
                SetScript =
                {
            		#Open SQL ports in firewall on DB Server.  Dynamically grab port from registry
		            $PARLIVERegKey=Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\PARLIVE\MSSQLServer\SuperSocketNetLib\TCP'
		            $PARLIVEPort=$PARLIVERegKey.TcpPort
          			if (!(get-netfirewallrule -DisplayName 'SQL BROWSER Port 1434 Inbound' -ErrorAction SilentlyContinue) )
        			{
                		netsh advfirewall firewall add rule name = 'SQL BROWSER Port 1434 Inbound' dir = in protocol = udp action = allow localport = 1434 remoteip = localsubnet profile = DOMAIN
                    }
        			if (!(get-netfirewallrule -DisplayName 'SQL PARLIVE Inbound'  -ErrorAction SilentlyContinue))
    	    		{
        	        	netsh advfirewall firewall add rule name = 'SQL PARLIVE Inbound' dir = in protocol = tcp action = allow localport = $PARLIVEPort remoteip = localsubnet profile = DOMAIN
        			}
                }
                TestScript =
                {
                    if (!(get-netfirewallrule -DisplayName 'SQL BROWSER Port 1434 Inbound' -ErrorAction SilentlyContinue) -and (!(get-netfirewallrule -DisplayName 'SQL PARLIVE Inbound'  -ErrorAction SilentlyContinue)))


		            {
			            $true
		            } 
		            else
			        {
                        $false
			        }
                }
                GetScript =	{ @{} }
               DependsOn="[Script]InstallSQLServer"

        }#End of script
#>

<#
#New way
#Install-AzurePowershellModules
		Script InstallAzurePowershellModules
        	{
	            SetScript = 
                    {  
                        #$Nuget=install-packageprovider -name nuget -minimumversion 2.8.5.201 -force
                        $trustrepo=Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
                        $install=install-module azure
                        import-module azure 
                    }
	            GetScript =  { @{} }
	            TestScript = 
                    { 
                          $module=get-module -listavailable -name azure -refresh -erroraction silentlycontinue
                          if($module)
                          {
                            $true
                          }
                          else
                          {
                            $false
                          }                        
                    }
                
        	}
#>


    }#End of Node
}#End of config
 
<#
$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDSCAllowDomainUser=$True
            RebootNodeIfNeeded = $true
           

        }
    )
}
$creds=get-credential -UserName localadmin -message test
DBServerConfig -admincreds $creds -domainname irmchosted.com -configurationdata $cd
Start-DscConfiguration -Force -Path C:\Users\localadmin\DBServerConfig -verbose
   $job= (Get-Job -Id 13).ChildJobs.progress

#>

  