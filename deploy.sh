#!/bin/bash

set -o errexit -o nounset

echo "before cd"

cd infra

echo "after cd"

/opt/terraform/terraform plan

/opt/terraform/terraform apply