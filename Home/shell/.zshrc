# Lines configured by zsh-newuser-install
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=1000
#PROMPT="%"
#RPROMPT="~%"
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


export WINEARCH=win32
# Add nano as default editor
export EDITOR=nano
export TERMINAL=lxterminal
export BROWSER=firefox
# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

alias ls='ls --color=auto'
alias music='ncmpcpp'
alias irc='irssi -c irc.synirc.net -n fattredd'
alias untar='tar -xvf'
alias sf='screenfetch'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias au='alsamixer'
alias alsa='alsamixer'
alias now='figlet Current time: $(date +"%T")'
alias pipe='sh ~/pipes'
alias clock='sh ~/clock'
alias pdf='mupdf'
alias pip='sudo pip'
alias pipupdate="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"


alias zshhelp='firefox http://bolyai.cs.elte.hu/zsh-manual/zsh_toc.html'
alias liv='livestreamer'
alias twpp='livestreamer http://www.twitch.tv/twitchplayspokemon medium'
alias twl='livestreamer http://www.twitch.tv/imaqtpie medium'
alias twcosmo='livestreamer http://www.twitch.tv/cosmos1004 medium'
alias ytv='livestreamer https://www.youtube.com/watch?v='
alias nm='nm-applet'
alias t='tint2'

alias wine32='env WINEARCH=win32 WINEPREFIX="$HOME/.wine32" wine'
alias resteam='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias sublime='/home/ash/opt/sublime-text/sublime_text'
alias reurx='xrdb ~/.Xresources'

partyStutter='livestreamer 
https://www.youtube.com/watch?v=JAIOzM7SsMo worst'
partyHey='livestreamer https://www.youtube.com/watch?v=ZZ5LpwO-An4 worst'
