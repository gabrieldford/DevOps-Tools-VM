# Define reusable variables
$deploymentName = "DevOpsVnetDeployment"
$templateFile = "c:\Dev-Environment\bicep-registry-modules\avm\res\network\virtual-network\main-vnet.bicep"
$parametersFile = "c:\Dev-Environment\bicep-registry-modules\avm\res\network\virtual-network\main-vnet.parameters.json"
$resourceGroupName = "DevOps-Tools"
$deploymentLocation = "eastus"
$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844" # Replace with your subscription ID


# Connect to Azure account and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId

# Deploy the Bicep template to a resource group using Azure PowerShell (Az module)
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parametersFile