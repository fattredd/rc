#
# Auto complete
#

fpath=($HOME/.zsh/completion $fpath)
autoload -Uz compinit
compinit -u
autoload -U ~/.zsh/completion/*(:t)
