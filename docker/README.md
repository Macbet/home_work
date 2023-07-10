
# Resume
The main mistake of the past Dockerfile is that the user + password + database was created during the image build. 
This part has been moved to entrypoint and is now configured using environment variables when starting the container
```
FROM ubuntu:latest  - mistake to using latest image
```


## How to build

```bash
docker buildx build   -t postgresql docker
```

## How to Run
```bash
docker compose up -d
```
## How to Stop
```bash
docker compose down -v
```

## Extra Credit #1: 
Implement a secret encryption solution in order to prevent exposure of the postgres db credentials.

We can configure secrets with env, i create examples in `docker` directory

## Extra Credit #2: Explain the steps you can take to troubleshoot issues with the running container
The main troubleshooting tool for the container is the container logs, we can also check that the ports are opened correctly