#!/bin/bash

set -o errexit -o nounset

cd infra

/opt/terraform/terraform plan

/opt/terraform/terraform apply