.PHONY: run build test

current_dir=$(shell pwd)
PERSISTENT_PATH=$(current_dir)/persistent
PERSISTENT_DIR=persistent
SSH_DIR=~/.ssh
USERNAME=$(shell whoami)

run:
	docker run --rm -it -v $(SSH_DIR):/home/$(USERNAME)/.ssh -v $(PERSISTENT_PATH):/home/$(USERNAME)/$(PERSISTENT_DIR)/ cloud-dev:latest

build:
	docker build . -t cloud-dev:latest --build-arg username=$(USERNAME)

stow:
	cd dotfiles; stow zsh --target=$(HOME); stow nvim --target=$(HOME); stow oh-my-zsh --target=$(HOME); stow tmux --target=$(HOME)

test:
	echo $(HOME)
