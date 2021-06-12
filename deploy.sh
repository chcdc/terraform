#!/bin/bash

main() {
  echo
  echo "==================================================================="
}

initAll(){
    main
    getprices
    time terraform init -reconfigure -upgrade
}



dowloadSecrets(){
    main
    BUCKET_NAME="secrets-aws"
    OBJECT_NAME=$1
    FILE_NAME=".secrets/${OBJECT_NAME}"

    aws s3 cp s3://${BUCKET_NAME}/${OBJECT_NAME} ${FILE_NAME}
    chmod 400 ${FILE_NAME}
}

getprices(){
    if [[ -f '.env' ]];then
        rm .env
    fi
    spotpriceNode=$(curl -s -H 'accept: json' 'https://ec2.shop?region=us-east-1&filter=t2.micro' | jq -r .Prices[].SpotPrice)
    spotpriceMaster=$(curl -s -H 'accept: json' 'https://ec2.shop?region=us-east-1&filter=t2.medium' | jq -r .Prices[].SpotPrice)
   
    echo -e "Prices:\n"
    echo -e "t2.micro:\t\t$spotpriceNode"
    echo -e "t2.medium:\t\t$spotpriceMaster\n"
    echo -e "==================================================================="
    echo TF_VAR_spotpriceNode=$spotpriceNode >> .env
    echo TF_VAR_spotpriceMaster=$spotpriceMaster >> .env
    source .env
}


TerraformPlan(){
    time terraform plan
}

TerraformApply(){
    main
    time terraform apply
}

usage() { echo "Usage: $0 [-s Download Secret <key-name> ] [-p Plan Terraform] [-a Apply Terraform] [-i Init Terraform] " 1>&2; exit 1; }

while getopts "s:ahpi" option; do
    case "${option}" in
        i) 
            initAll
        ;;
        h) usage
        ;;
        s)
            dowloadSecrets ${OPTARG}
            export TF_VAR_key_name=${OPTARG}
        ;;
        p)
            source .env
            TerraformPlan
        ;;
        a)  
            source .env
            TerraformApply
        ;;
        *)
            usage
        ;;
    esac
done
shift $((OPTIND-1))

#if [ -z "${s}" ] || [ -z "${p}" ] || [ -z "${a}" ]; then
#    usage
#fi
