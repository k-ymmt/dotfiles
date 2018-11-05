function switch_karabiner
  set path ~/.config/karabiner

  set general_path $path/backup/general/karabiner.json
  set realforce_path $path/backup/realforce/karabiner.json

  if [ -f $general_path ]
    mv $path/karabiner.json $realforce_path
    mv $general_path $path/karabiner.json
  else
    mv $path/karabiner.json $general_path
    mv $realforce_path $path/karabiner.json
  end
end
