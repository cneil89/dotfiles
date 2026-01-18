# History control
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

#Autocompletion
if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi
 
# Set Complete path
export PATH="$HOME/.local/bin:$PATH"
set +h

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ls() {
    if [[ "$*" == "-ltr" ]]; then
        eza -lh --group-directories-first --icons=auto
    else
        eza --icons=auto --group-directories-first "$@"
    fi
}

alias go="grc go"
alias lsa='ls -a'
# alias ls='eza -lh --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color always {}'"

# directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# tools
alias d='docker'
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }

# git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

########################################
#            FUNCTIONS                 #
########################################
compress() { tar -czvf "${1%/}.tar.gz" "${1%}"; }
alias decompress="tar -xzvf"

# Find packages without leaving the terminal
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S" 

img2jpg() {
    magick $1 --quality 95 -strip ${1%:*}.jpg
}

########################################
#            PROMPT                    #
########################################
force_color_prompt=yes
color_prompt=yes

PS1=$'\uf0a9 '
PS1="\[\e]0;\w\a\]$PS1"

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

export PATH=/repo/dotfiles/bin:$HOME/go/bin:$PATH
export HYPRSHOT_DIR=$HOME/Pictures
   

export C=clang
export CXX=clang++
export CMAKE_GENERATOR="Ninja"

export PGPASSWORD=devpass
pgdev() {
    PGCOMMAND="psql --host=localhost --username=postgres"
    if [[ -n $1 && -f $1 ]]; then
        $PGCOMMAND -f $1
    else
        $PGCOMMAND
    fi

}
export GREENLIGHT_DB_DSN="postgres://greenlight:pa55word@localhost:5432/greenlight?sslmode=disable"
