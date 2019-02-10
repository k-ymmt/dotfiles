function gh
  ghq list | fzf --select-1 --exit-0 | read repo_name

  if [ ! $repo_name ]
    return 
  end

  open "https://$repo_name"
end
