# My Containerized Software Development Environment

All of my dotfiles, a Dockerfile, and a Makefile for building and running my development environment.

## Running in Docker

The Makefile should take care of everything for you. It exposes the following arguments:

  - `PERSISTENT_PATH` - this is the full path of the directory on your machine (or cloud VM) that you want to mount into the Docker container
  - `PERSISTENT_DIR` - the directory, relative to `USERNAME`'s home directory, to mount the `PERSISTENT_PATH`
  - `USERNAME` - the username and home directory to launch the development shell with

```
$ make run SSH_DIR=~/.ssh USERNAME=me PERSISTENT_PATH=$(cwd)/persistent
```

## Some notes

I use tmux, zsh, and neovim for development, so this configuration is somewhat geared towards that. Also, nothing in here is really language specific (other than some Haskell plugins in neovim).
