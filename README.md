# my-env

## macOS

Machine setup is declared in [`macos/mise.toml`](macos/mise.toml) and applied with
[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): Homebrew packages,
dotfile symlinks, Vim plugins, macOS defaults. Global tools live in
[`macos/.config/mise/config.toml`](macos/.config/mise/config.toml) and are
installed in the same run.

### New machine

1. Install mise (Homebrew is not needed; mise installs formulae itself).

   ```sh
   curl https://mise.run | sh
   export PATH="$HOME/.local/bin:$PATH"
   ```

2. Clone this repository and preview the run.

   ```sh
   git clone https://github.com/k-ymmt/dotfiles ~/Projects/dotfiles
   cd ~/Projects/dotfiles/macos
   mise trust
   mise bootstrap --dry-run
   ```

3. Apply.

   ```sh
   mise bootstrap
   ```

   If `$HOME` already has real files where symlinks should go (for example
   `~/.zshrc`), add `--force-dotfiles` to replace them.

4. Open a new shell. `.zshrc` adds `/opt/homebrew/bin` and `~/.local/bin` to
   `PATH` and activates mise.

### Day to day

Run from `macos/` (or with `mise -C ~/Projects/dotfiles/macos ...`):

```sh
mise bootstrap status        # what differs from the config
mise bootstrap plan          # resource-level changes
mise bootstrap               # re-apply; unchanged parts are skipped
mise bootstrap --only dotfiles
mise bootstrap packages import --dry-run   # formulae installed by hand but not declared
```

Notes:

- `--dry-run`, `status` and `plan` need a Ruby 3 to evaluate the
  `FelixKratz/formulae` tap formulae (the tap publishes no API metadata).
  `mise bootstrap` installs one itself; for the read-only commands, prefix
  them: `mise x ruby@latest -- mise bootstrap --dry-run`.
- `Cmd+M` (Minimize) is disabled with a plain `defaults write` in
  `[tasks.bootstrap]`: the stored value is a NUL character, which mise's
  `[bootstrap.macos.defaults]` cannot serialize.
- Vim plugins are cloned under `macos/.vim/pack/dev/start/` (gitignored), so
  `~/.vim` stays a symlink into this repository.
- `~/.config` is linked as a whole directory, so files that apps write under
  `~/.config` show up as untracked files here.
- `killall SystemUIServer` and the `defaults write` lines in `[tasks.bootstrap]`
  run every time; they are idempotent.
