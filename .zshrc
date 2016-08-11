# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
export EDITOR=/usr/bin/nvim
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/bin:$GOPATH/bin
export HISTFILE=$HOME/.zsh_history
setopt hist_ignore_dups
bindkey -e

autoload -U compinit; compinit
autoload -Uz colors; colors

# peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# shell
set prompt_subst
PROMPT="%{${fg[yellow]}%}%~%{${reset_color}%} %(?.%{$fg[green]%}.%{$fg[red]%})%(?!＼(^o^)／ <!／^o^＼ ? <)%{${reset_color}%} "
PROMPT2='> '

# alias
alias open='xdg-open'
alias vim='nvim'
alias where="command -v"
alias vimshell='vim +VimShell'
alias filer="vim +VimFiler"

# for zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"

# for nvm
source /usr/share/nvm/init-nvm.sh
