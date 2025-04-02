# Server Performance Stats
A bash script to analyse basic server performance stats.  

## Getting Started
1. **Clone the repository**
    ```
    git clone https://github.com/MihaiOsoianu/roadmapsh.git
    cd .\roadmapsh\server-performance-stats\
    ```

2. **Make the script executable**
    ```
    chmod +x server-performance-stats.sh
    ```
3. **Execute the script**  
    ```
    ./server-performance-stats.sh
    ```
![Imgur](https://imgur.com/3dLEodK.png)

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/server-stats)

P.S. I ran the top community solution script (author: Wajeeh) and worked on my project based on the output I saw. After completing and comparing the solutions, I can see that I have things to improve, but I chose to move forward with other projects. Other things I wanted to highlight when comparing my solution and Wajeeh's: mine is slower in execution (0.290s vs 0.235s), and for disk usage, when using the `-h` option for `df` command, there is a risk of showcasing incorrect values if the free space is expressed in MiB instead of Gib.
