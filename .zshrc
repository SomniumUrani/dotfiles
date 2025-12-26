HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '/home/yhaksnes/.zshrc'

autoload -Uz compinit
compinit

alias nv="nvim"
alias py="python3"
alias supdate="sudo pacman -Syu"
alias sinstall="sudo pacman -S"
alias sremove="sudo pacman -Rn"
alias sfullremove="sudo pacman -Rns"
alias sdangerremove="sudo pacman -Rsc"
alias spi="ping 1.1.1.1"
alias ls='lsd -I "compile_commands.json"'
alias la='lsd -a'
alias szsource="source ~/.zshrc"
alias spysource="echo todo"
alias suntar="tar -xvf"
alias ff="fastfetch"
alias cl="clear"
alias sesp=". $HOME/esp/esp-idf/export.sh"
alias sgba="source /etc/profile.d/devkit-env.sh"
alias mgba="mgba-qt"
function np(){
	command nohup $@ > /dev/null 2>&1 &
}
function localai(){
    local SD_PATH="/run/media/yhaksnes/EB0D-77A1/models"
    export OLLAMA_MODELS="$SD_PATH"

    if pgrep -x "ollama" > /dev/null; then
        ollama run deepseek-r1:1.5b
    else
        
        ollama serve > /dev/null 2>&1 &
        local SERVER_PID=$! 
		trap "kill $SERVER_PID 2>/dev/null" EXIT

        while ! curl -s localhost:11434 > /dev/null; do   
          sleep 1
        done

        ollama run deepseek-r1:1.5b

        kill $SERVER_PID
        trap - EXIT 
    fi
}

function ctouch() {
  for file in "$@"; do
    touch "${file}.h" "${file}.c"
  done
}
function crun(){
    gcc "${1%.*}" -o $1 && ./"${1%.*}"
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
alias push="git push"
alias schange="sadd && scom"


function spdf() {
    pandoc "$1" -o "${1%.*}.pdf" -V geometry="margin=2cm"
}
function srun {
	mkdir -p .tmp
	gcc -o .tmp/program $1 && \
		./.tmp/program
	rm -rf .tmp/
}

short_pwd() {
  echo ${PWD/#\/home\/yhaksnes/home}
}

function note() {
    local BASE_DIR="$HOME/me"
    
    local YEAR=$(date +%Y)
    local MONTH=$(date +%m)
    local DAY=$(date +%Y-%m-%d)
    local TIME=$(date +%H%M)
    
    local TARGET_DIR="$BASE_DIR/$YEAR/$MONTH"
    mkdir -p "$TARGET_DIR"
    
    if [ -z "$1" ]; then
        local FILENAME="${DAY}_${TIME}.md"
    else
        local SLUG=$(echo "$*" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
        local FILENAME="${DAY}-${SLUG}.md"
    fi
    
    nvim + "$TARGET_DIR/$FILENAME"
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
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC
export PATH="$HOME/scripts:$PATH"

source "$HOME/.cargo/env"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

