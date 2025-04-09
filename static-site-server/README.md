# Static Site Server
This projects is focused on the basics of setting up a web service using Nginx to host a static site and `rsync` to deploy changes to the remote server.

### 1. Register and setup a remote Linux server on AWS
I have manually provisioned an EC2 instance using Amazon Linux AMI. I also added SG rules for port 22 (SSH) and 80 (HTTP).

### 2. Install and Configure Nginx on the Remote Server
1. Connected to the Remote Server
```
ssh -i <your-key> ec2-user@<your-ec2-public-ip>
```
2. Installed Nginx:
```
sudo yum install -y nginx
```
3. Started and enabled Nginx service:
```
sudo systemctl start nginx
sudo systemctl enable nginx
```
4. Created `/var/www/html` directory:
```
sudo mkdir -p /var/www/html
```
5. Set the correct ownership and permissions:
```
sudo chown -R ec2-user:ec2-user /var/www/html
sudo chmod -R 755 /var/www/html
```
6. Configured Nginx:
```
sudo vi /etc/nginx/nginx.conf
# update the root to /var/www/html; default is /usr/share/nginx/html
# save the changes and restart the nginx service
sudo nginx -t
sudo systemctl restart nginx
```

### 3. Prepare Your Static Site
On the local machine I created a folder 'static-site` where I added simple index and 404 html files.

### 4. Use rsync to Update the Remote Server

`deploy.sh` will rsync the files and deploy the new version of the website.

### 5. Point a Domain Name to the Server
I have registered a domain name with AWS (took less than an hour, might take up to 72 hours). By default, after registering the domain AWS created a hosted zone for it. Inside the hosted zone I added an A record and pointed to the public IP address of my EC2 instance.
	
![Imgur](https://imgur.com/GoySLx4.png)
	
Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/static-site-server)
