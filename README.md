Concourse spike
===============

This repo contains the examples from spiking concourse to deploy a
environment using terraform.

The code is based on vagrant concourse, starts a local concourse installation
which you can interact locally.

How to navigate?
----------------

 * `bosh/aws`: Terraform code that creates:
   * VPC
   * Security groups
   * One VM to ssh as a jumbox
   * A bucket to store the terraform config itself

 * `bosh/*.yml`: some example manifests

 * `dockerfiles`: Dockerfiles for some images, like terraform/

 * `setup.sh`: starts the vagrant and downloads the client

 * `set-pipeline.sh`: helper script to upload and setup the pipelines:

```
./set-pipeline.sh my_env_name bosh/init-bucket.yml
```

How to start?
-------------

You need vagrant and virtualbox.

Then just run: `./setup.sh` and go to: http://192.168.100.4:8080/


How to upload pipelines?
------------------------

To upload pipelines, use `set-pipelines.sh`

Currently we need several env variables that we pass to concourse here.

```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export DOCKER_EMAIL=keymon@gmail.com
export DOCKER_USER=keymon
export DOCKER_PASS=mypass
```

Pipelines
---------

 * `bosh/init-bucket.yml`: A little bick hackery, and the idea
   is to upload the very first config for terraform.

   This pipelines will:
   1. clone this code.
   2. Run terraform to create ONLY the bucket to store the config. That would
      file
   3. if it is successful, it will upload the file to the bucket.

 * `bosh/apply.yml`: This pipeline runs terraform itself:
    1. Gets the state from S3
    2. Gets the code
    3. Runs terraform in a terraform container
    4. Updates the state file

 * `dockerfiles/publish-containers.yml`: Builds and uploads a container.


