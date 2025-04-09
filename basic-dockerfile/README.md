# Basic Dockerfile
This project contains a simple Dockerfile that after build and run outputs "Hello, Captain" by default or "Hello, <name>" if you provided a env var.
To be able to replicate the project ensure you have docker installed on your machine.

### 1. Clone the repository
```
git clone https://github.com/MihaiOsoianu/roadmapsh.git
cd ./roadmapsh/basic-dockerfile/
```

### 2. Build the Docker image
```
docker build -t hello-captain .
```

### 3. Run the Docker container
```
docker run --rm -e NAME=mihai hello-captain
```

Check the project requirements at [roadmap.sh](https://roadmap.sh/projects/basic-dockerfile)
