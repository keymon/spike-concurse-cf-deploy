#!/bin/sh
docker build -t keymon/terraform:latest .
docker push keymon/terraform:latest
