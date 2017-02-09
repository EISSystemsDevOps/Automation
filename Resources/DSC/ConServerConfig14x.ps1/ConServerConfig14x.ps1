#Config file for Push mode and Azure setup with extension

#PARAGON Server Common Config ####################################################################
<#
-Set PowerPlan to "High Performance"
-Set various MSDTC configuration 
-Set various Terminal Service settings
-Set ParagonDisallowAnimations to enable

#>


Configuration ConServerConfig14x
 {
  #Import-Module WebAdministration
  Import-DscResource -ModuleName xWebAdministration
  $appPools = Get-ChildItem IIS:\AppPools | where {$_.Name -notlike "*.Net*"} | Where {$_.Name -ne "WebStation"}
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

        


#End of Paragon Common Config #########################################################################

<#
-Install all the required Roles and Features
-Set App Pools Recycle Setting (Recycle at 2AM)
#>

 #ServiceBus Configuration specific settings
   
        
    $WindowsFeatures = "FileAndStorage-Services","Web-Server","Web-WebServer","Web-Common-Http","Web-Default-Doc","Web-Dir-Browsing","Web-Http-Errors", `
                        "Web-Static-Content","Web-Health","Web-Http-Logging","Web-Performance","Web-Stat-Compression","Web-Security","Web-Filtering","Web-App-Dev", `
                        "Web-Net-Ext","Web-Net-Ext45","Web-Asp-Net","Web-Asp-Net45","Web-ISAPI-Ext","Web-ISAPI-Filter","Web-Mgmt-Tools","Web-Mgmt-Console", `
                        "Web-Mgmt-Compat","Web-Metabase","NET-Framework-Features","NET-Framework-Core","NET-Framework-45-Features","NET-Framework-45-Core", `
                        "NET-Framework-45-ASPNET","NET-WCF-Services45","NET-WCF-HTTP-Activation45","MSMQ","MSMQ-Services","MSMQ-Server","RDC","FS-SMB1","User-Interfaces-Infra", `
                        "Server-Gui-Mgmt-Infra","Server-Gui-Shell","PowerShellRoot","PowerShell","PowerShell-V2","PowerShell-ISE","WAS","WAS-Process-Model", `
                        "WAS-Config-APIs","WoW64-Support"
    foreach ($WindowsFeature in $WindowsFeatures)
     {
      WindowsFeature $WindowsFeature
		{
			Ensure = "Present"
			Name = "$WindowsFeature"
		}
     }

      #Set the App Pools Recycle setting

       foreach ($appPool in $appPools)
          {
            xWebAppPool $appPool.Name
             {
               Name = $appPool.Name
               Ensure = "Present"
               RestartTimeLimit = (New-TimeSpan -Minutes 0).ToString()
               RestartSchedule = ("2:00:00")
             }

          }
 
  }
}