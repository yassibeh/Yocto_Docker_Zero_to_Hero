# Isolated_environment_for_yocto_vscode
Advanced experimentation using DevContainer and yocto_extension to improve productivity and create an isolated environment for the yocto project 



First tests : DevContainer environment to build a image for the STM32MP135F
=============================================================================

This project sets up a clean, portable Docker-based environment for building Yocto images targeting the STM32MP135F board. It avoids permission issues by matching container user permissions with the host user.

Directory Structure
-------------------

You should have the following files in your working directory:

.
├── Dockerfile
├── docker-compose.yml
├── init_env_script_for_docker.sh
├── .env (generated)
└── README.md

The `.env` file will be created automatically by the setup script and contains variables used by Docker Compose.

Purpose of `.env`
-----------------

The `.env` file contains host-specific information that is passed to Docker Compose. These values are used to:

- Set the correct user and group ID inside the container
- Mount the current directory to the proper location in the container

Example content of `.env`:

    USERNAME=yassine
    UID=1000
    GID=1000
    PWD=/home/yassine/Documents/Yocto_Docker_Zero_to_Hero

This allows all files created inside the container to be owned by the correct host user and ensures the container starts in the correct directory.

Docker Compose Configuration
----------------------------

In the `docker-compose.yml`, the following section is critical:

    volumes:
      - ${PWD}:/home/${USERNAME}/yocto
    working_dir: /home/${USERNAME}/yocto

This means:
- The current project directory on the host (${PWD}) is mounted inside the container at /home/${USERNAME}/yocto
- When the container starts, it begins in that mounted directory

This guarantees that changes inside the container reflect directly on the host and vice versa.

Setup Instructions
------------------

1. Generate the .env file based on your current user and path:

    chmod +x init_env_script_for_docker.sh
    ./init_env_script_for_docker.sh

2. Build and start the container:

    docker compose build
    docker compose up -d

3. Enter the container:

    docker exec -it yocto-stm32 bash

Once inside the container, you will be inside the mounted project directory with proper user permissions.

Yocto Workflow Inside the Container
-----------------------------------

After entering the container, you can start working with Yocto:

1. Initialize the repo (example tag used here):

    repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-kirkstone-mp1-v23.06.21

2. Download all layers:

    repo sync

3. Source the build environment:

    source layers/meta-st/scripts/env/setup-env

4. Build the image:

    bitbake st-image-core

Notes
-----

- The container uses Ubuntu 20.04 as a base, which is compatible with Yocto Dunfell/Kirkstone.
- The user inside the container matches the host user to avoid permission conflicts on mounted files.
- All operations happen inside the shared folder /home/<your_username>/yocto, which points to your host project directory.
"""




