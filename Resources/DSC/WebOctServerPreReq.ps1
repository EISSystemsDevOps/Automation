Configuration WebOctServerPreReq
{

$Script='
param
        (
            $role=$tentacleRoles
            $ResourceGroupName=$ResourceGroupName,
            $serverUrl=$tentacleOctopusServerUrl,
            $apiKey=$tentacleApiKey,
            $thumbPrint=$thumbPrint
         
        )


$vmName=$env:COMPUTERNAME+"."+$Env:USERDNSDOMAIN
$role=$role
$ResourceGroupName=$ResourceGroupName
$downloadurl = "https://octopus.com/downloads/latest/OctopusTentacle64"
$serverUrl = $serverUrl
$apiKey = $apiKey
$thumbPrint = $thumbprint 
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

cd "C:\Program Files\Octopus Deploy\Tentacle"

.\Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
.\Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
.\Tentacle.exe configure --instance "Tentacle" --reset-trust --console
.\Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
.\Tentacle.exe configure --instance "Tentacle" --trust "B823BCACC3434508BC3AA71E5C1EDDF83CF72241" --console
.\Tentacle.exe register-with --instance "Tentacle" --server "http://azrdevoctopus01.paragon.mckesson.com" --apiKey="API-IV08KCO7RVE2CPTOZBG26KGN0I" --role "$role" --environment "$vmName" --comms-style TentaclePassive --console
.\Tentacle.exe service --instance "Tentacle" --install --start --console
'
$filepath = $env:TEMP+'\Script.ps1'
$script|out-file $filepath -force

$VM=get-azurermvm -ResourceGroupName $ResourceGroupName -Name $VMName
$Location=$VM.Location

# Get storage account name
$storageaccountname = $vm.StorageProfile.OsDisk.Vhd.Uri.Split('.')[0].Replace('https://','')

#get storage account key
$key = (Get-AzureRmStorageAccountKey -Name $storageaccountname -ResourceGroupName $ResourceGroupName)|where-object KeyName -eq 'key1'

#create storage context
$storagecontext = New-AzureStorageContext -StorageAccountName $storageaccountname -StorageAccountKey $key.Value

#create container if it doesn't exsit
$scriptscontainer=get-azurestoragecontainer -name "scripts" -context $storagecontext -ErrorAction SilentlyContinue
if($scriptscontainer -eq $null)
{
    Write-Output ("$(get-date) : Execute-AzureParagonNthCustomScriptExtension : Creating scripts container.")
    $results=New-AzureStorageContainer -Name "scripts" -Context $storagecontext
}
else
{
    write-output("$(get-date) : Execute-AzureParagonNthCustomScriptExtension : Scripts container already exists.")
}

#upload the file
$uploadresults=Set-AzureStorageBlobContent -Container "scripts" -File $filepath -Blob "Script.ps1" -Context $storagecontext -force

#get handler version
$TypeHandlerversion=get-azurermVMextensionImage -publishername Microsoft.Compute -type CustomScriptExtension -Location $Location |Measure-Object -property Version -Maximum
$typehandlerversion=$typeHandlerversion.maximum

#see if CSE exists now.
$CSE=get-AzureRMVMCustomSCriptExtension -resourcegroupname $ResourceGroupname -VMName $VM.Name -Name "Script" -ErrorAction SilentlyContinue
if($CSE -ne $NULL)
{
    $Results=Remove-AzureRmVMCustomScriptExtension -resourcegroupname $resourcegroupname -VMName $VM.Name -Name "Script" -force
}

$Results=Set-AzureRmVMCustomScriptExtension -resourcegroupname $resourcegroupname -VMName $VM.Name -Name "Script" -Location $Location -StorageAccountName $storageaccountname -StorageAccountKey $key.value -FileName "Script.ps1" -ContainerName "scripts" -RunFile "Script.ps1" -TypeHandlerVersion $TypeHandlerversion -verbose -Argument "$role $ResourceGroupName $serverUrl $apiKey $thumbPrint" -verbose
}

