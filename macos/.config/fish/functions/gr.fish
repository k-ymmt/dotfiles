function gr
  ghq list | fzf --select-1 --exit-0 | read repo_name

  if [ ! $repo_name ]
    return
  end

  cd (ghq root)/$repo_name
end
