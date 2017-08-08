Configuration WebServerConfigMACWPreReqs
 {
  Param (
         [Parameter(Mandatory=$True)]
         [String[]]$SourcePath,

         [Parameter(Mandatory=$True)]
         [String[]]$SWPath

         )  

  Import-DscResource -ModuleName PSDesiredStateConfiguration #, xPendingReboot
  
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
	  #Set-Eastern Standard Time

        #SET-ITEMPROPERTY -Path 'HKLM:\System\CurrentControlSet\Control\TimeZoneInformation -name "TimeZoneKeyName" -	Value Eastern Standard Time -ErrorAction Stop
        
	Registry TimeZoneKeyName
        {
            Ensure = "Present"
            Key = "HKLM:\System\CurrentControlSet\Control\TimeZoneInformation"
            ValueName = "TimeZoneKeyName"
            ValueData = "Eastern Standard Time"
			ValueType = "String"
        }

#End Set-Eastern Time Zone
 }
	 
