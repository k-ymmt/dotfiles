function gh
 ghq list | fzf --select-1 --exit-0 | read repo_name

 open "https://$repo_name"
end
