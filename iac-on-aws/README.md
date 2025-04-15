# Configuration Management
The goal of this project is to get familiar with terraform. I also reused parts of the ansible playbook written for another project.

### Prerequisites
To replicate this project you will need ansible and terraform installed on your local machine and access to an AWS account (you will need to also change the way you authenticate to it in main.tf).

### Clone the repository:
```
git clone https://github.com/MihaiOsoianu/roadmapsh.git
cd ./roadmapsh/iac-on-aws/
```

### Initialize Terraform
```
terraform init
```

### Deploy the Infrastructure
```
terraform apply
# use -auto-approve to apply without confirmation
```
After execution you can use the outputed IP Address to check the static site.

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/iac-digitalocean)