
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
#export PATH=$PATH:/home/ash/.bin/gcc-arm-none-eabi-5_4-2016q2/bin

alias rcp='rsync -av -P'
alias rmv='rsync -av -P --remove-source-files'
alias rcl='find . -type d -empty -delete'

export _PS1='> '
export PS1='\[\033[38;5;160m\]\u\
\[\033[38;5;124m\]@\
\[\033[38;5;244m\]\h \
\[\033[38;5;124m\]\w \n\
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