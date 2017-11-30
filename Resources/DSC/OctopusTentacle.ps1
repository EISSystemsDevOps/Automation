configuration OctopusTentacle
{
    param ($ApiKey, $OctopusServerUrl, $Environments, $Roles)

    Import-DscResource -Module OctopusDSC

    Node "localhost"
    {
        cTentacleAgent OctopusTentacle
        {
            Ensure = "Present"
            State = "Started"

            # Tentacle instance name. Leave it as 'Tentacle' unless you have more
            # than one instance
            Name = "Tentacle"
            

            # Registration - all parameters required
            ApiKey = $ApiKey
            OctopusServerUrl = $OctopusServerUrl
            Environments = $Environments
            Roles = $Roles
            

            # How Tentacle will communicate with the server
            CommunicationMode = "Listen"
            ServerPort = "10933"

            # Where deployed applications will be installed by Octopus
            DefaultApplicationDirectory = "C:\Applications"

            # Where Octopus should store its working files, logs, packages etc
            TentacleHomeDirectory = "C:\Octopus"
        }
 <#     #Configure Tentacle
	   {
        cd "C:\Program Files\Octopus Deploy\Tentacle"
        Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
        Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
        Tentacle.exe configure --instance "Tentacle" --reset-trust --console
        Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
        Tentacle.exe configure --instance "Tentacle" --trust "B823BCACC3434508BC3AA71E5C1EDDF83CF72241" --console
        netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
        Tentacle.exe register-with --instance "Tentacle" --server $OctopusServerUrl --apiKey=$ApiKey --role $Roles --environment $Environments --comms-style TentaclePassive --console
        Tentacle.exe service --instance "Tentacle" --install --start --console
        }
#>
    }
}
