
#Config file for Push mode and Azure setup with extension

#PARAGON Server Common Config ####################################################################
<#
-Set PowerPlan to "High Performance"
-Set various MSDTC configuration 
-Set various Terminal Service settings
-Set ParagonDisallowAnimations to enable
-Set ParagonDisableForceUnloadProfile
#>


Configuration BreServerConfig14xWPreReqsStep2
 {
  
  Param (
         [Parameter(Mandatory=$True)]
         [String[]]$SourcePath,

         [Parameter(Mandatory=$True)]
         [String[]]$SWPath,

         [Parameter(Mandatory=$True)]
         [PSCredential]$LocalCred

         )


  Node ("localhost")
   {

      #Check Reboot and reboot as needed
#      xPendingReboot CheckForReboot {
#         Name = "Check for Reboot and Reboot as needed"
#      }

            $TaskAccount=$Localcred.UserName
            $Password=$Localcred.GetNetworkCredential().Password 

  
 #Do this part in the BRE Config section          
        Package SSMS2014
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\ssms2014\ssms2014\setup.exe"
            Name        = "SQL Server 2014 Client Tools"
            ProductId   = "{B5ECFA5C-AC4F-45A4-A12E-A76ABDD9CCBA}"
            Arguments   = "/q /Action=Install /IACCEPTSQLSERVERLICENSETERMS /FEATURES=Tools,BC,Conn,SSMS,ADV_SSMS"
            #DependsOn   = "[Package]SQLSysClrTypes"
        } 
 <#       
        Package BizTalk2013R2
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "$SWPath\BizTalk2013R2_Standard\BizTalk2013R2_Standard\setup.exe"
            Name        = "SQL Server 2014 Client Tools"
            ProductId   = "{84E4A518-22DE-42F2-8F14-5457EB237C6E}"
            Arguments   = "/s C:\Installs\BREConfig.xml /CABPATH C:\Installs\BtsRedistW2K12EN64.cab"
            #DependsOn   = "[Package]SSMS2014"
        } 
