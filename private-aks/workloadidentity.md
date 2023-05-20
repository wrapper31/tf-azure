# Azure AD workload identity

When applications or services run in environments outside Azure, they need Azure AD application secrets to authenticate to Azure AD and access resources such as Azure and Microsoft Graph. These secrets pose a security risk if they are not stored securely and rotated regularly. Azure AD workload identity federation removes the need for these secrets in selected scenarios.

Azure AD Workload Identity for Kubernetes is an open-source project that integrates with the capabilities native to Kubernetes to federate with external identity providers. It leverages the public preview capability of Azure AD workload identity federation. With this project, developers can use native Kubernetes concepts of service accounts and federation to access Azure AD protected resources, such as Azure and Microsoft Graph, without needing secrets.

## How to use Azure AD workload identity federation with Kubernetes

There are four parts to get this working end-to-end in a Kubernetes cluster:

* Cluster administrators configure their cluster to issue tokens. An OIDC discovery document is published to allow validation of these tokens. Kubernetes cluster becomes a security token issuer, issuing tokens to Kubernetes Service Accounts.
* Developers configure their deployments to use Kubernetes service accounts and get Kubernetes tokens.
* Azure AD applications are configured to trust the Kubernetes tokens.
* The Kubernetes tokens are exchanged for Azure AD access tokens and used to access Azure AD protected resources such as Azure and Microsoft Graph.

![Alt text](./img/cluster.png)
![image](https://github.com/wrapper31/tf-azure/assets/20044786/8a99a16e-0906-4635-8187-9e186528d49a)


## End-to-end walk-through

Since this is a new preview capability in AKS, there are several steps involved here:

*1*. Ensure that azure rm provider is updated with latest preview version 3.32.0

```bash
required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.32.0"
    }
```

*2*. As a public preview feature, AAD workload identity can now be easily enabled as an add-on. Let’s get started by registering the preview feature using one of the two options.

__Note:__ The below step is a one time registration to your subscription.

*1*. Using cli

```bash
  az feature register --name EnablePodIdentityPreview --namespace Microsoft.ContainerService
```

*2*. Using terraform

```bash
resource "azurerm_resource_provider_registration" "container_service" {
  name = "Microsoft.ContainerService"

  feature {
    name       = "EnableWorkloadIdentityPreview"
    registered = true
  }
}
```

*3*. After registration, set up the kubernetes cluster with flags enabled for OIDC issuer and workload identity.

```bash
resource "azurerm_kubernetes_cluster" "this" {
      oidc_issuer_enabled        = true
      workload_identity_enabled = true
}

```

*4*. Set access policy for the `user-assigned managed identity` to access the Azure AD resource. Sample example below is for event hub `RBAC access`.

```bash
  resource "azurerm_user_assigned_identity" "this" {
    name                = "id-aks"
    resource_group_name = var.resource_group_name
    location            = var.location
    tags                = var.tags
  }

  resource "azurerm_role_assignment" "event_hubs_data_owner" {
  scope                = var.event_hub_namespace
  role_definition_name = "Azure Event Hubs Data Owner"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}
```

*5*. Create a kubernetes service account

   Create a kubernetes `service account` and annotate it with the client ID of the user assigned identity created in step 4.

  ```bash
  resource "kubernetes_service_account" "mi" {
    metadata {
      name      = local.mi_service_account_name
      namespace = local.aks_namespace
      annotations = {
        "azure.workload.identity/client-id" = var.aks_identity_client_id
      }
      labels = {
        "azure.workload.identity/use" : "true"
      }
    }
  }
  ```

*6*. Establish `federated identity credential` between the identity and the service account issuer & subject.

```bash
  resource "azurerm_federated_identity_credential" "mi" {
  name                = "${var.name_prefix}-aks-${var.descriptor}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.issuer_url
  parent_id           = var.uai_id
  subject             = "system:serviceaccount:${local.aks_namespace}:${local.mi_service_account_name}"
}
```

The federated credential created can be viewed from the `Managed Identities` section in portal.
![Alt text](./img/FederatedCredential.png)


*7*. Deploy the pod that references the service account created in step 6. Once its deployed, you can validate if identity is successfully created in aks as below. Please supply the necessary placeholder values in the command. The output displays the environment variables and volumes as highlighted below.

```bash
az aks command invoke   --resource-group <resource_group>  --name <aks_cluster_name>   --command "kubectl describe pod <pod_name> -n <aks_namespace>"
```

| Environment variable  | Description  |  
| :------------ |:--------------- |  
| AZURE_AUTHORITY_HOST      | The Azure Active Directory (AAD) endpoint. |  
| AZURE_CLIENT_ID | The user assigned client ID of the Managed identity. |
| AZURE_TENANT_ID | The tenant ID of the Azure account. |
| AZURE_FEDERATED_TOKEN_FILE | The path of the projected service account federated token file. |

| Volume  | Description  |  
| :------------ |:--------------- |  
| azure-identity-token      | The projected service account volume. |  

| Volume mount  | Description  |  
| :------------ |:--------------- |  
| /var/run/secrets/azure/tokens/azure-identity-token  | The path of the projected service account token file. |  

![Alt text](./img/kubernetesazidentity.png)
![image](https://github.com/wrapper31/tf-azure/assets/20044786/14ca2fab-c906-4b18-aa5b-e5eedd91148b)

