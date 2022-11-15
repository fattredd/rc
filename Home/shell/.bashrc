#
# Aliases
#

# do nothing if not interactively running
[[ $- == *i*  ]] || return

for config in ~/.shell/*.gen; do
  source $config
done

for config in ~/.shell/*.bash; do
  source $config
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
