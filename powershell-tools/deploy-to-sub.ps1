# Define reusable variables
$deploymentName = "ResourceGroupDeployment"
$templateFile = "c:\Dev-Environment\DevOps-Tools-VM\avm\res\resources\resource-group\main-rg.bicep"
$parametersFile = "c:\Dev-Environment\DevOps-Tools-VM\avm\res\resources\resource-group\main-rg.parameters.json"
$deploymentLocation = "eastus"
$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844" # Replace with your subscription ID

# Connect to Azure account and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId
# Deploy the Bicep template using Azure PowerShell (Az module)
New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parametersFile
