# Neovim config

A small personal Neovim setup based on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It stays close to
stock Neovim while adding the things I use every day:

- Telescope search with the native fzf sorter
- Oil for editing directories like normal buffers
- Gitsigns and Neogit for Git workflows
- LSP support for Python (`ty`), TypeScript/JavaScript, Astro, and Lua
- Completion, Treesitter highlighting, diagnostics, and formatting
- Markdown preview inside the terminal through md-render.nvim, including Mermaid diagrams
- Optional CursorTab predictions, loaded only when a Mercury API token exists

The leader key is `Space`.

## Install

This configuration targets Neovim 0.12 or newer on macOS and Linux. The
bootstrap script uses Homebrew (also available on Linux) to install the command
line dependencies without touching an existing Neovim configuration.

```sh
git clone https://github.com/pbitkowski/nvim-simple.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
"${XDG_CONFIG_HOME:-$HOME/.config}/nvim/scripts/bootstrap.sh"
```

If you clone the repository elsewhere, run `scripts/bootstrap.sh` there. It
will create `~/.config/nvim` as a symlink, but only if that path is unused. The
script never replaces an existing configuration.

On macOS, install the Command Line Tools first if needed:

```sh
xcode-select --install
```

Homebrew itself must already be installed. The script then installs the
packages in `Brewfile`, starts Neovim once to fetch plugins, and installs the
configured Mason tools. It also installs Mermaid CLI (`mmdc`) through npm,
including the headless Chromium used to render diagrams locally.

## Markdown preview

Press `Space m p` in a Markdown buffer (or on a file in Oil) to toggle the
terminal preview. Press `q` or `Esc` to close it. Use `:vert MdRender split`
for a live preview beside the source, or `:MdRender demo` to explore rendering.

[md-render.nvim](https://github.com/delphinus/md-render.nvim) renders Mermaid
diagrams as images using [Mermaid CLI](https://github.com/mermaid-js/mermaid-cli).
Use Ghostty, Kitty, or WezTerm for diagrams; other terminals can display the
Markdown text but need graphics support for diagram images. With tmux, enable
`set -g allow-passthrough on`. No browser window opens, but Mermaid CLI runs
headless Chromium locally. Markview alone does not render Mermaid diagrams.

For an existing installation, install the renderer once and restart Neovim:

```sh
npm install -g @mermaid-js/mermaid-cli@11.17.0
```

For a standalone terminal reader using this config:

```sh
nvim +'MdRender pager' README.md
```

## Private configuration

CursorTab is optional. Put the Mercury token in your shell environment, never
in this repository:

```sh
export MERCURY_API_TOKEN='your-token-here'
```

Restart Neovim and press `Space t c` to initialize or toggle CursorTab. Accept
a suggestion with `Ctrl-l`. When the variable is absent, the plugin is not
loaded and the rest of the config works normally.

## Useful keys

| Key | Action |
| --- | --- |
| `Space s f` | Find files |
| `Space s g` | Search file contents |
| `Space Space` | Switch buffers |
| `Space e` | Open Oil in the current directory |
| `Space E` | Open Oil at the project root |
| `Space g g` | Open Neogit |
| `Space m p` | Toggle Markdown preview |
| `Space t c` | Toggle CursorTab, when configured |
| `g r d` | Go to definition |
| `g r r` | Find references |
| `g r i` | Find implementations |
| `g r t` | Go to type definition |
| `g r n` | Rename symbol |
| `g r a` | Code action |
| `] c` / `[ c` | Next / previous Git change |
| `Space h p` | Preview Git hunk |
| `Space h s` | Stage Git hunk |

Press `Space s k` to search all keymaps. In Oil, use `Enter` to open an entry,
`-` to move to the parent directory, and `g?` for its complete help.

## Maintenance

- `:Mason` shows installed language tools.
- `:LspInfo` shows language servers attached to the current buffer.
- `:checkhealth` diagnoses the editor and plugins.
- `:lua vim.pack.update()` updates plugins interactively. Commit the resulting
  `nvim-pack-lock.json` when accepting an update.

Lua formatting is checked by GitHub Actions. The bootstrap script can be run
again safely whenever `Brewfile` or the configured Mason tools change.

## Credits

Built from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and
distributed under the [MIT License](LICENSE.md).
