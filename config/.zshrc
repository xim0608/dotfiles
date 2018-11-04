if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi

export LANG=ja_JP.UTF-8
export LC_ALL='ja_JP.UTF-8'
export LC_CTYPE=ja_JP.UTF-8
bindkey -e

autoload -Uz colors
colors

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
setopt auto_cd
setopt auto_pushd
setopt list_packed
setopt nolistbeep

setopt share_history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


###############
# fzf functions & setting
###############
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

function fzf-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# fzf x ghq
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

# fzf x ghq x hub
function fzf-src-remote () {
  local selected_repo=$(ghq list | fzf --query "$LBUFFER" | rev | cut -d "/" -f -2 | rev)
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="hub browse ${selected_repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src-remote
bindkey '^h' fzf-src-remote

# fzf x ghq x finder
function fzf-src-finder () {
  local selected_repo=$(ghq list -p | fzf --query "$LBUFFER")
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="open ${selected_repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src-finder
bindkey '^f' fzf-src-finder

# fzf x ghq x sublime
function fzf-src-sublime () {
  local selected_repo=$(ghq list -p | fzf --query "$LBUFFER")
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="cd ${selected_repo} && subl ${selected_repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src-sublime
bindkey '^u' fzf-src-sublime

# fzf x itunes-cli
# same function in # itunes list but below randomize
function fzf-itunes-music-finder () {
  local selected_music=$(itunes list | gshuf | fzf --query "$LBUFFER")
  echo $selected_music
  if [ -n "$selected_music" ]; then
    if [[ $selected_music =~ "'" ]] || [[ $selected_music =~ " " ]]; then
      BUFFER="itunes play \"${selected_music}\""
      zle accept-line
    else
      BUFFER="itunes play ${selected_music}"
      zle accept-line
    fi
  fi
  zle clear-screen
}
zle -N fzf-itunes-music-finder
bindkey '^t' fzf-itunes-music-finder

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
zle -N fkill
bindkey '^k' fkill

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
zle -N fbr
bindkey '^b' fbr

alias -g B='`git branch --sort=-authordate | fzf | sed -e "s/^\*[ ]*//g"`'

###############
# alias
###############
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias md='cd ~/Documents/my_markdowns/ && atom ~/Documents/my_markdowns'
alias cdmd='cd ~/Documents/my_markdowns/'
alias be='bundle exec'
alias b='bundle'
alias g='git'
alias t='tig'
alias bek='bundle exec rake'
alias ber='bundle exec rails'
alias cg='git config --global --list | grep ^alias\.'
alias reload='tmux source-file ~/.tmux.conf && exec $SHELL -l'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias ll='ls -l'
alias la='ls -a'
alias bs='brew services'
alias rbr='rbenv rehash && echo "rbenv rehashed"'
alias pyr='pyenv rehash && echo "pyenv rehashed"'
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias s='ssh'
alias t='tig'
alias gore='GOROOT=$(go env GOROOT) gore'
alias pm='python manage.py'
vagrant() {
  if [[ $@ == "halt all" ]]; then
    command vagrant global-status | grep running | colrm 8 | xargs -L 1 -t vagrant halt
  else
    command vagrant "$@"
  fi
}

##############
# other functions
##############
function command_exists() {
  type "$1" &> /dev/null ;
}
# VSCode
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }

##############
# tmux
##############
if [[ -z $TMUX && -n $PS1 ]]; then
  function tmux() {
    if [[ $# == 0 ]] && tmux has-session 2>/dev/null; then
      command tmux attach-session
    else
      command tmux "$@"
    fi
  }
fi

[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# tmux x fzf-tmux
if [ ! -z "$TMUX" ]; then
  alias fzf='fzf-tmux'
fi

##############
# plugin
##############
eval "$(rbenv init - --no-rehash)"
eval "$(ndenv init - --no-rehash)"
eval "$(pyenv init - --no-rehash)"
if command_exists goenv; then
  eval "$(goenv init - --no-rehash)"
else
  echo "can't init goenv (goenv is not installed)"
fi

[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
if [ -e /usr/local/share/zsh/site-functions/prompt_pure_setup ]; then
    fpath=(/usr/local/share/zsh/site-functions/prompt_pure_setup $fpath)
fi
if [ -e /usr/local/share/zsh/site-functions/async ]; then
    fpath=(/usr/local/share/zsh/site-functions/async $fpath)
fi

export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryuki/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ryuki/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryuki/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ryuki/google-cloud-sdk/completion.zsh.inc'; fi
