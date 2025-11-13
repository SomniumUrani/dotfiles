# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/yhaksnes/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias nv="nvim"
alias py="python3"
alias supdate="sudo pacman -Syu"
alias sinstall="sudo pacman -S"
alias sremove="sudo pacman -Rn"
alias sfullremove="sudo pacman -Rns"
alias sdangerremove="sudo pacman -Rsc"
alias spi="ping 1.1.1.1"
alias ls='ls --color=auto -p'
alias srm="shred -n 0 -z -u"
alias sdev="make --no-print-directory dev"
alias szsource="source ~/.zshrc"
alias spysource="echo todo"
alias suntar="tar -xvf"
alias ff="fastfetch"
alias cl="clear"
alias sesp=". $HOME/esp/esp-idf/export.sh"

function ctouch() {
  for file in "$@"; do
    touch "${file}.h" "${file}.c"
  done
}

function spause(){
	kill -stop $(pidof $1)
}
function sresume(){
	kill -cont $(pidof $1)
}

# Git stuff
alias scom="git commit -m"
alias sadd="git add ."
function srun {
	mkdir -p .tmp
	gcc -o .tmp/program $1 && \
		./.tmp/program
	rm -rf .tmp/
}
alias schange="sadd && scom"


# Añade esto a tu ~/.zshrc
function spdf() {
    pandoc "$1" -o "${1%.*}.pdf" -V geometry="margin=2cm"
}


short_pwd() {
  echo ${PWD/#\/home\/yhaksnes/home}
}

autoload -U colors && colors

setopt prompt_subst

setopt PROMPT_SUBST
PS1=$'%{\e[1m\e[38;2;150;0;150m%}$(short_pwd)%{\e[0m%}\n%{\e[1m\e[38;2;129;34;250m%}%n > %{\e[0m%}'




autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


export KEYTIMEOUT=1


#PATHS
export PATH="$HOME/.local/bin:$PATH"
export STDLIBS=/usr/include


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