#>
        Script InstallBizTalk2013R2
        {
        TestScript={
            $swinstalled=get-wmiobject -class Win32_Product|Where-object Name -eq "Microsoft BizTalk Server 2013 R2" -erroraction silentlycontinue
            if($Swinstalled)
            {
                $true
            }
            else
            {
                $false
            }
        }
        SetScript={
        $Path="C:\Installs\BizTalk2013R2_Standard\BizTalk2013R2_Standard\setup.exe"
        Start-process $path  -ArgumentList '/s C:\Installs\BREConfig.xml /CABPATH C:\Installs\BtsRedistW2K12EN64.cab' -wait -verb runas
        }
        GetScript =  { @{} }
        Credential = $localcred
        DependsOn   = "[Package]SSMS2014"
        } 

       Script AddLocalAdminsGroup
        {
        TestScript={
           	$groupName = "CLTAUDBIZxx_All_Servers - Admin"
			$localadmins=invoke-command {net localgroup administrators}
            if($localadmins -like "*$groupName*")
            {
                $true
            }
            else
            {
                $false
            }
        }
        SetScript={

					$computer=$env:computername
					$fqdn=$env:userdomain
					$groupName = "CLTAUDBIZxx_All_Servers - Admin"					
                    ([ADSI]"WinNT://$Computer/Administrators,group").Add("WinNT://$fqdn/$groupName")
        }
        GetScript =  { @{} }
        Credential = $localcred
        } 

        Script ConfigureBizTalk2013R2
        {
        TestScript={
           
            $Log=Get-Content C:\installs\breconfiglog.txt -Last 6 -ErrorAction SilentlyContinue
            $Keyword='BAMTools	Configuration Enabled: yes'
            $logcheckforsuccess=$log|%{$_ -match $keyword}
            if($logcheckforsuccess -contains $true)            
            {
                $True
            }
            else
            {
                $false
            }
        }
        SetScript={

        
           #$uacresults= SET-ITEMPROPERTY HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name "enableLUA" -value "0" -ErrorAction Stop -force
            #get-itemproperty  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -name "enableLUA"
            #Start-process 'c:\PROGRA~2\MI548A~1\configuration.exe' -ArgumentList '/s C:\Installs\BREConfig.xml /l C:\Installs\BREConfiglog.txt /NOPROGRESSBAR' -wait -verb runas
        #$localcred=$using:Localcred
         $Taskaccount=$Using:Taskaccount
           $Password=$using:Password
            #$ConfigBRE="Start-process 'c:\PROGRA~2\MI548A~1\configuration.exe' -ArgumentList '/s C:\Installs\BREConfig.xml /l C:\Installs\BREConfiglog.txt /NOPROGRESSBAR'"
		    #$ConfigBREOutput=$ConfigBRE|Out-File C:\Installs\ConfigBRE.ps1 -force

         #    $TaskAccount=$Localcred.UserName
         #   $Password=$Localcred.GetNetworkCredential().Password-noninte
			$Action = New-ScheduledTaskAction -Execute 'c:\PROGRA~2\MI548A~1\configuration.exe' -Argument '/s C:\Installs\BREConfig.xml /l C:\Installs\BREConfiglog.txt /NOPROGRESSBAR'
		    $Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)
			 if(!(Get-ScheduledTask -TaskName 'Configure BizTalk' -ErrorAction SilentlyContinue))
   		     {
			     $registerschedtaskresult = Register-ScheduledTask -Action $Action -Trigger $trigger -TaskName "Configure BizTalk" -Description "Run BizTalk Configuration file based on config XML." -User $TaskAccount -Password $Password
			     write-output $registerschedtaskresult
			 }
			 else
			{
				Write-Output("$(get-date) : Set-AzureParagonNthBREConfiguration : Scheduled task already exists.  Will modify the start time...")	
				$setschedtaskresult=set-scheduledtask -Action $Action -Trigger $trigger -TaskName "Configure BizTalk" -User $TaskAccount
				write-output $setschedtaskresult
			}
			
        }
        GetScript =  { @{} }
        Credential = $localcred
        DependsOn   = "[Script]AddLocalAdminsGroup"
        } 
  	
 }#End of Node
} #End of Config


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
$localcred=get-credential #domadd
$SourcePath='\\slcesfs01.slces.mckesson.com\windowsserver2012r2\sources\sxs'
$SWPath='\\azrdevfile01.paragon.mckesson.com\root\AutomatedInstallSW'
$ServerInstance='AZRQABIZDB02\\PARBIZ'
$BizTalkDBName='JasimTest'
$LocalInstallsFolderPath='C:\installs'
$SourceUNCPathBRE=$SourcePath
$LocalCredBiz=get-credential #AudParaBiz

BREServerConfig14xWPreReqsStep2 -output C:\dsc\ -Swpath $SWPath -SourcePath $SourcePath -localcred $localcred -localcredbiz $localcredbiz -ServerInstance $ServerInstance -BiztalkDBname $BizTalkDBName -LocalInstallsFolderPath $LocalInstallsFolderPath -SourceUNCPathBRE $SourcePath -configurationdata $cd
Start-DscConfiguration -Path C:\dsc\ -wait -verbose -force
 #  $job= (Get-Job -Id 13).ChildJobs.progress
\\azrdevfile01.paragon.mckesson.com\root\AutomatedInstallSW\BizTalk2013R2_Standard\BizTalk2013R2_Standard\setup.exe /s C:\Installs\BREConfig.xml /CABPATH C:\Installs\BtsRedistW2K12EN64.cab

$swinstalled=get-wmiobject -class Win32_Product|Where-object Name -eq "Microsoft BizTalk Server 2013 R2"
#>

#cd WSMan:localhost\shell
#dir
#$env:PSModulePath
