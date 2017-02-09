#Config file for Push mode and Azure setup with extension

#PARAGON Server Common Config ####################################################################
<#
-Set PowerPlan to "High Performance"
-Set various MSDTC configuration 
-Set various Terminal Service settings
-Set ParagonDisallowAnimations to enable
-Set ParagonDisableForceUnloadProfile
#>


Configuration BreServerConfig14x
 {
  
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
    
    #BRE Configuration
    
	#	$WindowsFeatures = "Application-Server", "AS-NET-Framework", "AS-Ent-Services", "AS-Dist-Transaction", "AS-WS-Atomic", "AS-Incoming-Trans", "AS-Outgoing-Trans", "AS-TCP-Port-Sharing", "AS-Web-Support", `
#				            "AS-WAS-Support", "AS-HTTP-Activation", "AS-Named-Pipes", "AS-TCP-Activation", "FileAndStorage-Services", "Storage-Services", "Web-Server", "Web-WebServer", "Web-Common-Http", "Web-Default-Doc", `
#				            "Web-Dir-Browsing", "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-Log-Libraries", "Web-Request-Monitor", "Web-Performance", "Web-Stat-Compression", `
#				            "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth", "Web-CertProvider", "Web-Client-Auth", "Web-Digest-Auth", "Web-Cert-Auth", "Web-IP-Security", "Web-Url-Auth", "Web-Windows-Auth", `
#				            "Web-App-Dev", "Web-Net-Ext45", "Web-Asp-Net45", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat", "Web-Metabase", "Web-Scripting-Tools", "Web-Mgmt-Service", `
#				            "NET-Framework-Features", "NET-Framework-Core", "NET-Framework-45-Features", "NET-Framework-45-Core", "NET-Framework-45-ASPNET", "NET-WCF-Services45", "NET-WCF-HTTP-Activation45", "NET-WCF-MSMQ-Activation45", `
#				            "NET-WCF-Pipe-Activation45", "NET-WCF-TCP-Activation45", "NET-WCF-TCP-PortSharing45", "MSMQ", "MSMQ-Services", "MSMQ-Server", "NLB", "RDC", "FS-SMB1", "User-Interfaces-Infra", "Server-Gui-Mgmt-Infra", "Server-Gui-Shell", `
#				            "PowerShellRoot", "PowerShell", "PowerShell-V2", "PowerShell-ISE", "WAS", "WAS-Process-Model", "WAS-Config-APIs", "WoW64-Support"
#
#    foreach ($WindowsFeature in $WindowsFeatures)
#     {
#      WindowsFeature $WindowsFeature
#		{
#			Ensure = "Present"
#			Name = "$WindowsFeature"
#		}
#     }
         

#         foreach ($WindowsFeature in $WindowsFeatures)
#         {
#            Write-output ("
#                WindowsFeature $WindowsFeature
#                {
#                    Ensure = 'Present'
#                    Name = $WindowsFeature
#                }
#            ")
#         }
        WindowsFeature Application-Server
        {
            Ensure = 'Present'
            Name = Application-Server
        }
            

        WindowsFeature AS-NET-Framework
        {
            Ensure = 'Present'
            Name = AS-NET-Framework
        }
            

        WindowsFeature AS-Ent-Services
        {
            Ensure = 'Present'
            Name = AS-Ent-Services
        }
            

        WindowsFeature AS-Dist-Transaction
        {
            Ensure = 'Present'
            Name = AS-Dist-Transaction
        }
            

        WindowsFeature AS-WS-Atomic
        {
            Ensure = 'Present'
            Name = AS-WS-Atomic
        }
            

        WindowsFeature AS-Incoming-Trans
        {
            Ensure = 'Present'
            Name = AS-Incoming-Trans
        }
            

        WindowsFeature AS-Outgoing-Trans
        {
            Ensure = 'Present'
            Name = AS-Outgoing-Trans
        }
            

        WindowsFeature AS-TCP-Port-Sharing
        {
            Ensure = 'Present'
            Name = AS-TCP-Port-Sharing
        }
            

        WindowsFeature AS-Web-Support
        {
            Ensure = 'Present'
            Name = AS-Web-Support
        }
            

        WindowsFeature AS-WAS-Support
        {
            Ensure = 'Present'
            Name = AS-WAS-Support
        }
            

        WindowsFeature AS-HTTP-Activation
        {
            Ensure = 'Present'
            Name = AS-HTTP-Activation
        }
            

        WindowsFeature AS-Named-Pipes
        {
            Ensure = 'Present'
            Name = AS-Named-Pipes
        }
            

        WindowsFeature AS-TCP-Activation
        {
            Ensure = 'Present'
            Name = AS-TCP-Activation
        }
            

        WindowsFeature FileAndStorage-Services
        {
            Ensure = 'Present'
            Name = FileAndStorage-Services
        }
            

        WindowsFeature Storage-Services
        {
            Ensure = 'Present'
            Name = Storage-Services
        }
            

        WindowsFeature Web-Server
        {
            Ensure = 'Present'
            Name = Web-Server
        }
            

        WindowsFeature Web-WebServer
        {
            Ensure = 'Present'
            Name = Web-WebServer
        }
            

        WindowsFeature Web-Common-Http
        {
            Ensure = 'Present'
            Name = Web-Common-Http
        }
            

        WindowsFeature Web-Default-Doc
        {
            Ensure = 'Present'
            Name = Web-Default-Doc
        }
            

        WindowsFeature Web-Dir-Browsing
        {
            Ensure = 'Present'
            Name = Web-Dir-Browsing
        }
            

        WindowsFeature Web-Http-Errors
        {
            Ensure = 'Present'
            Name = Web-Http-Errors
        }
            

        WindowsFeature Web-Static-Content
        {
            Ensure = 'Present'
            Name = Web-Static-Content
        }
            

        WindowsFeature Web-Http-Redirect
        {
            Ensure = 'Present'
            Name = Web-Http-Redirect
        }
            

        WindowsFeature Web-Health
        {
            Ensure = 'Present'
            Name = Web-Health
        }
            

        WindowsFeature Web-Http-Logging
        {
            Ensure = 'Present'
            Name = Web-Http-Logging
        }
            

        WindowsFeature Web-Log-Libraries
        {
            Ensure = 'Present'
            Name = Web-Log-Libraries
        }
            

        WindowsFeature Web-Request-Monitor
        {
            Ensure = 'Present'
            Name = Web-Request-Monitor
        }
            

        WindowsFeature Web-Performance
        {
            Ensure = 'Present'
            Name = Web-Performance
        }
            

        WindowsFeature Web-Stat-Compression
        {
            Ensure = 'Present'
            Name = Web-Stat-Compression
        }
            

        WindowsFeature Web-Dyn-Compression
        {
            Ensure = 'Present'
            Name = Web-Dyn-Compression
        }
            

        WindowsFeature Web-Security
        {
            Ensure = 'Present'
            Name = Web-Security
        }
            

        WindowsFeature Web-Filtering
        {
            Ensure = 'Present'
            Name = Web-Filtering
        }
            

        WindowsFeature Web-Basic-Auth
        {
            Ensure = 'Present'
            Name = Web-Basic-Auth
        }
            

        WindowsFeature Web-CertProvider
        {
            Ensure = 'Present'
            Name = Web-CertProvider
        }
            

        WindowsFeature Web-Client-Auth
        {
            Ensure = 'Present'
            Name = Web-Client-Auth
        }
            

        WindowsFeature Web-Digest-Auth
        {
            Ensure = 'Present'
            Name = Web-Digest-Auth
        }
            

        WindowsFeature Web-Cert-Auth
        {
            Ensure = 'Present'
            Name = Web-Cert-Auth
        }
            

        WindowsFeature Web-IP-Security
        {
            Ensure = 'Present'
            Name = Web-IP-Security
        }
            

        WindowsFeature Web-Url-Auth
        {
            Ensure = 'Present'
            Name = Web-Url-Auth
        }
            

        WindowsFeature Web-Windows-Auth
        {
            Ensure = 'Present'
            Name = Web-Windows-Auth
        }
            

        WindowsFeature Web-App-Dev
        {
            Ensure = 'Present'
            Name = Web-App-Dev
        }
            

        WindowsFeature Web-Net-Ext45
        {
            Ensure = 'Present'
            Name = Web-Net-Ext45
        }
            

        WindowsFeature Web-Asp-Net45
        {
            Ensure = 'Present'
            Name = Web-Asp-Net45
        }
            

        WindowsFeature Web-ISAPI-Ext
        {
            Ensure = 'Present'
            Name = Web-ISAPI-Ext
        }
            

        WindowsFeature Web-ISAPI-Filter
        {
            Ensure = 'Present'
            Name = Web-ISAPI-Filter
        }
            

        WindowsFeature Web-Mgmt-Tools
        {
            Ensure = 'Present'
            Name = Web-Mgmt-Tools
        }
            

        WindowsFeature Web-Mgmt-Console
        {
            Ensure = 'Present'
            Name = Web-Mgmt-Console
        }
            

        WindowsFeature Web-Mgmt-Compat
        {
            Ensure = 'Present'
            Name = Web-Mgmt-Compat
        }
            

        WindowsFeature Web-Metabase
        {
            Ensure = 'Present'
            Name = Web-Metabase
        }
            

        WindowsFeature Web-Scripting-Tools
        {
            Ensure = 'Present'
            Name = Web-Scripting-Tools
        }
            

        WindowsFeature Web-Mgmt-Service
        {
            Ensure = 'Present'
            Name = Web-Mgmt-Service
        }
            

        WindowsFeature NET-Framework-Features
        {
            Ensure = 'Present'
            Name = NET-Framework-Features
        }
            

        WindowsFeature NET-Framework-Core
        {
            Ensure = 'Present'
            Name = NET-Framework-Core
        }
            

        WindowsFeature NET-Framework-45-Features
        {
            Ensure = 'Present'
            Name = NET-Framework-45-Features
        }
            

        WindowsFeature NET-Framework-45-Core
        {
            Ensure = 'Present'
            Name = NET-Framework-45-Core
        }
            

        WindowsFeature NET-Framework-45-ASPNET
        {
            Ensure = 'Present'
            Name = NET-Framework-45-ASPNET
        }
            

        WindowsFeature NET-WCF-Services45
        {
            Ensure = 'Present'
            Name = NET-WCF-Services45
        }
            

        WindowsFeature NET-WCF-HTTP-Activation45
        {
            Ensure = 'Present'
            Name = NET-WCF-HTTP-Activation45
        }
            

        WindowsFeature NET-WCF-MSMQ-Activation45
        {
            Ensure = 'Present'
            Name = NET-WCF-MSMQ-Activation45
        }
            

        WindowsFeature NET-WCF-Pipe-Activation45
        {
            Ensure = 'Present'
            Name = NET-WCF-Pipe-Activation45
        }
            

        WindowsFeature NET-WCF-TCP-Activation45
        {
            Ensure = 'Present'
            Name = NET-WCF-TCP-Activation45
        }
            

        WindowsFeature NET-WCF-TCP-PortSharing45
        {
            Ensure = 'Present'
            Name = NET-WCF-TCP-PortSharing45
        }
            

        WindowsFeature MSMQ
        {
            Ensure = 'Present'
            Name = MSMQ
        }
            

        WindowsFeature MSMQ-Services
        {
            Ensure = 'Present'
            Name = MSMQ-Services
        }
            

        WindowsFeature MSMQ-Server
        {
            Ensure = 'Present'
            Name = MSMQ-Server
        }
            

        WindowsFeature NLB
        {
            Ensure = 'Present'
            Name = NLB
        }
            

        WindowsFeature RDC
        {
            Ensure = 'Present'
            Name = RDC
        }
            

        WindowsFeature FS-SMB1
        {
            Ensure = 'Present'
            Name = FS-SMB1
        }
            

        WindowsFeature User-Interfaces-Infra
        {
            Ensure = 'Present'
            Name = User-Interfaces-Infra
        }
            

        WindowsFeature Server-Gui-Mgmt-Infra
        {
            Ensure = 'Present'
            Name = Server-Gui-Mgmt-Infra
        }
            

        WindowsFeature Server-Gui-Shell
        {
            Ensure = 'Present'
            Name = Server-Gui-Shell
        }
            

        WindowsFeature PowerShellRoot
        {
            Ensure = 'Present'
            Name = PowerShellRoot
        }
            

        WindowsFeature PowerShell
        {
            Ensure = 'Present'
            Name = PowerShell
        }
            

        WindowsFeature PowerShell-V2
        {
            Ensure = 'Present'
            Name = PowerShell-V2
        }
            

        WindowsFeature PowerShell-ISE
        {
            Ensure = 'Present'
            Name = PowerShell-ISE
        }
            

        WindowsFeature WAS
        {
            Ensure = 'Present'
            Name = WAS
        }
            

        WindowsFeature WAS-Process-Model
        {
            Ensure = 'Present'
            Name = WAS-Process-Model
        }
            

        WindowsFeature WAS-Config-APIs
        {
            Ensure = 'Present'
            Name = WAS-Config-APIs
        }
            

        WindowsFeature WoW64-Support
        {
            Ensure = 'Present'
            Name = WoW64-Support
        }


 }
}
