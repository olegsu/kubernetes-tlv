#!/bin/bash

source $PWD/bin/helpers.sh

runCodefreshCmd(){
    releaseName=$(processReleaseName)
    cmd="codefresh install-chart"
    cmd="$cmd --tiller-namespace kube-system"
    cmd="$cmd --cluster $WORKING_CLUSTER"
    cmd="$cmd --namespace $NAMESPACE"
    cmd="$cmd --repository $HELM_REPO_NAME"
    cmd="$cmd --name $CHART_NAME"
    cmd="$cmd --release-name $releaseName"
    cmd="$cmd --version $VERSION"
    if $IS_FEATURE ; then cmd="$cmd --context dynamic" ; fi

    if [[  -n "$DOCKER_CONFIG_CTX_NAME" ]];
    then
        cmd="$cmd --context $DOCKER_CONFIG_CTX_NAME"
    fi

    echo "Running install cmd: $cmd"
    eval $cmd
}

echo "Cluster version: $LAST_PROD_VERSION"
echo "Current version: $VERSION"

if [ "$IS_FEATURE" != "true" ] && [ "$VERSION" = "$LAST_PROD_VERSION" ]
then
    echo "Current version wasnt changed"
    exit 1
else
    runCodefreshCmd
fi
