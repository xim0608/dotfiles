autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
autoload -U promptinit; promptinit

export PATH="/usr/local/bin:$PATH"

###############
# path
###############
export PYENV_ROOT="$HOME/.pyenv/shims"
export PATH="$PYENV_ROOT:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/python"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="${HOME}/.ndenv/bin:${PATH}"
export EDITOR=vim
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
export GOPATH=$HOME/Works
export PATH=$PATH:$GOPATH/bin
export ITUNES_CLI_FUZZY_TOOL="fzf"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"


###############
# xenv init
###############
jenv(){
  export JENV_ROOT=/usr/local/var/jenv
  eval "$(command jenv init -)"
  jenv "$@"
}

export APPENGINE_SDK="$HOME/.go_appengine/google-cloud-sdk/platform/google_appengine"
export PATH="$PATH:$APPENGINE_SDK"

############
