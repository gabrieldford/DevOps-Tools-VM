# Define reusable variables
$deploymentName = "ResourceGroupDeployment"
$templateFile = "c:\Dev-Environment\bicep-registry-modules\avm\res\resources\resource-group\main-rg.bicep"
$parametersFile = "c:\Dev-Environment\bicep-registry-modules\avm\res\resources\resource-group\main-rg.parameters.json"
$deploymentLocation = "eastus"

# Deploy the Bicep template using Azure PowerShell (Az module)
New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parametersFile
