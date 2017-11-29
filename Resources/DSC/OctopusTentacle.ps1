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
            OctopusServerThumbprint = "B823BCACC3434508BC3AA71E5C1EDDF83CF72241"

            # How Tentacle will communicate with the server
            CommunicationMode = "Listen"
            ServerPort = "10933"

            # Where deployed applications will be installed by Octopus
            DefaultApplicationDirectory = "C:\Applications"

            # Where Octopus should store its working files, logs, packages etc
            TentacleHomeDirectory = "C:\Octopus"
        }
    }
}
