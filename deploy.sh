#!/bin/bash

echo "begin"

set -o errexit -o nounset

echo "before cd"

cd infra

echo "after cd"

terraform plan

terraform apply

terraform output nutrition_information_api_uri

export NUTRITION_INFORMATION_API_URI=$(terraform output nutrition_information_api_uri) 

npm run-script test:integration

echo \"yes\" | terraform destroy