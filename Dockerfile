# FROM: The FROM instruction defines the base image for the container. It is the starting point of our image.
# FROM ubuntu:latest pulls the latest Ubuntu image from the Docker registry and sets up a minimal Ubuntu environment to build the rest of the container.
# The base image is important because it provides the operating system environment in which we will install and run our application. Here, it is an Ubuntu system.

# Use the latest Ubuntu image from the official Docker registry as the base image.
# This provides a minimal Ubuntu environment to build our application on top of.
FROM ubuntu:latest

# RUN: The RUN instruction executes commands inside the container during the image build process.
# Run a series of commands to set up the necessary environment inside the container.
# The RUN instruction executes commands inside the container, creating layers in the image.
# We are updating the apt package list and installing required dependencies here.

# Advanced Package Tool
# apt-get is a command line tool for interacting with the Advanced Package Tool (APT) library (a package management system for Linux distributions). It allows us to search for, install, manage, update, and remove software. The tool does not build software from the source code.
# Update the package list and install necessary dependencies:
# - `apt-get update` fetches the latest list of available packages and updates the local package index. apt(Advanced Package Tool)
# - `apt-get install -y` installs specified packages:
#    - `python3.10` installs Python 3.10.
#    - `python3-pip` installs pip (Python's package installer) for Python 3.
#    - `git` installs Git, a version control system used for source code management.
# The `-y` flag automatically answers "yes" to any prompts that may appear during installation, such as when confirming the installation of new dependencies.
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git
# python3.10 \     # Install Python 3.10
# python3-pip \    # Install pip for Python 3 to manage Python packages
# git              # Install Git, a version control system

# Install the Python package 'PyYAML' using pip3. This will allow us to work with YAML files in Python.
# `pip3` is used to install the specified Python package for Python 3. 
RUN pip3 install PyYAML

# COPY: The COPY instruction is used to copy files or directories from the local build context (where the Dockerfile is located) into the container image.
# COPY command copies files from the build context (local machine) into the container image.
# These files are placed into the specified destination path within the container.

# Copy the Python script `feed.py` from the local build context to the container's `/usr/bin/` directory.
# This is the location where executable files are commonly placed on a Linux system.
COPY feed.py /usr/bin/feed.py

# Copy the `entrypoint.sh` shell script from the local build context to the root (`/`) of the container.
# The script will be used as the entrypoint to the container (as specified later).
COPY entrypoint.sh /entrypoint.sh

# ENTRYPOINT: The ENTRYPOINT instruction defines the default command that runs when the container is started.
# ENTRYPOINT specifies the command that will be executed when the container starts.
# The ENTRYPOINT is the initial process that runs when the container is started, which makes it ideal for initializing or setting up services within the container.
# In this case, we're using the '/entrypoint.sh' shell script as the entrypoint for the container. This means that when the container starts, the shell script `/entrypoint.sh` will be executed.
ENTRYPOINT [ "/entrypoint.sh" ]