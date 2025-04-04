#!/bin/bash

# function to check if a directory exists
check_directory() {
	while [ ! -d "$log_dir" ]; do
		echo "Please provide a valid directory path!"
		read -p "Enter the log directory path: " log_dir
	done
	echo "The selected directory is $log_dir"
}

# check if the user provided an argument when running the script
if [ -z "$1" ]; then
	read -p "Enter the log directory path: " log_dir
	check_directory "$log_dir"
else
	log_dir="$1"
	check_directory "$log_dir"
fi

# ensure file dest dir and save file path to a var
dest_dir="/var/log/logs_archive"
mkdir -p "$dest_dir"
file_path="$dest_dir/logs_archive_$(date +'%Y%m%d_%H%M%S').tar.gz"
echo

# check if there are any files to be archived at user specified dir
file_count=$(find $log_dir -type f -mtime +90 ! -path "$dest_dir/*" | wc -l)
if [ $file_count -eq 0 ]; then
	echo "No files older than 90 days to archive. Exiting."
	exit 0
fi

echo "START JOB"
find $log_dir -type f -mtime +90 ! -path "$dest_dir/*" -print0 | tar -czvf "$file_path" --null -T -
echo -e "JOB FINISHED \n\nFile location: \n$file_path\n"

# upload to remote location (s3)
upload_to_s3() {
        read -r -p "Do you want to upload the archive to S3? (y/n) " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
                echo "Please ensure AWS CLI is installed and AWS credentials are configured."
                read -p "Please mention S3 bucket path(e.g. name/path): " bucket_path
                upload_output=$(/usr/local/bin/aws s3 cp "$file_path" "s3://$bucket_path" 2>&1)
                if [ $? -ne 0 ]; then
                        echo -e "\nFailed to upload to S3."
                        echo -e "Error message:\n"
                        echo -e "$upload_output\n"
                else
                        echo "Archive successfully uploaded to S3"
                fi
        else
                echo "Archive not uploaded to S3"
        fi
}
upload_to_s3
