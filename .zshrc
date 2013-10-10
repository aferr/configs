#!/bin/zsh

export EDITOR="vim"

## {Oh-my-zsh} ##
ZSH=/usr/share/oh-my-zsh
ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"
pligins=(git)
source $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=9999
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/andrew/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#Prompt
#. /usr/share/zsh/site-contrib/powerline.zsh
#autoload -U promptinit
#promptinit


#Use a menu for tab completion
zstyle ':completion:*' menu select

# Use LS_COLORS for ls.
#colors for ls
if [[ -f ~/.dir_colors ]] ; then
    eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
fi

#Use tab completion with aliases
setopt completealiases

## Keybindings ##
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n ${key[Backspace]} ]]  && bindkey  "${key[Backspace]}" backward-delete-char
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"    overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"      backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
}
function zle-line-finish () {
printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

##Path Environment Variables
path+=$HOME/.gem/ruby/2.0.0/bin
export CLASSPATH=".:/usr/local/lib/antlr-4.1-complete.jar:$CLASSPATH"
export SOURCEPATH="/home/andrew/Documents/COURSES/CS5120/CS5120_PA3/,/home/andrew/Documents/COURSES/CS5120/CS5120_PA3/AST/"
export G5DRAM=/home/andrew/Documents/Research/GEM5_DRAMSim2
export GDR=/home/andrew/Documents/Research/g5d2_results
export COURSES=/home/andrew/Documents/Courses
export PROGASGN=$COURSES/CS5120/ProgAssgn

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
alias vi='vim'
alias top='htop'

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
#alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# yaourt aliases (if applicable, replace 'yaourt' with your favorite AUR helper)
alias pac="yaourt -S"      # default action     - install one or more packages
alias pacu="yaourt -Syua"   # '[u]pdate'         - upgrade all packages to their newest version
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
alias addlmon="xrandr --output DP1 --auto --left-of LVDS1 && wallpaper_once"
alias dp1="xrandr --output DP1 --auto"
alias dp1off="xrandr --output DP1 --off && feh --bg-scale .background"

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

#starcluster
alias fixshell="starcluster put imagehost /lib/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite"

#antlr
alias antlr4='java -jar /usr/local/lib/antlr-4.1-complete.jar'
alias grun='java org.antlr.v4.runtime.misc.TestRig'
