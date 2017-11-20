Configuration OC_BDIConfig
{
  
  Param (
         
         [Parameter(Mandatory=$True)]
         [String[]]$OCReleaseVMName

        )
          
    Node ("localhost")
	{
########################
   #Install the App Server Role
		WindowsFeature AppServer
		{
			Ensure = "Present"
			Name = "Application-Server"
		}
				
		#Install FileServices
		WindowsFeature FileServices
		{
			Ensure = "Present"
			Name = "File-Services"
		}
  <# #Install .NET Framework 3.5 Features
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
#>
########################

<#  #Disable Windows Firewall
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
#>
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
            Key = "HKLM:\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters"
            ValueName = “DisabledComponents”
            ValueData = "255"
            ValueType = "Dword"
        }

  #Disable IE Enhanced Security
  #Set-ItemProperty -Path “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}” -Name “IsInstalled” -Value 0 -Type "Dword"
        Registry IsInstalledAdmin
        {
            Ensure = "Present"
            Key = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}”
            ValueName = “IsInstalled”
            ValueData = "0"
            ValueType = "Dword"
        }
          
   #Set-ItemProperty -Path “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}” -Name “IsInstalled” -Value 0 -Type "Dword"
        Registry IsInstalledUser
        {
            Ensure = "Present"
            Key = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}”
            ValueName = “IsInstalled”
            ValueData = "0"
            ValueType = "Dword"
        }

########################
<#  #Change CDROM Drive to Z:

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
#>
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
             $Shortcut.TargetPath = "\\$OCReleaseVMName\Software$"
             $Shortcut.WorkingDirectory = "\\$OCReleaseVMName\Software$"
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
            
  } #end of node       
}#end of configuration

#OC_BDIConfig -OutputPath "C:\DSC"
#Start-DscConfiguration "C:\DSC" -wait -verbose -force 

