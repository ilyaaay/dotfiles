[no-cd]
[macos]
update: brew rust node cargo
  @echo "All dependencies have been updated."

[no-cd]
[linux]
update: rust node cargo
  @echo "All dependencies have been updated."

[no-cd]
[private]
[macos]
brew:
  brew update
  brew upgrade --formula
  brew upgrade --cask
  brew autoremove
  brew cleanup --prune=all

[no-cd]
[private]
rust:
  rustup self update
  rustup update

[no-cd]
[private]
node:
  fnm install --lts
  npm install -g npm@latest
  npm update -g

[no-cd]
[private]
cargo:
  cargo install-update --all

[no-cd]
[macos]
os:
  softwareupdate -l

[no-cd]
default:
  @just --justfile {{justfile()}} --list
