dir="$HOME/.config/zsh"

for script in $(find $dir -name "*.zsh");do
  if [[ "$script" != "$0" ]];then
    source $script
  fi
done

