#!/bin/bash

source $PWD/bin/helpers.sh

kubectl config use-context $WORKING_CLUSTER
cmd="kubectl get pod -l release=$(processReleaseName) -o custom-columns=VERSION:.metadata.labels.version"
echo "Running kubectl query: $cmd"
version_in_cluster=$( eval $cmd | tail -n 1)

cf_export LAST_PROD_VERSION=$version_in_cluster