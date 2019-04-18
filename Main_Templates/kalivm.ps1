#Create Any Publisher VM

    ##################################################################
    ##  Parameters
    ##################################################################


Param
    (
        [parameter(Mandatory=$true)] 
        [String]
        $SubscriptionName = "",

        [parameter(Mandatory=$true)] 
        [String]
        $VMName1 = "",

        [parameter(Mandatory=$true)] 
        [String]
        $CustomerCode = "",

        [parameter(Mandatory=$true)] 
        [String]
        $EnvironmentNumber = "",

        [parameter(Mandatory=$true)] 
        [String]
        $ResourceGroupNumber = "",
        
        [parameter(Mandatory=$true)] 
        [String]
        $virtualNetworkName = "",
 
   
        [parameter(Mandatory=$true)] 
        [String]
        $subnet1Name = "",

        [parameter(Mandatory=$true)] 
        [String]
        $location = "",

        [parameter(Mandatory=$true)] 
        [String]
        $Publisher = "",

        [parameter(Mandatory=$true)] 
        [String]
        $Offer = "",

        [parameter(Mandatory=$true)] 
        [String]
        $sku = ""

        )
   
    ##################################################################
    ##  Variables
    ##################################################################
           
            
	        $SubscriptionName = $subscriptionName
            $VMCredentialName = "LocalAdmin"
            $VMCred = Get-AutomationPSCredential -Name $VMCredentialName 
                        
            $LocalAdminUserName = $VMCred.UserName 
            $LocalAdminPassword = $VMCred.GetNetworkCredential().Password
             
    ##################################################################
    ##  Connect to Azure subscription
    ##################################################################
	$azPsVer = Get-Module -ListAvailable -Name Azure
	Write-Output "Azure PS Version $($azPsVer.Version.ToString())"

	$azRmPsVer = Get-Module -ListAvailable -Name AzureRm.Compute
	Write-Output "Azure RM PS Version AzureRm.Compute $($azRmPsVer.Version.ToString())"

	# Authenticating and setting up current subscription
	Write-Output "Authenticating"

	$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection = Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint   $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
} 

    #$subscriptionName
	Select-AzureRmSubscription -SubscriptionName $subscriptionName	

    
   ##################################################################
   ##################################################################    

		    Write-Output ("$(get-date) : New-DCDeploy : Starting to deploy domain servers.")
            $subscription=Get-AzureRmSubscription -SubscriptionName $SubscriptionName
            $subscriptionId=$subscription.SubscriptionId

           #$virtualNetworkResourceGroup = $CustomerCode+"-"+$EnvironmentNumber+"-"+"net"+"-"+$ResourceGroupNumber+"-"+"rg"
            $virtualNetworkResourceGroup = "rds-01-net-001-rg"
            $DCresourceGroupName = $CustomerCode+"-"+$EnvironmentNumber+"-"+"mgt"+"-"+$ResourceGroupNumber+"-"+"rg"
            $VMName1 =  $VMName1
            $virtualMachineSize = 'Standard_B2s'
            $virtualMachineAdminUserName=$LocalAdminUserName
            $virtualMachineAdminPassword=$LocalAdminPassword
            $Publisher=$Publisher
            $Offer=$Offer
            $sky=$sku
            $virtualNetworkName=$virtualNetworkName
            $virtualNetworkResourceGroup=$virtualNetworkResourceGroup
            $subnet1Name = $subnet1Name
            $subNetID = "/subscriptions/"+$SubscriptionID+"/resourceGroups/"+$virtualNetworkResourceGroup+"/providers/Microsoft.Network/virtualNetworks/"+$virtualNetworkName+"/subnets/"+$subnet1Name
            $Location = "East US 2"
  
            
            #Add variables to hash table                
            $parameters=@{}
            $parameters.Add("VMName1",$VMNameDC1)
            $parameters.Add("VirtualMachineSize",$VirtualMachineSize)
            $parameters.Add("Publisher",$Publisher)
            $parameters.Add("Offer",$Offer)
            $parameters.Add("sku",$sku)
            $parameters.Add("virtualMachineAdminUserName",$virtualMachineAdminUserName)
            $parameters.Add("virtualMachineAdminPassword",$virtualMachineAdminPassword)
            $parameters.Add("virtualNetworkResourceGroup",$virtualNetworkResourceGroup)
            $parameters.Add("virtualNetworkName",$virtualNetworkName)
            $parameters.Add("subnet1Name",$subnet1Name)
            $parameters.Add("subnetID",$subnetID)
            $parameters.Add("SubScriptionID",$SubscriptionID)
                   
            #Validation
                   
            #master template path
            $mastertemplateuri='https://raw.githubusercontent.com/EISSystemsDevOps/Automation/master/Main_Templates/KaliVM.json'
            $DeplResults=New-AzureRmResourceGroupDeployment -ResourceGroupName $DCresourceGroupName -TemplateUri $mastertemplateuri -TemplateParameterObject $parameters