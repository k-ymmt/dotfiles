function gr() {
  ghq list | fzf --select-1 --exit-0 | read repo_name

  if [ ! $repo_name ];then
    return
  fi

  cd "$(ghq root)/$repo_name"
}
