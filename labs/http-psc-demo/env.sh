#!/bin/bash

export PROJECT_ID=
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")
export NETWORK=
export SUBNET=
export REGION=
export CLOUDRUN_SERVICE=
export PROXY_ONLY_SUBNET=
export PSC_SUBNET_NAME=