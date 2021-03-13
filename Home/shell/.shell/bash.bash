[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# fzf must come after this line, it appears to remove the cd completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash && complete -o nospace -o plusdirs -F _fzf_dir_completion cd

[ -f ~/.local/bin/thefuck ] && eval "$(thefuck --alias)"

if shopt -q login_shell; then
	echo Sourced
fi
