
# 🔐 Objective: Enable GitHub Actions to Authenticate to Azure using OIDC and Federated Credentials

This document explains how GitHub Actions can authenticate to Azure using an Azure AD Application Registration, Federated Credentials, and a Service Principal — eliminating the need for secrets.

---

## ✅ Breakdown of the Flow

### Step 1: Register the Azure AD Application

```powershell
$application = New-AzADApplication -DisplayName "GitHubActionsServicePrincipal"
$applicationId = $application.AppId
$objectId = $application.Id

Write-Host "Application ID: $applicationId"
Write-Host "Object ID: $objectId"
```

This creates the **application object** in Azure AD. It defines the identity but cannot yet authenticate on its own.

---

### Step 2: Add Federated Credential for GitHub Actions

```powershell
$policy = "repo:gabrielford/DevOps-Tools-VM:ref:refs/heads/main"

New-AzADAppFederatedCredential `
    -Name 'MyFederatedCredential' `
    -ApplicationObjectId $objectId `
    -Issuer 'https://token.actions.githubusercontent.com' `
    -Audience 'api://AzureADTokenExchange' `
    -Subject $policy
```

This links a specific GitHub Actions workflow (based on repo and branch) to the Azure app using OIDC.

- **Issuer**: GitHub’s OIDC identity provider
- **Audience**: Azure AD token exchange endpoint
- **Subject**: Specific GitHub repository and branch

Only workflows from `gabrielford/DevOps-Tools-VM` on the `main` branch can authenticate.

---

### Step 3: Create the Service Principal

```powershell
New-AzADServicePrincipal -ApplicationId $applicationId
```

This creates a **service principal**, which is the actual identity that Azure recognizes and authorizes.

---

### Step 4: Assign RBAC Permissions to the Service Principal

```powershell
New-AzRoleAssignment `
    -ApplicationId $applicationId `
    -RoleDefinitionName 'Contributor' `
    -Scope "/subscriptions/$subscriptionId" `
    -Description "Assigning Contributor role to the service principal for GitHub Actions"
```

This grants the service principal access to deploy and manage resources in Azure within the given subscription scope.

---

## 🔄 Authentication Flow at Runtime (GitHub Actions)

1. A GitHub Actions workflow in the allowed repo/branch requests an OIDC token from `https://token.actions.githubusercontent.com`.
2. The workflow uses the `azure/login` action to send that token to Azure AD.
3. Azure AD:
   - Verifies the **issuer**, **audience**, and **subject**
   - Finds the matching **federated credential**
   - Issues an **access token** for the service principal
4. The workflow now uses that access token to interact with Azure APIs.

---

## 🤝 Analogy: GitHub Actions’ Representative in Azure

Think of the **application registration with federated credentials** as:

> "GitHub Actions’ **representative** in the Azure tenant — trusted to perform actions **only** from a specific GitHub repository and branch."

### 🧠 Why This Analogy Works

| Component                  | Purpose                                                              |
|---------------------------|----------------------------------------------------------------------|
| **Application Registration**  | The blueprint of the app — defines the trust relationship              |
| **Federated Credential**      | Declares exactly who from GitHub is allowed to assume this identity |
| **Service Principal**         | The actual identity used to perform actions in Azure                 |
| **GitHub Workflow**           | The entity that assumes the app identity via OIDC and runs the tasks |

This model ensures **least privilege**, **no secrets**, and aligns with **Zero Trust principles**.

---

## 🖼️ Diagram: GitHub Actions OIDC Authentication to Azure

> Save the image file into your repo at `docs/assets/github-azure-oidc-flow.png` and update the path below accordingly.

![GitHub to Azure OIDC Authentication Flow](./docs/assets/github-azure-oidc-flow.png)

---

## ✅ Benefits of This Approach

- 🔐 **No secrets or credentials stored** in GitHub
- 🛡️ **Access control scoped** to specific repo and branch
- 🚀 **Supports CI/CD automation** securely
- ☁️ **Aligns with modern identity patterns** using OIDC and federated trust

---

## 📂 Suggested Project Structure

```
📁 docs/
├── 📁 assets/
│   └── github-azure-oidc-flow.png
└── azure-github-oidc-auth.md
```

---
