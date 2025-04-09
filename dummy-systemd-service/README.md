# Dummy Systemd Service
The goal of this project is to get familiar with systemd.

**Execute the commands as root.**

```
git clone https://github.com/MihaiOsoianu/roadmapsh.git
cd ./roadmapsh/dummy-systemd-service/

chmod +x dummy.sh
mv dummy.sh /var/local/usr/dummy.sh
mv dummy.service /etc/systemd/system/dummy.service

systemctl daemon-reload
systemctl start dummy
systemctl enable dummy

systemctl status dummy
journalctl -u dummy -f
```

![Imgur](https://imgur.com/MZhouKD.png)
	
Killing the process to check the autorestart

![Imgur](https://imgur.com/mJw631j.png)	

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/dummy-systemd-service)