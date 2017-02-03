Configuration MgmtServerConfig
{
    param
    (
      [Parameter(Mandatory=$true)]
        [String]$DomainName,

        [Parameter(Mandatory=$true)]
        [System.Management.Automation.PSCredential]$Admincreds,

        [Parameter(Mandatory=$true)]
        [String]$StorageAcctKey,

        [parameter(Mandatory=$false)] 
        [String]$StorageAccountName="sairmcuploads01",

        [parameter(Mandatory=$false)] 
        [String]$StorageAccountContainer="test",

        [parameter(Mandatory=$false)] 
        [String]$artifactsLocation="https://raw.githubusercontent.com/djnavarrete/paragondev/master/Resources"

    )


    Import-DscResource -ModuleName PSDesiredStateConfiguration, xAzureStorage
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
      

	Node localhost
 	{
		Script InstallAzureRMPowershellModules
        	{
	            SetScript = 
                    {  
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
    
#Install-AzureRMPowershellModules
<#
 		Script InstallAzureRMPowershellModules
        	{
	            SetScript = { 
                    $trustrepo=Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
                    $install=install-module azure
                    import-module azure
                 }
	            TestScript = {$false}
	            GetScript = {<# This must return a hash table #><# }
                Credential = $DomainCreds
               # DependsOn = "[Script]InstallWIPInstaller"
        	}
<#Install using native Package  Did not install or return any errors
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

 xAzureBlobFiles Downloads {
        Path                    = "C:\downloads"
        StorageAccountName      = $StorageAccountName
        StorageAccountContainer = $StorageAccountContainer
        StorageAccountKey       = $StorageAcctKey
        DependsOn = "[Script]InstallAzureRMPowershellModules"
        }

    }#End of node

}