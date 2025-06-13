$subscriptionId = "58a4a8cd-3b3b-4fcc-ad44-d7bf8c3df844" # Replace with your subscription ID

# Connect to Azure account and select the subscription
Connect-AzAccount -SubscriptionId $subscriptionId

$applicationRegistrationName = "GitHubActionsServicePrincipal"
$application = New-AzADApplication -DisplayName $applicationRegistrationName

$applicationId = $application.AppId  #Client ID
$objectId = $application.Id         # Object ID of the application


Write-Host "Application ID: $applicationId"
Write-Host "Object ID: $objectId"

# Create a federated credential for GitHub Actions
$policy = "repo:gabrieldford/DevOps-Tools-VM:ref:refs/heads/main" # Replace with your GitHub repository and branch

New-AzADAppFederatedCredential `
    -Name 'MyFederatedCredential' `
    -ApplicationObjectId $objectId `
    -Issuer 'https://token.actions.githubusercontent.com' `
    -Audience 'api://AzureADTokenExchange' `
    -Subject $policy

# Creae a service principal for the application. The service principal is the identity that will be used to authenticate with Azure.
New-AzADServicePrincipal -ApplicationId $applicationId

# Assign the service principal a role in the subscription
New-AzRoleAssignment `
    -ApplicationId $applicationId `
    -RoleDefinitionName 'Contributor' `
    -Scope "/subscriptions/$subscriptionId" `
    -Description "Assigning Contributor role to the service principal for GitHub Actions"