Configuration OC_CaptivaConfig
{
	Node ("localhost")
	{
	    #Install File and Storage Services
		WindowsFeature FileStorageServices
		{
			Ensure = "Present"
			Name = "FileandStorage-Services"
		}
        #Install FileServices
		WindowsFeature FileServices
		{
			Ensure = "Present"
			Name = "File-Services"
		}
		#Install FileServer
		WindowsFeature FileServer
		{
			Ensure = "Present"
			Name = "FS-FileServer"
		}
		#Install StorageServices
		WindowsFeature StorageServices
		{
			Ensure = "Present"
			Name = "Storage-Services"
		}
        #Install the App Server Role
		WindowsFeature AppServer
		{
			Ensure = "Present"
			Name = "Application-Server"
		}			
		#Install .NET Framework 3.5 Features
		WindowsFeature NETFrameworkFeatures
		{
			Ensure = "Present"
			Name = "NET-Framework-Features"
		}
		#Install .NET Framework 3.5 Core
		WindowsFeature NETFrameworkCore
		{
			Ensure = "Present"
			Name = "NET-Framework-Core"
		}
        #Install .NET Framework 4.5 Features
		WindowsFeature NETFramework45Features
		{
			Ensure = "Present"
			Name = "NET-Framework-45-Features"
		}
		#Install .NET Framework 4.5 Core
		WindowsFeature NETFramework45Core
		{
			Ensure = "Present"
			Name = "NET-Framework-45-Core"
		}
		#Install .NET Framework ASP.NET 4.5
		WindowsFeature NETFrameworkASP45
		{
			Ensure = "Present"
			Name = "NET-Framework-45-ASPNET"
		}
		#Install .NET 45 WCF Services
		WindowsFeature NET-WCF-Services45
		{
			Ensure = "Present"
			Name = "NET-WCF-Services45"
		}
		#Install NET WCF TCP Port Sharing45
		WindowsFeature NETWCFTCPPortSharing45
		{
			Ensure = "Present"
			Name = "NET-WCF-TCP-PortSharing45"
		}
		#Install Web Server IIS Support
		WindowsFeature WebServerIISSupport
		{
			Ensure = "Present"
			Name = "As-Web-Support"
		}
        #Install Telnet Client
		WindowsFeature TelnetClient
		{
			Ensure = "Present"
			Name = "Telnet-Client"
		}
        #Install the IIS Role
		WindowsFeature IIS
		{
			Ensure = "Present"
			Name = "Web-Server"
		}
		#Install Web Server
		WindowsFeature WebWebServer
		{
			Ensure = "Present"
			Name = "Web-WebServer"
		}
		#Install Common HTTP Features 
		WindowsFeature WebCommonHttp
		{
			Ensure = "Present"
			Name = "Web-Common-Http"
		}
		#Install Default Document
		WindowsFeature DefaultDocument
		{
			Ensure = "Present"
			Name = "Web-Default-Doc"
		}
		#Install Web Directory Browsing
		WindowsFeature WebDirBrowsing
		{
			Ensure = "Present"
			Name = "Web-Dir-Browsing"
		}
		#Install Web HTTP Errors
		WindowsFeature WebHttpErrors
		{
			Ensure = "Present"
			Name = "Web-Http-Errors"
		}
		#Install Static Content
		WindowsFeature StaticContent
		{
			Ensure = "Present"
			Name = "Web-Static-Content"
		}
		#Install HTTP Redirection
		WindowsFeature WebHttpRedirection
		{
			Ensure = "Present"
			Name = "Web-Http-Redirect"
		}
		#Install Web Health
		WindowsFeature WebHealth
		{
			Ensure = "Present"
			Name = "Web-Health"
		}
		#Install Web HTTP Logging
		WindowsFeature WebHttpLogging
		{
			Ensure = "Present"
			Name = "Web-Http-Logging"
		}
		#Install Web Logging Tools
		WindowsFeature WebLoggingTools
		{
			Ensure = "Present"
			Name = "Web-Log-Libraries"
		}
		#Install Web Request Monitor
		WindowsFeature WebRequestMonitor
		{
			Ensure = "Present"
			Name = "Web-Request-Monitor"
		}
		#Install Web Performance
		WindowsFeature WebPerformance
		{
			Ensure = "Present"
			Name = "Web-Performance"
		}
		#Install Static Content Compression
		WindowsFeature StaticContentCompression
		{
			Ensure = "Present"
			Name = "Web-Stat-Compression"
		}
		#Install Dynamic Content Compression
		WindowsFeature DynamicContentCompression
		{
			Ensure = "Present"
			Name = "Web-Dyn-Compression"
		}
		#Install Web Security
		WindowsFeature WebSecurity
		{
			Ensure = "Present"
			Name = "Web-Security"
		}
		#Install Request Filtering
		WindowsFeature RequestFiltering
		{
			Ensure = "Present"		
			Name = "Web-Filtering"
		}
		#Install Basic Authenication
		WindowsFeature BasicAuthentication
		{
			Ensure = "Present"		
			Name = "Web-Basic-Auth"
		}
		#Install Client Cert Map Authenication
		WindowsFeature CCMAuthentication
		{
			Ensure = "Present"		
			Name = "Web-Client-Auth"
		}
		#Install Digest Authenication
		WindowsFeature DigestAuthentication
		{
			Ensure = "Present"		
			Name = "Web-Digest-Auth"
		}
		#Install IIS Client Cert Map Authenication
		WindowsFeature IISCCMAuthentication
		{
			Ensure = "Present"		
			Name = "Web-Cert-Auth"
		}
		#Install IP and Domain Restrictions
		WindowsFeature IPDomainRestictions
		{
			Ensure = "Present"		
			Name = "Web-IP-Security"
		}
		#Install URL Authorization
		WindowsFeature URLAuthorization
		{
			Ensure = "Present"		
			Name = "Web-URL-Auth"
		}
		#Install Windows Authentication
		WindowsFeature WindowsAuthentication
		{
			Ensure = "Present"		
			Name = "Web-Windows-Auth"
		}
        #Install Web App Dev
		WindowsFeature WebAppDev
		{
			Ensure = "Present"
			Name = "Web-App-Dev"
		}
		#Install NET Extensibility 45
		WindowsFeature NetExt45
		{
			Ensure = "Present"
			Name = "Web-Net-Ext45"
		}
		#Install NET Extensibility 35
		WindowsFeature NetExt35
		{
			Ensure = "Present"
			Name = "Web-Net-Ext"
		}
		#Install ASP.NET 4.5
		WindowsFeature ASP45
		{
			Ensure = "Present"
			Name = "Web-Asp-Net45"
		}
		#Install ASP.NET 3.5
		WindowsFeature ASP35
		{
			Ensure = "Present"
			Name = "Web-Asp-Net"
		}
		#Install ISAPI Extensions
		WindowsFeature WebISAPI_EXT
		{
			Ensure = "Present"
			Name = "Web-ISAPI-Ext"
		}
		#Install ISAPI Filters
		WindowsFeature ISAPI_Filters
		{
			Ensure = "Present"
			Name = "Web-ISAPI-Filter"
		}
		#Install Web Mgmt Tools
		WindowsFeature WebMgmtTools
		{
			Ensure = "Present"
			Name = "Web-Mgmt-Tools"
		}
        #Install Webserver Management Console
		WindowsFeature WebServerManagementConsole
		{
			Ensure = "Present"	
			Name = "Web-Mgmt-Console"
		}
        #Install Web Management Tools
		WindowsFeature IISManagementTools
		{
			Ensure = "Present"	
			Name = "Web-Scripting-Tools"
		}
        #Install SMB 1.0/CIFS Suppport
		WindowsFeature SMBCIFSSupport
		{
			Ensure = "Present"	
			Name = "FS-SMB1"
		}
        #Install User Interface and Infrastructure
		WindowsFeature SMBCIFSSupport
		{
			Ensure = "Present"	
			Name = "User-Interfaces-Infra"
		}
        #Install Graphical Management Tools
		WindowsFeature GraphManTools
		{
			Ensure = "Present"	
			Name = "Server-Gui-MGMT-Infra"
		}
        #Install Server Graphical Shell
		WindowsFeature ServerGraphShell
		{
			Ensure = "Present"	
			Name = "Server-Gui-Shell"
		}
        #Install Windows
		WindowsFeature SMBCIFSSupport
		{
			Ensure = "Present"	
			Name = "FS-SMB1"
		}
########################

  #Disable IE Enhanced Security
  #Set-ItemProperty -Path “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}” -Name “IsInstalled” -Value 0 -Type "Dword"
        Registry IsInstalled
        {
            Ensure = "Present"
            Key = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}”
            ValueName = “IsInstalled”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Set-ItemProperty -Path “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}” -Name “IsInstalled” -Value 0 -Type "Dword"
        Registry IsInstalled
        {
            Ensure = "Present"
            Key = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}”
            ValueName = “IsInstalled”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Disable Windows Firewall
  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" -Name “EnableFirewall” -Value 0 -Type "Dword"
        Registry FirewallPolicyDomain
        {
            Ensure = "Present"
            Key = “HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile”
            ValueName = “EnableFirewall”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" -Name “EnableFirewall” -Value 0 -Type "Dword"
        Registry FirewallPolicyPublic
        {
            Ensure = "Present"
            Key = “HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile”
            ValueName = “EnableFirewall”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" -Name “EnableFirewall” -Value 0 -Type "Dword"
        Registry FirewallPolicyStandard
        {
            Ensure = "Present"
            Key = “HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\StandardProfile”
            ValueName = “EnableFirewall”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Disable UAC
  #Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name “EnableLUA” -Value 0 -Type "Dword"
        Registry EnableLUA
        {
            Ensure = "Present"
            Key = “HKLM:\SYSTEM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System”
            ValueName = “EnableLUA”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Enable RDP
  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name “fDenyTSConnections” -Value 0 -Type "Dword"
        Registry EnableRDP
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server"
            ValueName = “fDenyTSConnections”
            ValueData = "0"
            ValueType = "Dword"
        }

  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name “UserAuthentication” -Value 0 -Type "Dword"
        Registry DisableNLA
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            ValueName = “UserAuthentication”
            ValueData = "0"
            ValueType = "Dword"
        }

  #VisualFX
  #Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name “VisualFXSetting” -Value 2 -Type "Dword"
        Registry VisualFXSetting
        {
            Ensure = "Present"
            Key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
            ValueName = “VisualFXSetting”
            ValueData = "2"
            ValueType = "Dword"
        }

  #Disable IPv6
  #Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name “DisabledComponents” -Value 0xFF -Type "Dword"
        Registry DisabledComponents
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
            ValueName = “DisabledComponents”
            ValueData = "0xFF"
            ValueType = "Dword"
        }

########################
  #Change CDROM Drive to Z:

       Script Set-CDROM
        {
         SetScript = 
           {#Beginning of Setscript
             $Drive = Get-WmiObject -Class Win32_volume -Filter 'DriveType=5'
             $Drive | Set-WmiInstance -Arguments @{DriveLetter='Z:'}
             $Test = $Drive | where {$_.driveletter -like "Z:"}
             {$Drive | Set-WmiInstance -Arguments @{DriveLetter='Z:'}}
           }#End of Setscript
         TestScript = 
           {#Beginning of test script
             $Test={$Test}
                If ($Test)
              { #Opening IF statememt
                    $true 
              } #End of IF statement
      
                else
              { #Opening of else statement
                    $false
              }#Close else statement
           }#End of test script
         GetScript = {$Null}
        }

########################
  #Create Desktop Sortcuts

  #Create Shortcut to Services.msc

       Script Set-Servicesmsc
        {    
         SetScript = 
           {
             $TargetFile = "$env:SystemRoot\system32\services.msc"
             $ShortcutFile = "$env:Public\Desktop\Services.lnk"
             $WScriptShell = New-Object -ComObject WScript.Shell
             $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
             $Test = Test-Path -Path $ShortcutFile
             $Shortcut.TargetPath = $TargetFile
             $Shortcut.Save()
           }
         TestScript = 
           {#Beginning of test script
             $Test=Test-Path -Path "$env:Public\Desktop\Services.lnk" –erroraction silentlycontinue
              If ($Test)
              { #Opening IF statememt
                    $true 
              } #End of IF statement
      
              else
              { #Opening of else statement
                  $false
              }#Close else statement
            }#End of test script
                
         GetScript = {$Null}                
        }

  #Create Shortcut to Software$

       Script Set-Softwarelnk
        {#beginning of script    
         SetScript = 
           {
             $WshShell = New-Object -comObject WScript.Shell
             $Shortcut = $WshShell.CreateShortcut("$env:Public\Desktop\Software.lnk")
             $Shortcut.TargetPath = "\\ReleaseServer\Software$"
             $Shortcut.WorkingDirectory = "\\ReleaseServer\Software$"
             $Shortcut.Save()
           }
	
         TestScript = 
           { #Beginning of test script
             $Test=Test-Path -Path "$env:Public\Desktop\Software.lnk" –erroraction silentlycontinue
             If ($Test)
             { 
                 $true 
             } 
      
             else
             { 
                 $false
             }
            }

         GetScript = 
            {
                $Null
            }
           }


  #Create Shortcut to This PC

       Script Set-Explorerexe
        {    
         SetScript = 
           {
             $TargetFile = "$env:SystemRoot\explorer.exe"
             $ShortcutFile = "$env:Public\Desktop\This PC.lnk"
             $WScriptShell = New-Object -ComObject WScript.Shell
             $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
             $Test = Test-Path -Path $ShortcutFile
             $Shortcut.TargetPath = $TargetFile
             $Shortcut.Save()
           }
         TestScript = 
            {#Beginning of test script
              $Test=Test-Path -Path "$env:Public\Desktop\This PC.lnk" –erroraction silentlycontinue
              If ($Test)
               { #Opening IF statememt
                   $true 
               } #End of IF statement
      
               else
               { #Opening of else statement
                   $false
               }#Close else statement
            }#End of test script
                
         GetScript = {$Null}                
        }

  #Create Shortcut to Control.exe

       Script Set-Controlexe
        {    
         SetScript = 
           {
             $TargetFile = "$env:SystemRoot\system32\control.exe"
             $ShortcutFile = "$env:Public\Desktop\Control Panel.lnk"
             $WScriptShell = New-Object -ComObject WScript.Shell
             $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
             $Test = Test-Path -Path $ShortcutFile
             $Shortcut.TargetPath = $TargetFile
             $Shortcut.Save()

           }
         TestScript = 
           {#Beginning of test script
              $Test=Test-Path -Path "$env:Public\Desktop\Control Panel.lnk" –erroraction silentlycontinue
              If ($Test)
              { #Opening IF statememt
                   $true 
              } #End of IF statement
      
              else
              { #Opening of else statement
                   $false
              }#Close else statement
            }#End of test script
                
         GetScript = {$Null}                
        }
########################
    }#end node
}#end config

#OC_CaptivaConfig -OutputPath "C:\DSC"
#Start-DscConfiguration "C:\DSC" -wait -verbose -force 