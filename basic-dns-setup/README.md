# Basic DNS Setup
In this project I have set up my custom domain name to point to the GitHub Pages site created in another project: GitHub Pages Deployment. For this I followed the official documentation. It's an easy process consisting of two steps:

### 1. Configure your DNS
You need to add two records:
1. A type (@)
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
2. CNAME (www)
mihaiosoianu.github.io

![Imgur](https://imgur.com/W8wYCVJ.png)

### 2. Configure GitHub to serve over your custom domain
Access settings for your repo and access Pages tab. There you will be able to specify a custom domain.

![Imgur](https://imgur.com/rfL2hDp.png)

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/basic-dns)
