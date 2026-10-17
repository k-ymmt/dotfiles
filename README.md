# my-env

## macOS

Machine setup is declared in [`macos/mise.toml`](macos/mise.toml) and applied with
[`mise bootstrap`](https://mise.jdx.dev/bootstrap.html): Homebrew packages,
dotfile symlinks, Vim plugins, macOS defaults. Global tools live in
[`macos/.config/mise/config.toml`](macos/.config/mise/config.toml) and are
installed in the same run.

### New machine

```sh
curl -fsSL https://raw.githubusercontent.com/k-ymmt/dotfiles/master/macos/setup.sh | bash
```

[`macos/setup.sh`](macos/setup.sh) installs the Xcode Command Line Tools and
mise, clones this repository into `~/Projects/dotfiles`, then runs
`mise bootstrap`. Homebrew is not needed; mise installs formulae itself.
Every step is skipped when already done, so re-run the same line after a
failure.

Extra arguments go to `mise bootstrap`:

```sh
curl -fsSL https://raw.githubusercontent.com/k-ymmt/dotfiles/master/macos/setup.sh | bash -s -- --dry-run
curl -fsSL https://raw.githubusercontent.com/k-ymmt/dotfiles/master/macos/setup.sh | bash -s -- --force-dotfiles
```

Use `--force-dotfiles` when `$HOME` already has real files where symlinks
should go (for example `~/.zshrc`).

Afterwards open a new shell (`.zshrc` adds `/opt/homebrew/bin` and
`~/.local/bin` to `PATH` and activates mise) and run `gh auth login`, which
the git credential helper in `.gitconfig` relies on.

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
