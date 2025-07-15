# Define the folder to add to the sparse checkout. This is the folder in the remote repository. In this instance it is in the Azure Verifiied Modules (AVM) repository.
# Example: "avm/res/key-vault/access-policy"
$folderToAdd = "avm/res/storage/storage-account"

# Optional: change to your local Git repo path
$repoPath = "../bicep-registry-modules"
Set-Location $repoPath

# Check if sparse-checkout has been initialized
$sparseDir = Join-Path -Path ".git/info" -ChildPath "sparse-checkout"
if (-Not (Test-Path $sparseDir)) {
    Write-Host "Sparse checkout not initialized. Initializing now..." -ForegroundColor Yellow
    git sparse-checkout init --cone
}


# Add the folder to the sparse-checkout set
Write-Host "Adding folder to sparse-checkout: $folderToAdd" -ForegroundColor Cyan
git sparse-checkout add $folderToAdd

# Pull the new folder from the remote
Write-Host "Pulling new folder contents from origin..." -ForegroundColor Green
git pull
