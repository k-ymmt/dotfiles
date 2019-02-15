
function fish_prompt
  echo \n
  set p (test (string length (pwd)) -le (math $COLUMNS - 10) && pwd || prompt_pwd)

  echo (set_color white)(logname)':'(set_color yellow)"$p"
  echo (set_color blue)'>'(set_color green)
end
