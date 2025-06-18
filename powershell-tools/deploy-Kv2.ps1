# Define reusable variables
$deploymentName = "DevOpsKvDeployment"
$templateFile = "c:\Dev-Environment\Devops-Tools-VM\avm\res\key-vault\vault\devops-kv2.bicep"
$templateparameterFile = "c:\Dev-Environment\Devops-Tools-VM\avm\res\key-vault\vault\devops-kv2.parameters.json"
$resourceGroupName = "DevOps-ToolsV2"
$deploymentLocation = "eastus"
$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844"
$uamiName = "devOps-ToolsVm-identityV2" # Name of your user-assigned managed identity

# Connect to Azure and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId

# Get the User Assigned Managed Identity
$uami = Get-AzUserAssignedIdentity -ResourceGroupName $resourceGroupName -Name $uamiName
$principalId = $uami.PrincipalId
Write-Host "User Assigned Managed Identity Principal ID: $principalId"

# Deploy the Bicep template with the principal ID parameter
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -Location $deploymentLocation `
  -TemplateFile $templateFile `
  -TemplateParameterFile $templateparameterFile `
  #-vmMiPrincipalId $principalId  # Ensure this parameter exists in the Bicep template

