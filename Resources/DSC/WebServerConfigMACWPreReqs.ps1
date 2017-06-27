
Configuration WebServerConfigMACWPreReqs
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

	Node localhost
	{
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

		#Install Net HTTP Activation
		WindowsFeature NETHTTPActivation
		{
			Ensure = "Present"
			Name = "NET-HTTP-Activation"
		}

		#Install Web Mgmt Tools
		WindowsFeature WebMgmtTools
		{
			Ensure = "Present"
			Name = "Web-Mgmt-Tools"
		}

		#Install Web Mgmt Compatibility
		WindowsFeature WebMgmtCompat
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

		#Install Web Performance
		WindowsFeature WebPerformance
		{
			Ensure = "Present"
			Name = "Web-Performance"
		}

		#Install Web HTTP Logging
		WindowsFeature WebHttpLogging
		{
			Ensure = "Present"
			Name = "Web-Http-Logging"
		}
		
		#Install Web Security
		WindowsFeature WebSecurity
		{
			Ensure = "Present"
			Name = "Web-Security"
		}

		#Install Web App Dev
		WindowsFeature WebAppDev
		{
			Ensure = "Present"
			Name = "Web-App-Dev"
		}

		#Install Web HTTP Tracing
		WindowsFeature WebHttpTracing

		{
			Ensure = "Present"
			Name = "Web-Http-Tracing"
		}

		#Install Web Health
		WindowsFeature WebHealth
		{
			Ensure = "Present"
			Name = "Web-Health"
		}

		#Install Common HTTP Features 
		WindowsFeature WebCommonHttp
		{
			Ensure = "Present"
			Name = "Web-Common-Http"
		}

		#Install ASP.NET 4.5
		WindowsFeature ASP45
		{
			Ensure = "Present"
			Name = "Web-Asp-Net45"
		}

		#Install NET WCF TCP Port Sharing45
		WindowsFeature NETWCFTCPPortSharing45
		{
			Ensure = "Present"
			Name = "NET-WCF-TCP-PortSharing45"
		}

		#Install .NET Framework Core
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

		#Install ASP.NET 3.5
		WindowsFeature ASP35
		{
			Ensure = "Present"
			Name = "Web-Asp-Net"
		}

		#Install NET Extensibility 35
		WindowsFeature NetExt35
		{
			Ensure = "Present"
			Name = "Web-Net-Ext"
		}
		
		#Install NET Extensibility 45
		WindowsFeature NetExt45
		{
			Ensure = "Present"
			Name = "Web-Net-Ext45"
		}

		#Install ISAPI Filters
		WindowsFeature ISAPI_Filters
		{
			Ensure = "Present"
			Name = "Web-ISAPI-Filter"
		}

		#Install ISAPI Extensions
		WindowsFeature WebISAPI_EXT
		{
			Ensure = "Present"
			Name = "Web-ISAPI-Ext"
		}

		#Install Default Document
		WindowsFeature DefaultDocument
		{
			Ensure = "Present"
			Name = "Web-Default-Doc"
		}

		#Install Static Content
		WindowsFeature StaticContent
		{
			Ensure = "Present"
			Name = "Web-Static-Content"
		}

		#Install AS HTTP Activation
		WindowsFeature ASHTTPActivation
		{
			Ensure = "Present"
			Name = "AS-HTTP-Activation"
		}
		
		#Install Static Content Compression
		WindowsFeature StaticContentCompression
		{
			Ensure = "Present"
			Name = "Web-Stat-Compression"
		}

		#Install Request Filtering
		WindowsFeature RequestFiltering
		{
			Ensure = "Present"		
			Name = "Web-Filtering"
		}

		WindowsFeature WebServerManagementConsole
		{
			Ensure = "Present"	
			Name = "Web-Mgmt-Console"
		}	
    }
} 