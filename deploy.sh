#!/bin/bash

# Colors
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
NC='\033[0m' # No Color


CONFIG_FILE="$PWD/config.yaml"
Node=$(yq e '.instancetypeNode' $CONFIG_FILE)
Master=$(yq e '.instancetypeMaster' $CONFIG_FILE)
AvailabilityZone=$(yq e '.AvailabilityZone' $CONFIG_FILE)
key_name=$(yq e '.key_name' $CONFIG_FILE)

main() {
  echo
  echo -e "${COLOR_BLUE}===================================================================${NC}"
  echo -e "${COLOR_YELLOW}===================================================================${NC}"
}


initAll(){
    main
    exportVariables
    dowloadSecrets 
    time terraform init -reconfigure -upgrade
}

destroyAll(){
    exportVariables
    terraform destroy
}

exportVariables(){
    getprices
    echo TF_VAR_availabilityZone=${AvailabilityZone} >> .env
    echo TF_VAR_key_name=${key_name} >> .env
    source .env
    export $(cut -d= -f1 .env)
}

dowloadSecrets(){
    BUCKET_NAME="secrets-aws"
    OBJECT_NAME="${key_name}.pem"
    FILE_NAME=".secrets/${OBJECT_NAME}"

    aws s3 cp s3://${BUCKET_NAME}/${OBJECT_NAME} ${FILE_NAME}
    chmod 400 ${FILE_NAME}
}

getprices(){
    if [[ -f '.env' ]];then
        rm .env
    fi

    spotpriceNode=$(aws ec2 describe-spot-price-history \
                    --start-time=$(date +%s) \
                    --availability-zone=${AvailabilityZone} \
                    --instance-types=${Node} \
                    --product-descriptions="Linux/UNIX" | jq -r .SpotPriceHistory[].SpotPrice)

    spotpriceMaster=$(aws ec2 describe-spot-price-history \
                    --start-time=$(date +%s) \
                    --availability-zone=${AvailabilityZone} \
                    --instance-types=${Master} \
                    --product-descriptions="Linux/UNIX" | jq -r .SpotPriceHistory[].SpotPrice)

    echo -e "Prices:\n"
    echo -e "t2.micro:\t\t$spotpriceNode"
    echo -e "t2.medium:\t\t$spotpriceMaster\n"
    echo -e "${COLOR_BLUE}===================================================================${NC}"
    echo -e "${COLOR_YELLOW}===================================================================${NC}"
    echo TF_VAR_spotpriceNode=$spotpriceNode >> .env
    echo TF_VAR_spotpriceMaster=$spotpriceMaster >> .env
}


TerraformPlan(){
    exportVariables
    time terraform plan
}

TerraformApply(){
    main
    exportVariables
    time terraform apply
}

usage() { echo "Usage: $0 [-s Download Secret <key-name> ] [-p Plan Terraform] [-a Apply Terraform] [-i Init Terraform] " 1>&2; exit 1; }

while getopts "dsahpi" option; do
    case "${option}" in
        i) 
            initAll
        ;;
        d) 
            destroyAll
        ;;        
        h) usage
        ;;
        s)
            dowloadSecrets ${OPTARG}
            export key_name=${OPTARG}
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
