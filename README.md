# backend_docker

## Step One Clone Repo

    git clone git@github.com:coder0010/backend_docker

or you can download it by the desktop application of github

    https://github.com/coder0010/backend_docker

Switch to the repo folder

    cd backend_docker

---
## Step Two Prepare Project

1 Prepare the project

    make build-up || docker-compose up -d --build

2 Copy .env.docker file and make the required configuration changes in the .env file

    cp .env.docker .env