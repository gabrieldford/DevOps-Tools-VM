# Define reusable variables
$deploymentName = "DevOpsManagedIdDeployment"
$templateFile = "c:\Dev-Environment\Devops-Tools-VM\avm\res\managed-identity\user-assigned-identity\devopsTools-mi.bicep"
$resourceGroupName = "DevOps-ToolsV2"
$deploymentLocation = "eastus"
$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844" # Replace with your subscription ID


# Connect to Azure account and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId

# Deploy the Bicep template to a resource group using Azure PowerShell (Az module)
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile 
 