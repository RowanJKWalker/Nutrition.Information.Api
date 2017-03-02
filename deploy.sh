#!/bin/bash

echo "begin"

set -o errexit -o nounset

echo "before cd"

cd infra

echo "after cd"

terraform plan

terraform apply