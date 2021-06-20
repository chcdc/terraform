#==============================

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
cpv() {
    rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
}



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
