#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##PS1
#PS1='[\u@\h \W]\$ '
#PS1='[\h $(date +%_I:%M:%S) \W]\$ '

export EDITOR="vim"

##Aliases
# modified commands
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias ..='cd ..'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet --inet6'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo poweroff'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg2'
fi

# ls
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'

# safety features
alias cp='cp'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# yaourt aliases (if applicable, replace 'yaourt' with your favorite AUR helper)
alias pac="yaourt -S"      # default action     - install one or more packages
alias pacu="yaourt -Syua --noconfirm"   # '[u]pdate'         - upgrade all packages to their newest version
alias pacs="yaourt -Ss"    # '[s]earch'         - search for a package using one or more keywords
alias paci="yaourt -Si"    # '[i]nfo'           - show information about a package
alias pacr="yaourt -Rs"     # '[r]emove'         - uninstall one or more packages
alias pacl="yaourt -Sl"    # '[l]ist'           - list all packages of a repository
alias pacll="yaourt -Qqm"  # '[l]ist [l]ocal'   - list all packages which were locally installed (e.g. AUR packages)
alias paclo="yaourt -Qdt"  # '[l]ist [o]rphans' - list all packages which are orphaned
alias paco="yaourt -Qo"    # '[o]wner'          - determine which package owns a given file
alias pacf="yaourt -Ql"    # '[f]iles'          - list all files installed by a given package
alias pacc="yaourt -Sc"    # '[c]lean cache'    - delete all not currently installed package files
alias pacm="makepkg -fci"  # '[m]ake'           - make package from PKGBUILD file in current directory

#Monitor Shenanigans
alias addrmonr="xrandr --output DP1 --auto --rotate left --right-of LVDS1"
alias addrmon="xrandr --output DP1 --auto --right-of LVDS1"
alias addlmon="xrandr --output DP1 --auto --left-of LVDS1"

#ssh/sftp
alias gohome="ssh -X andrew@aferr.mooo.com"
alias fohome="sftp andrew@aferr.mooo.com"
alias raspi="ssh -p 5432 andrew@aferr.mooo.com"

alias amdpool="ssh -X af433@amdpool-02.ece.cornell.edu"
alias vlsi="ssh -X andrew@vlsi.csl.cornell.edu"
alias hana="ssh -X andrew@hana.csl.cornell.edu"
alias fana="sftp andrew@hana.csl.cornell.edu"
alias lilac="ssh -X andrew@lilac.csl.cornell.edu"
alias filac="sftp andrew@lilac.csl.cornell.edu"
alias cluster="ssh -X andrew@cluster.csl.cornell.edu"
alias fluster="sftp andrew@cluster.csl.cornell.edu"
alias tcluster="ssh -X andrew@ubuntu-test.csl.cornell.edu"
alias fcluster="sftp andrew@ubuntu-test.csl.cornell.edu"

alias nimbus="ssh -i /home/andrew/.ec2keys/nimbuskey.pem ubuntu@ec2-50-17-12-184.compute-1.amazonaws.com"

alias dp1="xrandr --output DP1 --auto"
alias dp1off="xrandr --output DP1 --off"

