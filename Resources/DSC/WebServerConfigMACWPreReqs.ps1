Configuration WebServerConfigMACWPreReqs
 {
  
  Param (
         [Parameter(Mandatory=$True)]
         [String[]]$SourcePath
         )

  Import-DscResource -ModuleName xPendingReboot

  Node ("localhost")
   {

      #Check Reboot and reboot as needed
      xPendingReboot CheckForReboot {
         Name = "Check for Reboot and Reboot as needed"
      }
    
    #MAC Configuration
    
		$WindowsFeatures = "Web-Server", "Web-WebServer", "Web-Dir-Browsing", "Web-Http-Errors", "NET-HTTP-Activation", "Web-Mgmt-Tools", "Web-Mgmt-Compat", 
                           "Web-Metabase", "Web-Performance", "Web-Http-Logging","Web-Security", "Web-App-Dev", "Web-Http-Tracing", "Web-Health", "Web-Common-Http",
                           "Web-Asp-Net45", "NET-WCF-TCP-PortSharing45", "NET-Framework-Core","NET-Framework-45-Features", "NET-Framework-45-ASPNET", 
                           "NET-WCF-Services45", "Web-Asp-Net", "Web-Net-Ext", "Web-Net-Ext45", "Web-ISAPI-Filter", "Web-ISAPI-Ext",
                           "Web-Default-Doc", "Web-Static-Content", "AS-HTTP-Activation", "Web-Stat-Compression", "Web-Filtering", "Web-Mgmt-Console"

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
}
