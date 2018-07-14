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
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward


###############
# peco setting
###############
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# peco x ghq
function peco-src () {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# peco x ghq x hub
function peco-src-remote () {
  local selected_repo=$(ghq list | peco --query "$LBUFFER" | rev | cut -d "/" -f -2 | rev)
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="hub browse ${selected_repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src-remote
bindkey '^h' peco-src-remote

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
alias reload='exec $SHELL -l'
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

##############
# other functions
##############
function command_exists() {
  type "$1" &> /dev/null ;
}
# VSCode
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryuki/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ryuki/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryuki/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ryuki/google-cloud-sdk/completion.zsh.inc'; fi
