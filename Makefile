.PHONY: run build stow

current_dir=$(shell pwd)
PERSISTENT_PATH=$(current_dir)/persistent
PERSISTENT_DIR=persistent
SSH_DIR=~/.ssh
USERNAME=$(shell whoami)

run:
	docker run --rm -it -v $(SSH_DIR):/home/$(USERNAME)/.ssh -v $(PERSISTENT_PATH):/home/$(USERNAME)/$(PERSISTENT_DIR)/ cloud-dev:latest

build:
	docker build . -t cloud-dev:latest --build-arg username=$(USERNAME)

stow2:
	cd $(DOTFILE_DIR); ls -la | grep ^d | awk '{ print $$9 }' | grep -v '\.\+' | xargs stow

stow:
	cd dotfiles; stow zsh --target=$(HOME); stow nvim --target=$(HOME); stow tmux --target=$(HOME)
