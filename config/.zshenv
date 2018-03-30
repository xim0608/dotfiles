autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
autoload -U promptinit; promptinit
prompt pure

export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
export PATH="/usr/local/bin:$PATH"

###############
# path
###############
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.5/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export GOPATH=$HOME/.go
export PATH="$HOME/.goenv/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH


###############
# xenv init
###############

eval "$(rbenv init -)"

rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}
pyenv(){
  eval "$(command pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv "$@"
}
jenv(){
  export JENV_ROOT=/usr/local/var/jenv
  eval "$(command jenv init -)"
  jenv "$@"
}
goenv(){
  eval "$(command goenv init -)"
  goenv "$@"
}

export APPENGINE_SDK="$HOME/.go_appengine/google-cloud-sdk/platform/google_appengine"
export PATH="$PATH:$APPENGINE_SDK"

############


###############
# peco settings
###############
#function peco-select-history() {
#  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
#  CURSOR=$#BUFFER
#  zle clear-screen
#}
#zle -N peco-select-history
#bindkey '^r' peco-select-history

