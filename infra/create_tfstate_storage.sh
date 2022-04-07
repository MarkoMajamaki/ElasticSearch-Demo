set -a;
source tfstate.tfvars
set +a

# Create the resource group
if  ( `az group exists --resource-group $tfstate_rg_name` == "true" );
then
    echo "Do not create resource group $tfstate_rg_name because it already exists!"
else
    echo "Creating $tfstate_rg_name resource group..."
    az group create -n $tfstate_rg_name -l $location
    echo "Resource group $tfstate_rg_name created."
fi

# Create the storage account
if ( `az storage account check-name --name $tfstate_storage_account_name --query 'nameAvailable'` == "true" );
then
    echo "Creating $tfstate_storage_account_name storage account..."
    az storage account create \
        -g $tfstate_rg_name \
        -l $location \
        --name $tfstate_storage_account_name \
        --sku Standard_LRS \
        --encryption-services blob
    echo "Storage account $tfstate_storage_account_name created."
else
    echo "Do not create storage account $tfstate_storage_account_name because it already exists!"
fi

# Get the storage account key
echo "Get storage account key..."
account_key=$(az storage account keys list --resource-group $tfstate_rg_name --account-name $tfstate_storage_account_name --query [0].value -o tsv)

# Create a storage container (for the Terraform State)
if ( `az storage container exists --name $tfstate_container_name --account-name $tfstate_storage_account_name --account-key $account_key --query exists` == "true" );
then
    echo "Storage container $tfstate_container_name exists..."
else
    echo "Creating $tfstate_container_name storage container..."
    az storage container create --name $tfstate_container_name --account-name $tfstate_storage_account_name --account-key $account_key
    echo "Storage container $tfstate_container_name created."
fi