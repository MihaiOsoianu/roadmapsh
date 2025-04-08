# SSH Remote Server Setup
The goal of this project is to setup a remote linux server and configure it to allow SSH connections.
All commands mentioned were run in Windows Terminal (PowerShell) except the `ssh-copy-id` for which I used Git Bash.

### 1. Create a Remote Server
I have manually provisioned an EC2 instance using Amazon Linux AMI. The SG rule for port 22 was created by default.

### 2. Generate SSH Key Pairs
```
ssh-keygen -t ed25519
```
I have named the keys roadmapshprimary and roadmapshsecondary
  
### 3. Add the SSH Key to the Server
For the first key I have logged on the server using EC2 Instance Connect and copied the public key manually to ~/.ssh/authorized_keys file. After that I tried to copy the second key using the `ssh-copy-id` command. 

```
ssh-copy-id -i ~/.ssh/roadmapshsecondary.pub ec2-user@<ip-address>
```
However, I was facing some authentication issues (even though the already added key was working fine when using `ssh` command), so I decided to enable password based authentication for SSH to check if it will work. After editing the `/etc/ssh/sshd_config` file and restarting the `sshd` service I run the command again and after entering my password it worked fine. After that I removed the password based authentication.

In case the authorized_keys file was not created by default you can run the following commands:
```
mkdir -p ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
# Using your prefered editor add the key inside authorized_keys file
```

### 4. Configure SSH Access on Your Local Machine
I have edited the ~/.ssh/config file on my machine:

```
Host first
	HostName <ip-address>
	User ec2-user
	IdentityFile ~/.ssh/roadmapshprimary

Host second
	HostName <ip-address>
	User ec2-user
	IdentityFile ~/.ssh/roadmapshsecondary
```

After setting these aliases I decided to test the `ssh-copy-id` command again using an alias. I tried to upload another key I had on my machine, but the command failed mentioning it might be a duplicate (it wasn't), still not sure what was the reason, but I then run the command again using `-f` flag and it worked properly.

```
ssh-copy-id -f -i ~/.ssh/mtckey.pub first
```

### 5. Install Fail2ban for SSH Security

1. Install Fail2Ban
```
sudo yum install fail2ban -y
```
2. Enable and start Fail2ban
```
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```
3. Configure Fail2Ban for SSH protection
```
sudo vi /etc/fail2ban/jail.local
# add the following contents inside the file
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = systemd
bantime = 7200
findtime = 300
maxretry = 3
```
4. Restart the Fail2ban service:
```
sudo systemctl restart fail2ban
```
5. Test it
```
fail2ban-client status sshd
```

![Imgur](https://imgur.com/sf3akee.png)

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/ssh-remote-server-setup)
