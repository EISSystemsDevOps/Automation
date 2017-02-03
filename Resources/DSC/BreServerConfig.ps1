#http://geekswithblogs.net/Wchrabaszcz/archive/2013/09/04/how-to-install-windows-server-features-using-powershell--server.aspx
Configuration BreServerConfig
{
   param 
   ( 
       # [Parameter(Mandatory)]
       # [String]$DomainName,

       # [Parameter(Mandatory)]
       # [System.Management.Automation.PSCredential]$Admincreds,

       # [Int]$RetryCount=20,
       # [Int]$RetryIntervalSec=30,

        [Parameter(Mandatory=$true)]
        [String]$StorageAccountName,

        [Parameter(Mandatory=$true)]
        [String]$StorageAccountContainer,

        [Parameter(Mandatory=$true)]
        [String]$StorageAccountKey,

        [Parameter(Mandatory=$true)]
        [String]$CommonStorageAccountName,

        [Parameter(Mandatory=$True)]
        [String]$CommonStorageAccountKey,

        [Parameter(Mandatory=$true)]
        [String]$CommonStorageAccountContainer

    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration, xPendingReboot, xAzureStorage #xSQLServer    
     
	Node ("localhost")
	{
		#Install the App Server Role
		WindowsFeature AppServer
		{
			Ensure = "Present"
			Name = "Application-Server"
		}
		
		#Install ASNet Framework
		WindowsFeature ASNETFramework
		{
			Ensure = "Present"
			Name = "AS-NET-Framework"
		}
		#Install ASEntServices
		WindowsFeature ASEntServices
		{
			Ensure = "Present"
			Name = "AS-Ent-Services"
		}

		#Install ASDistTransaction
		WindowsFeature ASDistTransaction
		{
			Ensure = "Present"
			Name = "AS-Dist-Transaction"
		}
		#Install ASWSAtomic
		WindowsFeature ASWSAtomic
		{
			Ensure = "Present"
			Name = "AS-WS-Atomic"
		}

		#Install ASIncomingTrans
		WindowsFeature ASIncomingTrans
		{
			Ensure = "Present"
			Name = "AS-Incoming-Trans"
		}

		#Install AS-Outgoing-Trans
		WindowsFeature ASOutgoingTrans
		{
			Ensure = "Present"
			Name = "AS-Outgoing-Trans"
		}

		#Install ASTCPPortSharing
		WindowsFeature ASTCPPortSharing
		{
			Ensure = "Present"
			Name = "AS-TCP-Port-Sharing"
		}

		#Install ASWebSupport
		WindowsFeature ASWebSupport
		{
			Ensure = "Present"
			Name = "AS-Web-Support"
		}

		#Install ASWASSupport
		WindowsFeature ASWASSupport
		{
			Ensure = "Present"
			Name = "AS-WAS-Support"
		}

		#Install ASHTTPActivation
		WindowsFeature ASHTTPActivation
		{
			Ensure = "Present"
			Name = "AS-HTTP-Activation"
		}

		#Install ASNamedPipes
		WindowsFeature ASNamedPipes
		{
			Ensure = "Present"
			Name = "AS-Named-Pipes"
		}
 
 		#Install ASTCPActivation
		WindowsFeature ASTCPActivation
		{
			Ensure = "Present"
			Name = "AS-TCP-Activation"
		}

 		#Install FileAndStorageServices
		WindowsFeature FileAndStorageServices
		{
			Ensure = "Present"
			Name = "FileAndStorage-Services"
		}

 		#Install FileAndStorageServices
		WindowsFeature StorageServices
		{
			Ensure = "Present"
			Name = "Storage-Services"
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

		#Install Static WebHttpRedirect
		WindowsFeature WebHttpRedirect
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
	
		#Install Web HTTP Logging
		WindowsFeature WebLogLibraries
		{
			Ensure = "Present"
			Name = "Web-Log-Libraries"
		}

		#Install WebRequestMonitor
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

		#Install WebDynCompression
		WindowsFeature WebDynCompression
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

		#Install WebBasicAuth
		WindowsFeature WebBasicAuth
		{
			Ensure = "Present"		
			Name = "Web-Basic-Auth"
		}

		#Install WebCertProvider
		WindowsFeature WebCertProvider
		{
			Ensure = "Present"		
			Name = "Web-CertProvider"
		}

		#Install WebCertProvider
		WindowsFeature WebClientAuth
		{
			Ensure = "Present"		
			Name = "Web-Client-Auth"
		}

		#Install WebDigestAuth
		WindowsFeature WebDigestAuth
		{
			Ensure = "Present"		
			Name = "Web-Digest-Auth"
		}

		#Install Web-Cert-Auth
		WindowsFeature WebCertAuth
		{
			Ensure = "Present"		
			Name = "Web-Cert-Auth"
		}

		#Install WebIPSecurity
		WindowsFeature WebIPSecurity
		{
			Ensure = "Present"		
			Name = "Web-IP-Security"
		}


 		#Install WebUrlAuth
		WindowsFeature WebUrlAuth
		{
			Ensure = "Present"		
			Name = "Web-Url-Auth"
		}

 		#Install WebWindowsAuth
		WindowsFeature WebWindowsAuth
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

		#Install ASP.NET 4.5
		WindowsFeature ASP45
		{
			Ensure = "Present"
			Name = "Web-Asp-Net45"
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

		#Install WebWebSockets
		WindowsFeature WebWebSockets
		{
			Ensure = "Present"		
			Name = "Web-WebSockets"
		}

		#Install Web Mgmt Tools
		WindowsFeature WebMgmtTools
		{
			Ensure = "Present"
			Name = "Web-Mgmt-Tools"
		}
       
        #Install Web Management Console
		WindowsFeature WebServerManagementConsole
		{
			Ensure = "Present"	
			Name = "Web-Mgmt-Console"
		}
        #Install web compatibility
		WindowsFeature Web-Mgmt-Compat
		{
			Ensure = "Present"	
			Name = "Web-Mgmt-Compat"
		}

 
 		#Install Web Metabase
		WindowsFeature WebMetabase
		{
			Ensure = "Present"
			Name = "Web-Metabase"
		}

 		#Install WebScriptingTools
		WindowsFeature WebScriptingTools
		{
			Ensure = "Present"
			Name = "Web-Scripting-Tools"
		}

 		#Install WebMgmtService
		WindowsFeature WebMgmtService
		{
			Ensure = "Present"
			Name = "Web-Mgmt-Service"
		}

 		#Install NETFrameworkFeatures
		WindowsFeature NETFrameworkFeatures
		{
			Ensure = "Present"
			Name = "NET-Framework-Features"
		}

 		#Install NETFrameworkFeatures
		WindowsFeature NETFrameworkCore
		{
			Ensure = "Present"
			Name = "NET-Framework-Core"
		}

		#Install .NET Framework Features
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

		#Install .NET Framework 45 ASPNET
		WindowsFeature NETFramework45ASPNET
		{
			Ensure = "Present"
			Name = "NET-Framework-45-ASPNET"
		}

		#Install .NET 45 WCF Services
		WindowsFeature NETWCFServices45
		{
			Ensure = "Present"
			Name = "NET-WCF-Services45"
		}

		#Install .NET 45 WCF HTTP Activation 4.5
		WindowsFeature NETWCFHTTPActivation45
		{
			Ensure = "Present"
			Name = "NET-WCF-HTTP-Activation45"
		}

		#Install .NET 45 WCF HTTP Activation 4.5
		WindowsFeature NETWCFMSMQActivation45
		{
			Ensure = "Present"
			Name = "NET-WCF-MSMQ-Activation45"
		}

		#Install NET-WCF-Pipe-Activation45
		WindowsFeature NETWCFPipeActivation45
		{
			Ensure = "Present"
			Name = "NET-WCF-Pipe-Activation45"
		}

		#Install NETWCFTCPActivation45
		WindowsFeature NETWCFTCPActivation45
		{
			Ensure = "Present"
			Name = "NET-WCF-TCP-Activation45"
		}

		#Install NETWCFTCPPortSharing45
		WindowsFeature NETWCFTCPPortSharing45
		{
			Ensure = "Present"
			Name = "NET-WCF-TCP-PortSharing45"
		}

		#Install MSMQ
		WindowsFeature MSMQ
		{
			Ensure = "Present"
			Name = "MSMQ"
		}

		#Install MSMQServices
		WindowsFeature MSMQServices
		{
			Ensure = "Present"
			Name = "MSMQ-Services"
		}

		#Install MSMQ-Server
		WindowsFeature MSMQServer
		{
			Ensure = "Present"
			Name = "MSMQ-Server"
		}

		#Install NLB
		WindowsFeature NLB
		{
			Ensure = "Present"
			Name = "NLB"
		}

		#Install RDC
		WindowsFeature RDC
		{
			Ensure = "Present"
			Name = "RDC"
		}


		#Install FS-SMB1
		WindowsFeature FSSMB1
		{
			Ensure = "Present"
			Name = "FS-SMB1"
		}

		#Install UserInterfacesInfra
		WindowsFeature UserInterfacesInfra
		{
			Ensure = "Present"
			Name = "User-Interfaces-Infra"
		}

		#Install Server-Gui-Mgmt-Infra
		WindowsFeature ServerGuiMgmtInfra
		{
			Ensure = "Present"
			Name = "Server-Gui-Mgmt-Infra"
		}

		#Install ServerGuiShell
		WindowsFeature ServerGuiShell
		{
			Ensure = "Present"
			Name = "Server-Gui-Shell"
		}

		#Install PowerShell
		WindowsFeature PowerShell
		{
			Ensure = "Present"
			Name = "PowerShell"
		}

		#Install PowerShellRoot
		WindowsFeature PowerShellRoot
		{
			Ensure = "Present"
			Name = "PowerShellRoot"
		}

		#Install PowerShell-V2
		WindowsFeature PowerShellV2
		{
			Ensure = "Present"
			Name = "PowerShell-V2"
		}

 		#Install PowerShell-ISE
		WindowsFeature PowerShellISE
		{
			Ensure = "Present"
			Name = "PowerShell-ISE"
		}

 		#Install WAS
		WindowsFeature WAS
		{
			Ensure = "Present"
			Name = "WAS"
		}
 	
    	#Install WAS-Process-Model
		WindowsFeature WASProcessModel
		{
			Ensure = "Present"
			Name = "WAS-Process-Model"
		}

     	#Install WAS-Config-APIs
		WindowsFeature WASConfigAPIs
		{
			Ensure = "Present"
			Name = "WAS-Config-APIs"
		}

      	#Install WoW64Support
		WindowsFeature WoW64Support
		{
			Ensure = "Present"
			Name = "WoW64-Support"
		}
########################

#Azure BRE Server config

#New way
#Install-AzurePowershellModules
		Script InstallAzurePowershellModules
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
    

        xAzureBlobFiles DownloadDBAndVardata 
        {
            Path                    = "C:\downloads"
            StorageAccountName      = $StorageAccountName
            StorageAccountContainer = $StorageAccountContainer
            StorageAccountKey       = $StorageAccountKey
            DependsOn = "[Script]InstallAzurePowershellModules"
        }


        xAzureBlobFiles DownloadCommon 
        {
            Path                    = "C:\downloads\common"
            StorageAccountName      = $CommonStorageAccountName
            StorageAccountContainer = $CommonStorageAccountContainer
            StorageAccountKey       = $CommonStorageAccountKey
            DependsOn = "[Script]InstallAzurePowershellModules"
        }
        
        xPendingReboot RebootAsNeeded
        { 
            Name = "Check for a pending reboot before changing anything" 
        }


    } #End of Node
}#End of config