#!/bin/bash

# Shell prompt - only add if not already present
grep -qF "PS1='\$(if [[ \"\$PWD\" == /workspaces/* ]];" ~/.bashrc || echo "PS1='\$(if [[ \"\$PWD\" == /workspaces/* ]]; then realpath --relative-to=/workspaces \"\$PWD\"; else echo \"\\w\"; fi)\\$ '" >> ~/.bashrc

# Dependencies
apt update && apt install --no-install-recommends -y \
    gdb \
    libc-dbg \
    git-lfs  \
    bsdmainutils \
    ripgrep \
    xz-utils \
    graphviz

# Build the examples
rm -rf build
cmake --preset clang && cmake --build build
