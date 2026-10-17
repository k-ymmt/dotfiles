#!/usr/bin/env bash
# Set up a new Mac from this repository.
#
#   curl -fsSL https://raw.githubusercontent.com/k-ymmt/dotfiles/master/macos/setup.sh | bash
#
# Extra arguments are passed to `mise bootstrap`, for example:
#   curl -fsSL .../macos/setup.sh | bash -s -- --force-dotfiles
#   curl -fsSL .../macos/setup.sh | bash -s -- --dry-run
#
# Every step is skipped when already done, so re-running after a failure is safe.
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/k-ymmt/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Projects/dotfiles}"

# stdin is the pipe from curl; reattach it to the terminal so that sudo
# (first creation of /opt/homebrew) and any interactive prompt still work.
if [ ! -t 0 ] && ( : </dev/tty ) 2>/dev/null; then
  exec </dev/tty
fi

if [ "$(uname -s)" != "Darwin" ]; then
  echo "setup.sh: macOS only" >&2
  exit 1
fi

# 1. Xcode Command Line Tools: git for the clone, clang for source builds.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools (a dialog will open)"
  xcode-select --install
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

# 2. mise, into ~/.local/bin.
if ! command -v mise >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/mise" ]; then
  echo "==> Installing mise"
  curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# 3. This repository.
if [ ! -d "$DOTFILES_DIR/.git" ]; then
  echo "==> Cloning $REPO_URL into $DOTFILES_DIR"
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# 4. Everything else is declared in mise.toml.
cd "$DOTFILES_DIR/macos"
mise trust
echo "==> mise bootstrap"
mise bootstrap -y "$@"

echo
echo "Done. Open a new shell (or run: exec zsh), then run: gh auth login"
