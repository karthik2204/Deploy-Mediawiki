# Mediawiki Deployment on GCP

This repository helps you to spin a GCP instance automatically and install & configure Mediawiki application on it.

## Tools Used:

* Infrastructure provisioning Tool -> Terraform
* Configuration Management Tool -> Ansible

## Pre-requisities:

* Create a project in GCP console with a billing account attached to it.
* Create a service account in your project, generate key for it and download the key file.
* Install terraform and ansible in your machine from where you would want to run this setup.
* Clone this repository in your machine.
* Add the earlier generated key file (terraform_key.json) which contains your service account details in this cloned repository's main directory
* Modify terraform.tfvars file as per your requirement

## Infrastructure Provisioning [Terraform]:

* Initialize the Terraform working directory -> **terrform init**
* Generate the execution plan -> **terraform plan -out=plan.out**
* Build the infrastructure using gnerated plan -> **terraform apply plan.out**
* The IP address of the spinned up instance will be printed in the output after successful execution


## Configuration Management [Ansible]:

* Update the Ansible's inventory file with the output(Spinned up instance's IP address) from terraform execuion  [Pre-requisite]
* Initiate the playbook execution by **ansible-playbook -i hosts playbook.yml --extra-vars="root_password=xxx wiki_password=yyy" -u < username > --private-key < path to user's private key file >**
