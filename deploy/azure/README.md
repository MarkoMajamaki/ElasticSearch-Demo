# Deploy to Azure

Modify 'infra/terraform.tfvars' and 'infra/tfstate.tfvars' files to configure system for you needs to Azure. Run 'az login' to login your Azure account.

Deploy
```bash
terraform -chdir=infra/azure init
terraform -chdir=infra/azure plan -out=tfplan
terraform -chdir=infra/azure apply -auto-approve tfplan
```
Destroy
```bash
terraform -chdir=infra/enviroments/$env destroy -auto-approve
```
