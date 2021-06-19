export AWS_HOME=~/.aws

function agp {
  echo $AWS_DEFAULT_PROFILE
}

function asp {
  local rprompt=${RPROMPT/<aws:$(agp)>/}

  export AWS_DEFAULT_PROFILE=$1
  export AWS_PROFILE=$1
}


# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="cupcake"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_OSH_DAYS=15

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
  aws
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
  kubernetes
  git
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  aws
  bashmarks
  git
)

source $OSH/oh-my-bash.sh

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#   ---------------------------------------------------------------------------------------------------
#   ---------------------------------------
#   2. Set Paths
#   ---------------------------------------------------------------------------------------------------
# Execute environment
source /etc/environment
# Scripts personal
export PATH="$HOME/bin:$PATH"

# aws cli
export PATH="$HOME/.local/bin/:$PATH"

#   ---------------------------------------------------------------------------------------------------
#   -----------------------------
#   3.  MAKE TERMINAL BETTER
#   -----------------------------
#   ---------------------------------------------------------------------------------------------------

#alias ls='ls --color=always'           # ls color
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias edit='code'                           # edit:         Opens any file in sublime editor
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias show_options='shopt'                  # Show_options: display bash options settings
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

#   Set Default Editor (change 'Vim' to the editor of your choice)
#   ------------------------------------------------------------
export EDITOR=/usr/bin/vim

#   ---------------------------------------------------------------------------------------------------
#   -------------------------------
#   4.  FILE AND FOLDER MANAGEMENT
#   -------------------------------
#   ---------------------------------------------------------------------------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
                        *.tar.xz)        tar -vxJf $1   ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   ---------------------------------------------------------------------------------------------------
#   ---------------------------
#   5.  NETWORKING
#   ---------------------------
#   ---------------------------------------------------------------------------------------------------

alias myip='curl http://checkip.amazonaws.com'      # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/bin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/bin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/bin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections


#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
            echo -e "\nYou are logged on ${RED}$HOST"
            echo -e "\nAdditionnal information:$NC " ; uname -a
            echo -e "\n${RED}Users logged on:$NC " ; w -h
            echo -e "\n${RED}Current date :$NC " ; date
            echo -e "\n${RED}Machine stats :$NC " ; uptime
            echo -e "\n${RED}Public facing IP Address :$NC " ;myip
            echo
            }

#   ---------------------------------------------------------------------------------------------------
#   ---------------------------------------
#   6. WEB DEVELOPMENT
#   ---------------------------------------
#   ---------------------------------------------------------------------------------------------------

alias nginxEdit='sudo edit /etc/nginx/nginx.conf'
alias NginxRestart='sudo nginx -t && sudo service nginx restart'
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/nginx/error.log'              # herr:             Tails HTTP error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page
#   ---------------------------------------------------------------------------------------------------

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
