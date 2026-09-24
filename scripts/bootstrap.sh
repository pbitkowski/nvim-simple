#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_dir="$(cd -- "${script_dir}/.." && pwd -P)"
config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}"
target_dir="${config_dir}/nvim"

for required_command in git brew; do
  if ! command -v "${required_command}" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "${required_command}" >&2
    printf 'Install it, then run this script again.\n' >&2
    exit 1
  fi
done

if [[ "$(uname -s)" == "Darwin" ]] && ! xcode-select -p >/dev/null 2>&1; then
  printf 'The macOS Command Line Tools are required.\n' >&2
  printf 'Run: xcode-select --install\n' >&2
  exit 1
fi

printf 'Installing command-line dependencies from Brewfile...\n'
brew bundle --file="${repo_dir}/Brewfile"

if ! command -v mmdc >/dev/null 2>&1; then
  printf 'Installing Mermaid CLI and its headless browser for terminal diagrams...\n'
  npm install -g @mermaid-js/mermaid-cli@11.17.0
fi

for build_command in make cc; do
  if ! command -v "${build_command}" >/dev/null 2>&1; then
    printf 'Missing build command: %s\n' "${build_command}" >&2
    printf 'Install your system build tools, then run this script again.\n' >&2
    exit 1
  fi
done

if [[ -e "${target_dir}" || -L "${target_dir}" ]]; then
  target_real="$(cd -- "${target_dir}" 2>/dev/null && pwd -P || true)"
  if [[ "${target_real}" != "${repo_dir}" ]]; then
    printf 'Refusing to replace the existing Neovim config at %s\n' "${target_dir}" >&2
    exit 1
  fi
else
  mkdir -p -- "${config_dir}"
  ln -s -- "${repo_dir}" "${target_dir}"
  printf 'Linked %s -> %s\n' "${target_dir}" "${repo_dir}"
fi

printf 'Installing Neovim plugins...\n'
nvim --headless '+qa!'

printf 'Installing language servers and formatters...\n'
nvim --headless '+MasonToolsInstallSync' '+qa!'

printf '\nNeovim is ready. Start it with: nvim\n'
