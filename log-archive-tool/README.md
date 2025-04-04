# Log Archive Tool
A bash script to archive files older than 90 days inside a directory specified by the user. The script also saves the archive to a S3 bucket.

## Getting Started
1. **Clone the repository**
    ```
    git clone https://github.com/MihaiOsoianu/roadmapsh.git
    cd ./roadmapsh/log-archive-tool/
    ```

2. **Make the script executable**
    ```
    chmod +x log-archive-tool.sh
    ```
3. **Execute the script**  
    ```
    ./log-archive-tool.sh /path/to/directory
    ```
4. **Schedule Cron Job (in example it's scheduled to run daily at midnight)**
	```
	crontab -e
	# add the following line to the file
	0 0 * * * /full/path/to/log-archive-tool.sh
	```
	
![Imgur](https://imgur.com/FBNK2Xj.png)
	
Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/log-archive-tool)