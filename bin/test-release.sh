#!/bin/bash

source $PWD/bin/helpers.sh

testRelease(){
    releaseName=$(processReleaseName)
    cmd="codefresh test-release $releaseName"
    cmd="$cmd --cluster $WORKING_CLUSTER"
    eval $cmd
}

testRelease