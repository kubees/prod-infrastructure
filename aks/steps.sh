export SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name aks-cluster-project -o json)

# Keep the `appId` and `password` for later use!

export SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

# az role assignment create --assignee $SERVICE_PRINCIPAL \
# --scope "/subscriptions/$SUBSCRIPTION" \
# --role Contributor

ssh-keygen -t rsa -b 4096 -N $SECRET -C "ahmedgrati1999@gmail.com" -q -f  ~/.ssh/id_rsa
export SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

taa -var location="North Central US" -var environment="dev" -var kubernetes_version="1.22" -var service_principal_client_id=$SERVICE_PRINCIPAL -var servic
e_principal_client_secret=$SERVICE_PRINCIPAL_SECRET -var ssh_public_key=$SSH_KEY
