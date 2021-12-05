#!/usr/bin/env bash


echo ====================================== Info =======================================================
echo "The below script will first create terraform backend resources that is S3 bucket and DynamoDB table.
They will be used in other modules to store the TF state file"
echo -e "===============================================================================================\n\n"


echo -e "\n\n =========================== Choose Terraform Execution Type ==========================="

PS3="Select the terraform execution type: "

select EXEC_TYPE in apply destroy
do
    echo "You have decided to $EXEC_TYPE the AWS resources!"
    break
done



function terraform_deployment() {
    echo -e "\n\n==================== Creating Application Resources ========================="

    cd infra-deployment/application-infra

    terraform init -reconfigure
    terraform plan -var-file="dev.tfvars" -var="environment=dev"
    terraform apply -var-file="dev.tfvars" -var="environment=dev" -auto-approve

    cd ../..

    echo -e "========================= Completed ================================================ \n\n"
}


if [ $EXEC_TYPE == 'apply' ]; then

  terraform_deployment

fi


if [ $EXEC_TYPE == 'destroy' ]; then

  echo -e "\n\n ============================ Destroying Application Resources ========================="
  cd infra-deployment/application-infra

  terraform init -reconfigure

  terraform destroy -var-file="dev.tfvars" -var="environment=dev" -auto-approve
  cd ../..

  echo -e "========================= Destruction Completed ================================================ \n\n"

fi