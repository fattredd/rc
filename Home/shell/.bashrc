#
# Aliases
#

for config in ~/.shell/*.gen; do
  source $config
done

for config in ~/.shell/*.bash; do
  source $config
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
