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
