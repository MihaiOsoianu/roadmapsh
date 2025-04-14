# Configuration Management
The goal of this project is to get familiar with ansible playbooks. This playbook automates the setup of a web server.

### Prerequisites
To replicate this project you will need ansible installed on your local machine and a remote server that you can access through SSH.

### Clone the repository:
```
git clone https://github.com/MihaiOsoianu/roadmapsh.git
cd ./roadmapsh/config-mgmt/
```

### Edit the inventory.ini File and Define the Host (Remote Server):
```
[web]
<ip_address> ansible_user=<your-user> ansible_ssh_private_key_file=<path_to_key>
```

### Short Description of Roles

#### Base Role
Base role updates all packages; ensures firewalld, git, vim are installed; installs fail2ban; starts firewalld; adds 80/tcp rule to firewalld;

#### Nginx Role
Nginx role installs, starts and configures nginx.

#### App Role
App role will copy the content of the static website from a git repo to the web server.

#### SSH Role
SSH role will add the mentioned public key to the web server (you need to edit the `main.yml` file and specify the path to the key you want to add).

### Running the Playbook
```
ansible-playbook -i inventory.ini setup.yml
ansible-playbook -i inventory.ini setup.yml --tags "app"
```

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/configuration-management)