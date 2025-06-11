# Define reusable variables
# Sometimes the parameters file is not needed, so it is commented out.

$deploymentName = "DevOpsKvDeployment"
$templateFile = "c:\Dev-Environment\bicep-registry-modules\avm\res\key-vault\vault\devops-kv.bicep"
$resourceGroupName = "DevOps-Tools"
$deploymentLocation = "eastus"
$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844" # Replace with your subscription ID
$vmName = "DevOps-Tools"


# Connect to Azure account and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId

# Get the VM's principal ID
$principalId = (Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName).Identity.PrincipalId
Write-Host "Principal ID: $principalId"

  

# Deploy the Bicep template to a resource group using Azure PowerShell (Az module)
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile `
  -vmPrincipalId $principalId 
