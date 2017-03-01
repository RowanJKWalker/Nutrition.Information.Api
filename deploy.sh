#!/bin/bash

set -o errexit -o nounset

cd infra

./terraform plan

./terraform apply