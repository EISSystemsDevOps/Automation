Configuration MgmtServerConfig
{
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$DomainName,

        [Parameter(Mandatory=$true)]
        [System.Management.Automation.PSCredential]$Admincreds,

        [Parameter(Mandatory=$true)]
        [String]$StorageAccountKey,

        [parameter(Mandatory=$false)] 
        [String]$StorageAccountName="sairmcuploads01",

        [parameter(Mandatory=$false)] 
        [String]$StorageAccountContainer="test",

        [parameter(Mandatory=$false)] 
        [String]$artifactsLocation="https://raw.githubusercontent.com/djnavarrete/paragondev/master/Resources"

    )

    #Install-Module Azure -Force|Out-file c:\logs.txt
    #Install-Azure
    #Add-AzureRmAccount
    Import-DscResource -ModuleName PSDesiredStateConfiguration, xAzureStorage #, Azure, Azure.Storage, AzureRM.Profile
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
      

	Node localhost
 	{
 <#  don't need this anymore.  using install-module instead
 #GetWPIInstaller
        Script GetWPInstaller
            {
                SetScript = {


                    $folderpath=get-item -path "C:\installs" -ErrorAction SilentlyContinue
                    if($Folderpath -eq $Null)
                    {
                        $foldercreateresults = new-item -itemtype directory -path "c:\installs"
                    }
                    write-output $foldercreateresults
                    $folderpath = "c:\installs"

                    $Source = "https://raw.githubusercontent.com/djnavarrete/paragondev/master/Resources/Microsoft.Web.PlatformInstaller.dll"
                    $Destination = "C:\installs\Microsoft.Web.PlatformInstaller.dll"
                    $Webclient = New-object System.Net.WebClient
                    $webClient.DownloadFile("$source","$Destination")
                    #Unblock-File $destination

                    $Source = "https://raw.githubusercontent.com/djnavarrete/paragondev/master/Resources/WebpiCmd.exe"
                    $Destination = "C:\installs\WebpiCmd.exe"
                    $Webclient = New-object System.Net.WebClient
                    $webClient.DownloadFile("$source","$Destination")

                    $Source = "https://raw.githubusercontent.com/djnavarrete/paragondev/master/Resources/WebpiCmd.exe.config"
                    $Destination = "C:\installs\WebpiCmd.exe.config"
                    $Webclient = New-object System.Net.WebClient
                    $webClient.DownloadFile("$source","$Destination")
              }
	            TestScript = { 
                   $wpiinstalldir=get-item C:\installs\ -ErrorAction SilentlyContinue
            
                    if($wpiinstalldir)
                    {
                        $True
                    }
                    else
                    {
                        $False
                    }
                }
	            GetScript = {<# This must return a hash table #><#}
                Credential = $DomainCreds
            }
#>
<#
#old way, download and run WPI
#Install-AzureRMPowershellModules
 		Script InstallAzureRMPowershellModules
        	{
	            SetScript = { 
                    $script = start-process "C:\installs\WebpiCmd.exe" -ArgumentList '/Install /Products:WindowsAzurePowershell /AcceptEULA /ForceReboot /Log:"C:\installs\AzurePSInstalllog.txt"' -Wait
                    #$script = start-process "C:\installs\WebpiCmd.exe" -ArgumentList '/Install /Products:WindowsAzurePowershellGet /AcceptEULA /Log:"C:\installs\AzurePSInstalllog.txt"' -Wait
                 }
	            TestScript = { 
                   $azurepsinstalled=get-wmiobject -class Win32_Product|where-object Name -like '*Azure Powershell*' 
            
                    if($Azurepsinstalled)
                    {
                        $True
                    }
                    else
                    {
                        $False
                    }
                }
	            GetScript = {<# This must return a hash table #><#}
                Credential = $DomainCreds
                DependsOn = "[Script]GetWPInstaller"
        	}

#>
#New way
#Install-AzurePowershellModules
		Script InstallAzurePowershellModules
        	{
	            SetScript = 
                    {  
                        $trustrepo=Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
                        $install=install-module azure -AllowClobber
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
    


<#
#Install using native Package  Did not install or return any errors
        Package AzurePSPackage
        {
            Ensure = "Present"
            Path ="C:\installs\WebpiCmd.exe"
            ProductId = "64C3C1D5-870E-486B-BE4B-181256DC61F4"
            Arguments =  "/Install /Products:'WindowsAzurePowershell' /AcceptEULA"
            Name = "Microsoft Azure PowerShell - October 2015"
            Credential = $DomainCreds
        }
#>
<#
   Script Reboot
    {
        TestScript = {
            return (Test-Path HKLM:\SOFTWARE\MyMainKey\RebootKey)
        }
        SetScript = {
            #Sleep -Seconds 60
            New-Item -Path HKLM:\SOFTWARE\MyMainKey\RebootKey -Force
             $global:DSCMachineStatus = 1 

        }
        GetScript = { return @{result = 'result'}}
        DependsOn = "[Script]InstallAzureRMPowershellModules"
    }    
#>
        xAzureBlobFiles Downloads {
        Path                    = "C:\downloads"
        StorageAccountName      = $StorageAccountName
        StorageAccountContainer = $StorageAccountContainer
        StorageAccountKey       = $StorageAccountKey
        DependsOn = "[Script]InstallAzurePowershellModules"
        }

    }#End of node

}


