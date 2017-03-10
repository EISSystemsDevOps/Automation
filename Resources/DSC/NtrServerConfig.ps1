#http://geekswithblogs.net/Wchrabaszcz/archive/2013/09/04/how-to-install-windows-server-features-using-powershell--server.aspx
Configuration NtierServerConfig
{
   param 
   ( 
       # [Parameter(Mandatory)]
       # [String]$DomainName,

       # [Parameter(Mandatory)]
       # [System.Management.Automation.PSCredential]$Admincreds,

       # [Int]$RetryCount=20,
       # [Int]$RetryIntervalSec=30,

        [Parameter(Mandatory)]
        [String]$StorageAccountName,

        [Parameter(Mandatory)]
        [String]$StorageAccountContainer,

        [Parameter(Mandatory)]
        [String]$StorageAccountKey

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

		#Install PrintServices
		WindowsFeature PrintServices
		{
			Ensure = "Present"
			Name = "Print-Services"
		}

		#Install PrintServer
		WindowsFeature PrintServer
		{
			Ensure = "Present"
			Name = "Print-Server"
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
	
		#Install Web HTTP Tracing
		WindowsFeature WebHttpTracing

		{
			Ensure = "Present"
			Name = "Web-Http-Tracing"
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

		#Install WebWebSockets
		WindowsFeature WebWebSockets
		{
			Ensure = "Present"		
			Name = "Web-WebSockets"
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

		#Install Web Mgmt Tools
		WindowsFeature WebMgmtTools
		{
			Ensure = "Present"
			Name = "Web-Mgmt-Tools"
		}

		WindowsFeature WebServerManagementConsole
		{
			Ensure = "Present"	
			Name = "Web-Mgmt-Console"
		}

		#Install Web Metabase
		WindowsFeature WebMetabase
		{
			Ensure = "Present"
			Name = "Web-Metabase"
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

		#Install RSATPrintServices
		WindowsFeature RSATPrintServices
		{
			Ensure = "Present"
			Name = "RSAT-Print-Services"
		}

		#Install NET Extensibility 35
		WindowsFeature NetExt35
		{
			Ensure = "Present"
			Name = "Web-Net-Ext"
		}

		#Install ASP.NET 3.5
#		WindowsFeature ASP35
#		{
#			Ensure = "Present"
#			Name = "Web-Asp-Net"
#		}
########################

#Azure Ntier Server config

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
        
        xPendingReboot RebootAsNeeded
        { 
            Name = "Check for a pending reboot before changing anything" 
        }



    }#end of Node
########################

    
} #end of config