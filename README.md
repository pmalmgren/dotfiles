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

## godot configuration

`godot` configuration starts with a second level heading named `godot configuration`. `godot` will ignore anything in the top section, so feel free to add any documentation here.

```
username: godot
dotfile-directory: dotfiles
entrypoint: zsh

packages:
  - neovim
  - git
  - tmux
  - zsh
  - curl

# system-setup runs as root, define volumes etc.
system-setup:
  - VOLUME /home/$username/.ssh
  - VOLUME /home/$username/.credentials/
  - VOLUME /home/$username/persistent/
  - RUN chsh -s /usr/bin/zsh $username

# user-setup runs as the user defined above in username.
user-setup:
  - RUN curl -L http://install.ohmyz.sh | sh || true
  - RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  - RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$username/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  - RUN rm .zshrc || true
```
