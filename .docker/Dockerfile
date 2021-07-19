FROM ubuntu:20.04

ARG uid
ARG gid
ARG home

LABEL description="Primary image for development by norbert" \
      maintainer="Norbert Nemesh <norbertnemesh@gmail.com>"

WORKDIR $home

# Install all the things!
RUN apt-get update && \
    # install tools being cut of in base image
    yes | unminimize && \
    # GNU C Library: National Language (locale) data [support]
    apt-get install -y locales && \
    # GNU C Library: Precompiled locale data
    apt-get install -y locales-all && \
    # enable man pages
    apt-get install -y man-db && \
    # env variable below needed because otherwise apt asks to choose our current time zone
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    # give access to sudo
    apt-get install -y sudo && \
    # list open files
    apt-get install -y lsof && \
    # tools for building deb packages (g++, gcc, libc, make, ...)
    apt-get install -y build-essential && \
    # trace system calls and signals
    apt-get install -y strace && \
    # gnu debugger
    apt-get install -y gdb && \
    # compiler independent build tool
    apt-get install -y cmake && \
    # notorious text editor
    apt-get install -y vim && \
    # code version control
    apt-get install -y git && \
    # arbitrary TCP and UDP connections and listens
    apt-get install -y netcat && \
    # NET-3 networking toolkit
    apt-get install -y net-tools && \
    # secure remote host access
    apt-get install -y ssh && \
    # client server interaction via command line
    apt-get install -y curl && \
    # fancy process viewer
    apt-get install -y htop && \
    # terminal multiplexer
    apt-get install -y tmux && \
    # how tos on different unix tools
    apt-get install -y tldr && \
    # Console File Manager with VI Key Bindings
    apt-get install -y ranger && \
    # validate shell scripts on syntax errors
    apt-get install -y shellcheck && \
    # rich set of graph drawing tools
    apt-get install -y graphviz && \
    # python3
    apt-get install -y python3 && \
    # python package installer
    apt-get install -y python3-pip && \
    # fancy python shell
    apt-get install -y python3-ipython && \
    # http for humans
    apt-get install -y python3-requests && \
    # error-tolerant HTML parser for Python 3
    apt-get install -y python3-bs4 && \
    # Simple, powerful testing in Python3
    apt-get install -y python3-pytest && \
    # tools for python development
    apt-get install -y python3-dev && \
    # pyvenv binary for python 3
    apt-get install -y python3-venv && \
    # python virtual environment creator
    apt-get install -y python3-virtualenv && \
    # operations on multidimensional arrays
    apt-get install -y python3-numpy && \
    # scientific computing
    apt-get install -y python3-scipy && \
    # operations on columnar datasets
    apt-get install -y python3-pandas && \
    # primary visualization tool
    apt-get install -y python3-matplotlib && \
    # fancy visualization tool
    apt-get install -y python3-seaborn && \
    # primary ml tool
    apt-get install -y python3-sklearn && \
    # IDE for data scientists. Hope some day we can install it as deb package
    pip3 install jupyterlab && \
    # give access for user to working directory
    chown $uid:$gid $home && \
    # Ensure that excessive files are deleted
    # https://github.com/tianon/docker-brew-ubuntu-core/issues/122#issuecomment-495332014
    rm -r /var/lib/apt/lists/*
