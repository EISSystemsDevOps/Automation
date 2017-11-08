Configuration WebOctServerPreReq
{

Param(
	[Parameter(Mandatory=$True)]
	[string]$environment = "LPOctopus3",

	[Parameter(Mandatory=$True)]
	[string]$tentaclename = "Tentacle registered from client",

	[Parameter(Mandatory=$True)]
	[string]$endpointUrl = "http://localhost:10933",
	
	[Parameter(Mandatory=$True)]
	[string]$roles = "Web"
)

$downloadurl = "https://octopus.com/downloads/latest/OctopusTentacle64"
$serverUrl = "http://azrdevoctopus01.paragon.mckesson.com"
$apiKey = "API-IV08KCO7RVE2CPTOZBG26KGN0I"
$thumbPrint = "B823BCACC3434508BC3AA71E5C1EDDF83CF72241" 
$workdir = "c:\Temp"
$msiFilename =  Join-Path -Path $workdir -ChildPath "Octopus.Tentacle.msi" 
$certpath = Join-Path -Path $workdir -ChildPath "OctopusServerCertificate.p7b"
$tentaclepath = "C:\Program Files\Octopus Deploy\Tentacle"


if(!(Test-Path $workdir))
{
	New-Item -Path $workdir -ItemType Directory
}


#Download Octopus Tentacle
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$webClient = new-object System.Net.WebClient
$webClient.DownloadFile( $downloadurl, $msiFilename )

if (Test-Path $msiFilename)
{
    #Install Tentacle
	Start-Process -FilePath "msiexec" -ArgumentList "/i $msiFilename /quiet /lv* $workdir\install.log" -Wait -Passthru | Out-Null
			
	Set-Location $tentaclepath
	
	netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
    
	$pathtoexe = Join-Path -Path $tentaclepath -ChildPath "Tentacle.exe"

	if ( (Test-Path $pathtoexe) -eq $false )
	{
		Write-Output ("Cannot find file Tentacle.exe" + $pathtoexe)
		exit 1
	}
}

    #Configure Tentacle
	#.\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
	#.\Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console 
	#.\Tentacle.exe configure --instance "Tentacle" --reset-trust --console 
	#.\Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --noListen "False" --console 
	#.\Tentacle.exe configure --instance "Tentacle" --trust "$thumbPrint" --console 
	#.\Tentacle.exe service --instance "Tentacle" --install --start --console 

    .\Tentacle\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" 
    .\Tentacle\Tentacle.exe new-certificate --instance "Tentacle" --if-blank
    .\Tentacle\Tentacle.exe configure --instance "Tentacle" --reset-trust
    .\Tentacle\Tentacle.exe configure --instance "Tentacle" --app "C:\Octopus\Applications" --port "10933" --noListen "False"
    .\Tentacle\Tentacle.exe configure --instance "Tentacle" --trust "B823BCACC3434508BC3AA71E5C1EDDF83CF72241"
    .\Tentacle\Tentacle.exe service --instance "Tentacle" --install --stop --start

<# #Confirm Octopus Tentacle Service Is Running
	$servname = "OctopusDeploy Tentacle"
	if ((Get-Service $servname).Status -ne "Running")
	{
		$counter = 0
			
		Do
		{
			(Get-Service $servname).Status
			Start-Sleep -Seconds 5
			$counter++
		} while ( ($counter -lt 5) -and ((Get-Service $servname).Status -ne "Running")) 

	}
	else
	{
		Write-Output "Octopus Service Is Running" 
	}

    #Get The Tentacle Client Thumbprint
	$raw = .\Tentacle.exe show-thumbprint --nologo --console
	("Raw = " + $raw)
		
	$client_thumbprint = $raw -Replace 'The thumbprint of this Tentacle is: ', ''
	("Client Thumbprint = " + $client_thumbprint) | Out-File $logfile -Append
		
	$pathtodll = Join-Path -Path $tentaclepath -ChildPath "Octopus.Client.dll"
	
	if((Test-Path $pathtodll) -eq $f)
	{
		Write-Output ("Cannot find file Octopus.Client.dll" + $pathtodll)
		exit 1
	}

	Add-Type -Path 'Newtonsoft.Json.dll'
	Add-Type -Path 'Octopus.Client.dll'
  
    #Register The Tentacle With Octopus Server
	$endpoint = new-object Octopus.Client.OctopusServerEndpoint $serverUrl, $apiKey
	$repository = new-object Octopus.Client.OctopusRepository $endpoint
	$tentacle = New-Object Octopus.Client.Model.MachineResource
 
	$tentacle.name = $tentaclename
	$tentacle.EnvironmentIds.Add($environment)

	foreach($role in (New-Object -TypeName System.String -ArgumentList $roles).Split(','))
	{
		$tentacle.Roles.Add($role)
	}
	
	$tentacleEndpoint = New-Object Octopus.Client.Model.Endpoints.ListeningTentacleEndpointResource
	$tentacle.EndPoint = $tentacleEndpoint
	$tentacle.Endpoint.Uri = "$endpointUrl"  
	$tentacle.Endpoint.Thumbprint = "$client_thumbprint"
	$repository.machines.create($tentacle)   
}
else
{
	Write-Output ("Cannot find Octopus install file: " + $msiFilename)
} 
#>
}
#End of config
#$cd = @{
 #   AllNodes = @(
 #       @{
 #           NodeName = 'localhost'
 #           PSDscAllowPlainTextPassword = $true
 #           PSDSCAllowDomainUser=$True
 #           RebootNodeIfNeeded = $true
 #          
#
#        }
#    )
#} 
#OctopuswithTP -output c:\dsc -ConfigurationData $Cd
#Start-DscConfiguration -Path C:\dsc\ -wait -verbose -force
 #  $job= (Get-Job -Id 13).ChildJobs.progress