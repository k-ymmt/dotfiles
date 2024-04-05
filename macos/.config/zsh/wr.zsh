function wr() {
  paths=$(git worktree list | cut -d ' ' -f 1)
  echo "$paths" | fzf --exit-0 | read selected

  if [ ! $selected ];then
    return
  fi

  cd "$(echo $paths | grep -E "$selected$")"
}
