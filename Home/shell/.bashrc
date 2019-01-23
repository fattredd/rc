
export WINEARCH=win32
export EDITOR="emacsclient -nw"
export TERMINAL=lxterminal
if [ -z "$SSH_CLIENT" ]; then
    export BROWSER=firefox;
else
    export BROWSER=lynx;
fi
# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

alias ixio='curl -F "f:1=<-" ix.io'
alias irc='irssi -c irc.synirc.net -n fattredd'
alias sf='screenfetch'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias now='figlet Current time: $(date +"%T")'
alias pipe='sh pipes'
alias untar='tar -xvf'
alias pdf='mupdf'
alias pip='sudo pip'
alias ls='ls --color=auto'

alias liv='livestreamer'

alias wine32='env WINEARCH=win32 WINEPREFIX="$HOME/.wine32" wine'
alias resteam='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias sublime='sudo /opt/sublime_text/sublime_text'

alias pingReport="ping -i 30 -a"
alias clockAdd="while sleep 1; do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &"
alias topProc="ps aux | sort -nk +4 | tail"
alias ldisk="sudo lsblk -o name,mountpoint,label,size,uuid,type"
alias df='df -h' 

alias rcp='rsync -av -P'
alias rmv='rsync -av -P --remove-source-files'
alias rcl='find . -type d -empty -delete'
alias stow='stow -v -t ~'
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

export _PS1='> '

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
export PS1='\[\033[38;5;155m\]\u\
\[\033[38;5;244m\]@\
\[\033[38;5;159m\]\h \
\[\033[38;5;49m\]\w \n\
\[\033[38;5;16m\]#\
\[\033[38;5;17m\]#\
\[\033[38;5;18m\]#\
\[\033[38;5;19m\]#\
\[\033[38;5;20m\]#\
\[\033[38;5;21m\]#\
\[\033[38;5;21m\]#\
\[\033[38;5;20m\]#\
\[\033[38;5;19m\]#\
\[\033[38;5;18m\]#\
\[\033[38;5;17m\]#\
\[\033[38;5;16m\]# \
\[\033[38;5;226m\]\$ \
\[\033[00m\]'
