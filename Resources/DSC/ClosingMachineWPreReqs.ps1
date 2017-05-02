
Configuration ClosingMachineWPreReqs
 {
  
  Param (
         
         [Parameter(Mandatory=$True)]
         [String[]]$SWPath

         )  
  Import-DscResource -ModuleName PSDesiredStateConfiguration #, xPendingReboot

  Node ("localhost")
   {
   
   
        Package AspNetMVC3
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\AspNetMVC3\AspNetMVC3Setup.exe"
            Name        = "Microsoft ASP.NET MVC 3"
            ProductId   = "{DCDEC776-BADD-48B9-8F9A-DFF513C3D7FA}"
            Arguments   = "/q /norestart"
        }

     
        Package SQLSysClrTypes
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLSysClrTypes\SQLSysClrTypes\SQLSysClrTypes.msi"
            Name        = "Microsoft System CLR Types for SQL Server 2012 (x64)"
            ProductId   = "{F1949145-EB64-4DE7-9D81-E6D27937146C}"
            Arguments   = "/qn"
        }       
    
        Package ReportViewer2012
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\ReportViewer2012\ReportViewer2012\ReportViewer2012.msi"
            Name        = "Microsoft Report Viewer 2012 Runtime"
            ProductId   = "{C58378BC-0B7B-474E-855C-9D02E5E75D71}"
            Arguments   = "/qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        } 
         
            Package SQLNativeClient_2008R2
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLNativeClient_2008R2\SQLNativeClient_2008R2\sqlncli2008r2.msi"
            Name        = "Microsoft SQL Server 2008 R2 Native Client"
            ProductId   = "{471AAD2C-9078-4DAC-BD43-FA10FB7C3FCE}"
            Arguments   = "IACCEPTSQLNCLILICENSETERMS=YES /qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        } 

        Package SQLNativeClient_2012
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\SQLNativeClient_2012\SQLNativeClient_2012\sqlncli2012.msi"
            Name        = "Microsoft SQL Server 2012 Native Client "
            ProductId   = "{3965C9F9-9B9A-4391-AC4B-8388210D3AA0}"
            Arguments   = "IACCEPTSQLNCLILICENSETERMS=YES /qn"
            DependsOn   = "[Package]SQLSysClrTypes"
        }
<#
        Package VisualStudio2010
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\VSTools_OfficeRuntime2010\vstor_redist.exe"
            Name        = "Microsoft Visual Studio 2010 Tools for Office Runtime (x64)"
            ProductId   = "{9495AEB4-AB97-39DE-8C42-806EEF75ECA7}"
            Arguments   = "/q /norestart"
        }
#>
      Script InstallVisualStudio2010
        {
         GetScript={$null}
         TestScript={
         $installed=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Where-object DisplayName -Like "*Microsoft Visual C++ 2010*"
            if ($installed)
            {
                $True
            }
            else
            {
                $False
            }
         }
         SetScript= {
                    Start-Process -FilePath $SWPath\VSTools_OfficeRuntime2010\vstor_redist.exe -ArgumentList "/q /log" -Wait    
                    }
         }        

        Package OfficeWordOnly2007
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\Office 2007_CorporateVersion\setup.exe"
            Name        = "Microsoft Office Professional Plus 2007"
            ProductId   = "{90120000-0011-0000-0000-0000000FF1CE}"
            Arguments   = "/adminfile ParagonWordOnlyInstall.MSP"
        }
<#
        xPendingReboot RebootAsNeeded
        { 
            Name = "Check for a pending reboot before changing anything" 
        }
 #>       

    }#End of Node
 }#End of Configuration

<#
$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
            PSDSCAllowDomainUser=$True
            RebootNodeIfNeeded = $true
           

        }
    )
}

ClosingMachineWPreReqs -output C:\dsc\ClosingMachineTest -Swpath \\azrdevfile01\Root\AutomatedInstallSW -configurationdata $cd
#Start-DscConfiguration -Force -Path C:\dsc\ClosingMachineTest -wait -verbose -force
 #  $job= (Get-Job -Id 13).ChildJobs.progress



#>