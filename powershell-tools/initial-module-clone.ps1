# Define the GitHub repository URL
$repoUrl = "https://github.com/Azure/bicep-registry-modules.git"

# Define the folder path within the repo you want to extract
$folderToCheckout = "avm/res/compute"

# Define the existing local directory you want to use (MUST already exist)
$localPath = "../bicep-registry-modules"

# Step 1: Navigate into the pre-existing folder where Git should initialize the repo
Set-Location $localPath

# Step 2: Initialize an empty Git repo in the current directory
git init

# Step 3: Set the remote origin to the GitHub repo
git remote add origin $repoUrl

# Step 4: Disable automatic blob download and avoid checking out the full repo
git config core.sparseCheckout true
git config extensions.partialClone origin
git config core.blobFilter blob:none

# Step 5: Enable sparse-checkout in cone mode
git sparse-checkout init --cone

# Step 6: Set the folder you want to check out
git sparse-checkout set $folderToCheckout

# Step 7: Pull only the specified folder's contents from the remote
git pull origin main

# Optional: Open the checked-out directory in File Explorer
explorer $folderToCheckout
