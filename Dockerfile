FROM debian:stretch-slim

MAINTAINER Peter Malmgren <me@$username.com>

ARG username

# System setup

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get clean && \
  apt-get -y install curl

RUN \
  apt-get -y install tmux && \
  apt-get -y install git && \
  apt-get -y install neovim && \
  apt-get -y install locales && \
  apt-get -y install zsh && \
  apt-get -y install stow && \
  apt-get -y install make

RUN \
  echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
  locale-gen en_US.UTF-8

# Create the user and copy over files

RUN useradd -ms /bin/zsh $username

RUN chown -R $username:$username /home/$username

VOLUME /home/$username/.ssh
VOLUME /home/$username/.credentials/
VOLUME /home/$username/persistent/

ADD ./dotfiles/ /home/$username/dotfiles/

COPY ./Makefile /home/$username/

# Install oh my zsh and plug

USER $username
WORKDIR /home/$username/

RUN curl -L http://install.ohmyz.sh | sh || true
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$username/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN rm .zshrc
RUN make stow

# Change my shell to zsh and add scripts to mount in persistent storage

USER root
RUN chsh -s /usr/bin/zsh $username

USER $username
WORKDIR /home/$username

CMD ["zsh"]
