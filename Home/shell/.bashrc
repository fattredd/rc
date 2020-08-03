#
# Aliases
#

for config in ~/.shell/*.gen; do
  source $config
done

for config in ~/.shell/*.bash; do
  source $config
done

eval "$(thefuck --alias)"
