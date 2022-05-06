FROM ubuntu:latest 
RUN apt-get -q update && apt-get -q upgrade -y

########### Install ZSH
RUN apt-get -q install wget fonts-powerline -y
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" --  \
  -t https://github.com/denysdovhan/spaceship-prompt \
  -p https://github.com/zsh-users/zsh-autosuggestions \
  -p https://github.com/zsh-users/zsh-completions \
  -p https://github.com/zsh-users/zsh-syntax-highlighting \
  -p aws \
  -a 'ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#262626,bg=#1c1c1c"' 


########## Install NVM (Node)
SHELL ["/bin/bash", "--login", "-c"]
ENV NVM_DIR /usr/local/nvm
# A versão do node deve ser informada no formato completo (ex: 16.14.2)
ENV NODE_VERSION 16.14.2
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN node -v
RUN npm install yarn -g

########## Install Dev Tools
RUN apt-get -q install nano -y
