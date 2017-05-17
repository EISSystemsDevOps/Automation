
#Config file for Push mode and Azure setup with extension


#PARAGON Server Common Config ####################################################################
<#
-Set PowerPlan to "High Performance"
-Set various MSDTC configuration 
-Set various Terminal Service settings
-Set ParagonDisallowAnimations to enable
-Set-ParagonDisableForceUnloadProfile
#>


Configuration WebServerConfig14xWPreReqs
 {
  Param (
         [Parameter(Mandatory=$True)]
         [String[]]$SourcePath,

         [Parameter(Mandatory=$True)]
         [String[]]$SWPath

         )
 
  
  
  Node ("localhost") 
   {


        #Set-PowerPlan
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
        
        Script SetMachineLaunchRestriction
        {
         GetScript={$null}
         TestScript={$false}
         SetScript= {

                     SET-ITEMPROPERTY HKLM:\software\microsoft\ole -name "MachineLaunchRestriction" `
                     -value ([byte[]](0x01,0x00,0x04,0x80,0x90,0x00,0x00,0x00,0xa0,0x00,0x00,0x00,0x00, `
                     0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x02,0x00,0x7c,0x00,0x05,0x00,0x00,0x00,0x00, `
                     0x00,0x14,0x00,0x1f,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x01,0x00, `
                     0x00,0x00,0x00,0x00,0x00,0x18,0x00,0x0b,0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00, `
                     0x00,0x00,0x0f,0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x18,0x00,0x1f, `
                     0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
                     0x02,0x00,0x00,0x00,0x00,0x18,0x00,0x1f,0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00, `
                     0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x2f,0x02,0x00,0x00,0x00,0x00,0x18,0x00,0x1f, `
                     0x00,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x32, `
                     0x02,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
                     0x02,0x00,0x00,0x01,0x02,0x00,0x00,0x00,0x00,0x00,0x05,0x20,0x00,0x00,0x00,0x20, `
                     0x02,0x00,0x00)) -ErrorAction Stop

                    }
      
         }

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
            ValueData = "0"
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

       #Set-ParagonDisableForceUnloadProfile
        #SET-ITEMPROPERTY -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -name "DisableForceUnload" -Value 1 -ErrorAction Stop
        Registry DisableForceUnload
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
            ValueName = "DisableForceUnload"
            ValueData = "1"
        }

#End of Paragon Common Config #########################################################################
    
  #WebConfiguration
