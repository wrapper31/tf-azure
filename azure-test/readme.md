# Terraform Local Run

This is a sample module to test the terraform modules.

## Prerequisites

To run Terraform, you will need to install Terraform on your local machine to execute the terraform commands.
[Terraform Getting Started](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started)
[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Developer setup

This section will guide you through various steps to run terraform modules.

### Login into Azure

Log into your Azure account

```bash
az login
```

### Set terraform secret variables(if necessary)

If you have secrets in your module, create a file `secret.tfvars` to set sensitive or secret values like below.

```yaml
db_username = "admin"
db_password = "insecurepassword"

```

### Deploy terraform module

To test your [module](https://www.terraform.io/language/modules/syntax), add the module block to `main.tf` under `terraform-azure-test` and run the below commands.

Please make sure to modify the `subscription_id`, `local` values in `main.tf` as needed before running the below commands.

```bash
cd terraform-azure-test
terraform init
terraform plan -var-file="secret.tfvars"
terraform apply -var-file="secret.tfvars" 
```

### Linting, Code smells, security standards

Please run the pre-commit hooks from the root of your workspace(azure-tf-modules) before checking code into source control. 

```bash
pre-commit run -a
```
