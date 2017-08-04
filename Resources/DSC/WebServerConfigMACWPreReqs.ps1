Configuration WebServerConfigMACWPreReqs
 {
  Param (
         [Parameter(Mandatory=$True)]
         [String[]]$SourcePath,

         [Parameter(Mandatory=$True)]
         [String[]]$SWPath,

	    [Parameter(Mandatory=$true)]
	    [ValidateNotNullorEmpty()]
	    [String]$SystemTimeZone="Eastern Standard Time"

         )  

  Import-DscResource -ModuleName PSDesiredStateConfiguration, xTimeZone #, xPendingReboot
  
  Node ("localhost")
   {
        
    $WindowsFeatures = "Application-Server", "AS-NET-Framework", "AS-Ent-Services", "AS-Incoming-Trans", "AS-Outgoing-Trans", "Print-Services", "Print-Server", `
					   "Web-Server", "Web-WebServer", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing", "Web-Http-Errors", "Web-Static-Content", "Web-Health", "Web-Http-Logging", "Web-Http-Tracing", `
					   "Web-Performance", "Web-Stat-Compression", "Web-Security", "Web-Filtering", "Web-App-Dev", "Web-Net-Ext45", "Web-Asp-Net45", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", `
					   "Web-Mgmt-Console", "Web-Metabase", "NET-Framework-45-Features", "NET-Framework-45-Core", "NET-Framework-45-ASPNET", "NET-WCF-Services45", "NET-WCF-TCP-PortSharing45", "RSAT-Print-Services", "Web-Net-Ext", "Web-Asp-Net"
    foreach ($WindowsFeature in $WindowsFeatures)
     {
      WindowsFeature $WindowsFeature
		{
			Ensure = "Present"
			Name = "$WindowsFeature"
            Source = "$SourcePath"            
       }
     }
   }
	 xTimeZone TimeZoneExample
	 {
		 TimeZone=$SystemTimeZone
	 }
 }