<#
-Install all the required Roles and Features
-Set App Pools Recycle Setting (Recycle at 2AM)
-Set WebStation to support 32bit
#>
 
       #Install-Net35WithDism
 		Script Install-Net35WithDism
        {
	        SetScript = 
            {
                $SourcePath=$Using:SourcePath
               # $sourcepath='\\azrdevfile01.paragon.mckesson.com\Root\WindowsServer2012R2\sources\sxs'
                Start-process -Filepath Dism.exe -argumentlist "/online /enable-feature /featurename:NetFX3 /All /Source:$SourcePath /LimitAccess" -wait -NoNewWindow 
            }
	        TestScript = 
		{ 
			$feature=Get-WindowsFeature -Name Net-Framework-Features -erroraction silentlycontinue
			if($feature.Installed -eq $true)
			{
			    $true
			}
			else
			{	
				$false
			} 
		}
	        GetScript = {$null}
        }
    
   # NET-Framework-Core

     WindowsFeature NETFrameworkCore
		{
			Ensure = "Present"
			Name = "NET-Framework-Core"
            Source = "$SourcePath"
            DependsOn   = "[Script]Install-Net35WithDism"
		}


   
     #WebServer Configuration specific settings
    WindowsFeature IISWindowsFeature
    {
	Ensure = "Present"
	Name = "Web-Server"
	DependsOn = "[WindowsFeature]NetFrameworkCore"
    }

   

     
    $WindowsFeatures = "AS-HTTP-Activation", "WAS-NET-Environment", "Web-WebServer", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing", "Web-Http-Errors", `
					   "Web-Static-Content", "Web-Health", "Web-Http-Logging", "Web-Http-Tracing", "Web-Performance", "Web-Stat-Compression", "Web-Security", "Web-Filtering", "Web-App-Dev", "Web-Net-Ext45", `
					   "Web-Asp-Net45", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat", "Web-Metabase", "NET-HTTP-Activation", "NET-Framework-45-Features", `
					   "NET-Framework-45-Core", "NET-Framework-45-ASPNET", "NET-WCF-Services45", "NET-WCF-TCP-PortSharing45", "Web-Net-Ext", "Web-Asp-Net"
   
    foreach ($WindowsFeature in $WindowsFeatures)
     {
      WindowsFeature $WindowsFeature
		{
			Ensure = "Present"
			Name = "$WindowsFeature"
            Source = "$SourcePath"
            DependsOn = "[WindowsFeature]IISWindowsFeature"
            
		}
     }
	


   #Set the App Pools Recycle setting and WebStation to enable 32bit

    Script SetAppPoolSetting
     {
      GetScript={$null}
      TestScript={$false}
      SetScript={ Import-Module WebAdministration
                  $AppPools = Get-ChildItem IIS:\AppPools 
                  $ParagonAppPools = $AppPools | Where {$_.Name -notlike "*.Net*"}
                  foreach ($ParagonAppPool in $ParagonAppPools)
                   {
                    # set the Recycling Time Interval to 0, which disables the setting
                    Set-ItemProperty -Path ("IIS:\AppPools\" + $ParagonappPool.name) -Name recycling.periodicrestart.time -Value ([TimeSpan]::FromMinutes(0))

                    # set the Recycling schedule to 2 AM
                    Set-ItemProperty -Path ("IIS:\AppPools\" + $ParagonAppPool.name) -Name recycling.periodicRestart.schedule -Value @{value="02:00:00"}
                   }
                   # set WebStation App Pool to enable 32 bit support
                   If ($AppPools.Name -contains "WebStation")
                    {
                     $WSAppPool = "IIS:\AppPools\WebStation"
                     $WS32BitApp = Get-ItemProperty -Path $WSAppPool -Name enable32BitAppOnWin64
                    
                     If ($WS32BitApp -ne "True")
                      {Set-ItemProperty -Path $WSAppPool -Name enable32BitAppOnWin64 -Value True}
                    }
                   
                }
      DependsOn="[WindowsFeature]IISWindowsFeature"

     }
 
        Package AspNetMVC3
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\AspNetMVC3\AspNetMVC3Setup.exe"
            Name        = "Microsoft ASP.NET MVC 3"
            ProductId   = "{DCDEC776-BADD-48B9-8F9A-DFF513C3D7FA}"
            Arguments   = "/q /norestart"
        }

     
        Package SQLSysClrTypes
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLSysClrTypes\SQLSysClrTypes\SQLSysClrTypes.msi"
            Name        = "Microsoft System CLR Types for SQL Server 2012 (x64)"
            ProductId   = "{F1949145-EB64-4DE7-9D81-E6D27937146C}"
            Arguments   = "/qn"
        }       
    
        Package ReportViewer
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\ReportViewer2012\ReportViewer2012\ReportViewer2012.msi"
            Name        = "Microsoft Report Viewer 2012 Runtime"
            ProductId   = "{C58378BC-0B7B-474E-855C-9D02E5E75D71}"
            Arguments   = "/qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        } 
 
        
        Package SQLNativeClient_2008R2
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLNativeClient_2008R2\SQLNativeClient_2008R2\sqlncli2008r2.msi"
            Name        = "Microsoft SQL Server 2008 R2 Native Client"
            ProductId   = "{471AAD2C-9078-4DAC-BD43-FA10FB7C3FCE}"
            Arguments   = "IACCEPTSQLNCLILICENSETERMS=YES /qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        } 

        Package SQLNativeClient_2012
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLNativeClient_2012\SQLNativeClient_2012\sqlncli2012.msi"
            Name        = "Microsoft SQL Server 2012 Native Client "
            ProductId   = "{3965C9F9-9B9A-4391-AC4B-8388210D3AA0}"
            Arguments   = "IACCEPTSQLNCLILICENSETERMS=YES /qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        }



 }
}
