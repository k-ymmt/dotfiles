function gr
  ghq list | fzf --select-1 --exit-0 | read repo_name

  ghq look $repo_name
end
