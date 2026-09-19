--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  vim.o.relativenumber = true

  -- High-contrast, compact UI chrome without changing editing behavior.
  vim.o.winborder = 'rounded'
  vim.o.laststatus = 3
  vim.o.pumblend = 6
  vim.o.smoothscroll = true
  vim.o.cursorlineopt = 'number,line'
  vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    foldopen = '',
    foldclose = '',
    foldsep = ' ',
    diff = '╱',
  }

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰍚 ',
        [vim.diagnostic.severity.WARN] = '󰱬 ',
        [vim.diagnostic.severity.INFO] = '󰜋 ',
        [vim.diagnostic.severity.HINT] = '󰍌 ',
      },
    },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- Fast buffer navigation that matches Neovim's other bracket motions.
  vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Previous [B]uffer' })
  vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next [B]uffer' })
  vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite buffer' })
  vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0, false) end, { desc = '[B]uffer [D]elete' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'peek.nvim' and vim.fn.executable 'deno' == 1 then
        run_build(name, { 'deno', 'task', '--quiet', 'build:fast' }, ev.data.path)
        return
      end

      if name == 'cursortab.nvim' then
        if vim.fn.executable 'go' == 1 then
          run_build(name, { 'go', 'build' }, vim.fs.joinpath(ev.data.path, 'server'))
        else
          vim.notify('CursorTab needs Go 1.25 or newer to build.', vim.log.levels.ERROR)
        end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

--- Because most plugins are hosted on GitHub, you can use the helper
--- function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  local gitsigns = require 'gitsigns'
  gitsigns.setup {
    signs = {
      add = { text = '▎' }, ---@diagnostic disable-line: missing-fields
      change = { text = '▎' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '▎' }, ---@diagnostic disable-line: missing-fields
      untracked = { text = '┆' }, ---@diagnostic disable-line: missing-fields
    },
    -- gitsigns.nvim's recommended keymaps:
    on_attach = function(bufnr)
      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange', buf = bufnr })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

      -- Visual mode actions
      vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk', buf = bufnr })
      -- Normal mode actions
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline', buf = bufnr })
      vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index', buf = bufnr })
      vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'git [D]iff against last commit', buf = bufnr })
      vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)', buf = bufnr })
      vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)', buf = bufnr })
      -- Toggles
      vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff', buf = bufnr })
      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
    end,
  }

  -- Repository-level Git UI for staging, committing, branching, and pushing.
  vim.pack.add { gh 'NeogitOrg/neogit' }
  require('neogit').setup {}
  vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = '[G]it status (Neogit)' })
  vim.keymap.set('n', '<leader>gl', '<cmd>NeogitLogCurrent<CR>', { desc = '[G]it [L]og current file' })
  vim.keymap.set('n', '<leader>gL', function() require('neogit').action('log', 'log_current')() end, { desc = '[G]it [L]og current branch' })

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>g', group = '[G]it' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'scottmckendry/cyberdream.nvim' }
  require('cyberdream').setup {
    variant = 'default',
    transparent = true,
    saturation = 1,
    italic_comments = true,
    hide_fillchars = false,
    borderless_pickers = false,
    terminal_colors = true,
    colors = {
      bg = '#07090d',
      bg_alt = '#0d1117',
      bg_highlight = '#202734',
      green = '#00ff9c',
      cyan = '#00eaff',
      magenta = '#ff2bd6',
    },
    overrides = function(colors)
      return {
        CursorLineNr = { fg = colors.green, bold = true },
        WinSeparator = { fg = colors.green },
        FloatBorder = { fg = colors.cyan, bg = 'NONE' },
        Visual = { bg = colors.bg_highlight },
        Search = { fg = colors.bg, bg = colors.green, bold = true },
        IncSearch = { fg = colors.bg, bg = colors.orange, bold = true },
        MiniIndentscopeSymbol = { fg = colors.green },
        MiniTablineCurrent = { fg = colors.bg, bg = colors.green, bold = true },
        MiniTablineVisible = { fg = colors.cyan, bg = colors.bg_highlight },
        MiniTablineHidden = { fg = colors.grey, bg = colors.bg_alt },
        MiniTablineModifiedCurrent = { fg = colors.bg, bg = colors.orange, bold = true },
        MiniTablineModifiedVisible = { fg = colors.orange, bg = colors.bg_highlight },
        MiniTablineModifiedHidden = { fg = colors.orange, bg = colors.bg_alt },
        MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.green, bold = true },
        MiniStarterHeader = { fg = colors.green, bold = true },
        MiniStarterSection = { fg = colors.cyan, bold = true },
        MiniStarterCurrent = { fg = colors.bg, bg = colors.green, bold = true },
      }
    end,
  }

  -- Load the colorscheme here.
  vim.cmd.colorscheme 'cyberdream'

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- Render color literals as their actual color instead of plain text.
  vim.pack.add { gh 'brenoprata10/nvim-highlight-colors' }
  local highlight_colors = require 'nvim-highlight-colors'
  highlight_colors.setup {
    render = 'background',
    enable_named_colors = false,
    enable_ansi = false,
    enable_xterm256 = false,
    enable_xtermTrueColor = false,
    exclude_filetypes = { 'help', 'oil', 'TelescopePrompt', 'NeogitStatus' },
    exclude_buftypes = { 'nofile', 'prompt', 'terminal' },
    exclude_buffer = function(bufnr)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      return filename ~= '' and vim.fn.getfsize(filename) > 1024 * 1024
    end,
  }
  vim.keymap.set('n', '<leader>tC', highlight_colors.toggle, { desc = '[T]oggle [C]olor previews' })

  -- Display real images through Ghostty's Kitty graphics protocol.
  vim.pack.add { gh 'folke/snacks.nvim' }
  local snacks = require 'snacks'
  snacks.setup {
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 60,
        max_height = 30,
      },
      -- Keep this focused on images; math rendering needs extra TeX/Typst tools.
      math = { enabled = false },
    },
  }
  vim.keymap.set('n', '<leader>ip', snacks.image.hover, { desc = '[I]mage [P]review under cursor' })

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- Icon-aware buffers across the top and a neon guide for the active scope.
  require('mini.tabline').setup {
    show_icons = true,
    tabpage_section = 'right',
  }

  require('mini.indentscope').setup {
    symbol = '▏',
    options = { try_as_border = true },
  }

  local starter = require 'mini.starter'
  starter.setup {
    header = [=[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]=],
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(5, true),
      starter.sections.recent_files(5, false),
    },
    footer = '<leader>sk  keymaps',
  }

  -- Persist one session per Git worktree. The absolute worktree path is part
  -- of the name, so a feature branch, bugfix, and PR review never collide.
  vim.opt.sessionoptions = { 'buffers', 'curdir', 'folds', 'localoptions', 'tabpages', 'winsize', 'winpos' }

  local sessions = require 'mini.sessions'
  sessions.setup {
    autoread = false,
    autowrite = false,
    verbose = { read = false, write = false, delete = true },
  }

  local function worktree_session()
    local cwd = assert(vim.uv.cwd())
    local root = vim.fs.root(cwd, '.git')
    if not root then return nil, nil end

    local project = vim.fs.basename(root):gsub('[^%w%._-]', '_')
    local fingerprint = vim.fn.sha256(root):sub(1, 12)
    return ('%s-%s.vim'):format(project, fingerprint), root
  end

  local function started_for_project()
    local args = vim.fn.argv()
    if #args == 0 then return true end

    for _, arg in ipairs(args) do
      local path = vim.fn.fnamemodify(arg, ':p')
      local stat = vim.uv.fs_stat(path)
      if not stat or stat.type ~= 'directory' then return false end
    end

    return true
  end

  vim.api.nvim_create_user_command('ProjectSessionSave', function()
    local name = worktree_session()
    if not name then
      vim.notify('No Git worktree found for the current directory.', vim.log.levels.WARN)
      return
    end
    sessions.write(name, { force = true, verbose = true })
  end, { desc = 'Save the session for this Git worktree' })

  vim.api.nvim_create_user_command('ProjectSessionRestore', function()
    local name = worktree_session()
    if not name or not sessions.detected[name] then
      vim.notify('No saved session exists for this Git worktree.', vim.log.levels.WARN)
      return
    end
    sessions.read(name, { force = false, verbose = true })
  end, { desc = 'Restore the session for this Git worktree' })

  local automatic_session = false
  local session_name, session_root = worktree_session()
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('worktree-session', { clear = true }),
    nested = true,
    callback = function()
      if #vim.api.nvim_list_uis() == 0 or not session_name or not started_for_project() then return end

      automatic_session = true
      if sessions.detected[session_name] then
        sessions.read(session_name, { force = false, verbose = false })
        vim.notify(('Restored session for %s'):format(vim.fs.basename(session_root)))
      end
    end,
  })

  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = 'worktree-session',
    callback = function()
      if automatic_session then sessions.write(session_name, { force = true, verbose = false }) end
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('hacker-ui-disable-indentscope', { clear = true }),
    pattern = { 'help', 'oil', 'TelescopePrompt', 'Trouble', 'lazy', 'mason', 'notify' },
    callback = function() vim.b.miniindentscope_disable = true end,
  })

  -- Edit directories like normal buffers. Changes are only applied on :write.
  vim.pack.add { gh 'stevearc/oil.nvim' }
  local oil = require 'oil'
  oil.setup {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    view_options = {
      show_hidden = false,
      natural_order = 'fast',
    },
  }

  -- Repair a rare Oil preview edge case where a real file buffer keeps the
  -- explorer's `oil` filetype after it is opened in the same window.
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufReadPost', 'BufWinEnter', 'BufFilePost' }, {
    group = vim.api.nvim_create_augroup('kickstart-oil-filetype', { clear = true }),
    callback = function(event)
      local filename = vim.api.nvim_buf_get_name(event.buf)
      if vim.bo[event.buf].buftype ~= '' or vim.bo[event.buf].filetype ~= 'oil' or filename:match '^oil://' then return end

      local detected = vim.filetype.match { buf = event.buf, filename = filename }
      if detected and detected ~= 'oil' then vim.bo[event.buf].filetype = detected end
    end,
  })

  local function current_directory()
    local oil_dir = oil.get_current_dir()
    if oil_dir then return oil_dir end

    local filename = vim.api.nvim_buf_get_name(0)
    if filename ~= '' then return vim.fs.dirname(filename) end

    return assert(vim.uv.cwd())
  end

  vim.keymap.set('n', '<leader>e', function() oil.open(current_directory()) end, { desc = '[E]xplore current directory' })
  vim.keymap.set('n', '<leader>E', function()
    local root = vim.fs.root(current_directory(), '.git') or vim.uv.cwd()
    oil.open(root)
  end, { desc = '[E]xplore project root' })

  -- Live Markdown preview with Mermaid support.
  vim.pack.add { gh 'toppair/peek.nvim' }
  local peek = require 'peek'
  peek.setup {
    auto_load = false,
    close_on_bdelete = true,
    theme = 'dark',
    update_on_change = true,
    app = 'webview',
  }

  vim.keymap.set('n', '<leader>mp', function()
    if peek.is_open() then
      peek.close()
      return
    end

    -- When invoked from Oil, open the Markdown file under the cursor first.
    if vim.bo.filetype == 'oil' then
      local entry = oil.get_cursor_entry()
      local directory = oil.get_current_dir()
      if not entry or entry.type ~= 'file' or not directory then
        vim.notify('Select a Markdown file in Oil before opening its preview.', vim.log.levels.WARN)
        return
      end
      vim.cmd.edit(vim.fn.fnameescape(vim.fs.joinpath(directory, entry.name)))
    end

    if vim.bo.filetype ~= 'markdown' then
      local current = vim.bo.filetype ~= '' and vim.bo.filetype or '<none>'
      vim.notify(('Markdown preview requires a Markdown buffer; current filetype is %s.'):format(current), vim.log.levels.WARN)
      return
    end

    peek.open()
  end, { desc = '[M]arkdown [P]review' })

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string | vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    defaults = {
      -- Fill the screen on wide windows and stack preview/results when space
      -- is tight, which works well on a 13-inch display with a larger font.
      layout_strategy = 'flex',
      sorting_strategy = 'ascending',
      layout_config = {
        width = 0.96,
        height = 0.94,
        flex = {
          flip_columns = 120,
        },
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.62,
          preview_cutoff = 80,
        },
        vertical = {
          prompt_position = 'top',
          preview_height = 0.58,
          preview_cutoff = 20,
          mirror = true,
        },
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', function() builtin.find_files { hidden = true } end, { desc = '[S]earch [F]iles (including dotfiles)' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  -- Inspect definitions in a floating window without leaving the current code.
  vim.pack.add {
    gh 'rmagatti/logger.nvim',
    gh 'rmagatti/goto-preview',
  }
  local goto_preview = require 'goto-preview'
  goto_preview.setup {
    width = 100,
    height = 20,
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    default_mappings = false,
    focus_on_open = true,
    dismiss_on_move = false,
    stack_floating_preview_windows = false,
    preview_window_title = { enable = true, position = 'center' },
  }

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Show documentation without leaving the current position. Press K a
      -- second time to focus the popup so it can be scrolled normally.
      map('K', function() vim.lsp.buf.hover { border = 'rounded', max_width = 88, max_height = 24 } end, '[H]over documentation')

      -- Peek at a definition without replacing the current window.
      map('gpd', goto_preview.goto_preview_definition, '[P]review [D]efinition')
      map('gP', goto_preview.close_all_win, 'Close definition [P]reviews')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- clangd = {},
    gopls = {
      settings = {
        gopls = {
          -- Keep completions ergonomic without enabling the full, heavier
          -- Staticcheck suite. Modern gopls enables a fast curated subset.
          usePlaceholders = true,
          gofumpt = true,
        },
      },
    },
    --
    -- Some languages (like rust) have entire language plugins that can be useful:
    --    https://github.com/mrcjkb/rustaceanvim
    --
    -- But for many setups, the LSP (`rust_analyzer`) will work just fine
    -- rust_analyzer = {},

    ty = {}, -- Python
    ts_ls = {}, -- TypeScript and JavaScript
    astro = { -- Astro components and pages
      before_init = function(_, config)
        -- Prefer the project's TypeScript SDK, then use the one bundled by Mason.
        local typescript = require 'mason-lspconfig.typescript'
        local install_dir = vim.fn.expand '$MASON/packages/astro-language-server'
        config.init_options = config.init_options or {}
        config.init_options.typescript = config.init_options.typescript or {}
        config.init_options.typescript.serverPath = typescript.resolve_tsserver(install_dir, config.root_dir)
        config.init_options.typescript.tsdk = typescript.resolve_tsdk(install_dir, config.root_dir)
      end,
    },

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'goimports',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }

  local function buffer_directory(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    return filename ~= '' and vim.fs.dirname(filename) or assert(vim.uv.cwd())
  end

  local function find_project_file(bufnr, names)
    return vim.fs.find(names, {
      path = buffer_directory(bufnr),
      upward = true,
      stop = vim.uv.os_homedir(),
    })[1]
  end

  local function project_file_contains(bufnr, filename, pattern)
    local path = find_project_file(bufnr, { filename })
    if not path then return false end

    local ok, lines = pcall(vim.fn.readfile, path)
    return ok and table.concat(lines, '\n'):find(pattern) ~= nil
  end

  local function package_has(bufnr, dependency)
    local path = find_project_file(bufnr, { 'package.json' })
    if not path then return false end

    local ok, lines = pcall(vim.fn.readfile, path)
    if not ok then return false end

    local decoded, package = pcall(vim.json.decode, table.concat(lines, '\n'))
    if not decoded or type(package) ~= 'table' then return false end

    for _, field in ipairs { 'dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies' } do
      if type(package[field]) == 'table' and package[field][dependency] then return true end
    end
    return package[dependency] ~= nil
  end

  local prettier_configs = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.json5',
    '.prettierrc.yaml',
    '.prettierrc.yml',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.mjs',
    '.prettierrc.ts',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
    'prettier.config.mjs',
    'prettier.config.ts',
  }

  local function web_formatters(bufnr)
    if find_project_file(bufnr, { 'biome.json', 'biome.jsonc' }) or package_has(bufnr, '@biomejs/biome') then return { 'biome' } end
    if find_project_file(bufnr, { 'deno.json', 'deno.jsonc' }) then return { 'deno_fmt' } end
    if find_project_file(bufnr, prettier_configs) or package_has(bufnr, 'prettier') then return { 'prettierd', 'prettier', stop_after_first = true } end
    return {}
  end

  local function python_formatters(bufnr)
    local ruff_config = find_project_file(bufnr, { 'ruff.toml', '.ruff.toml' })
    if
      project_file_contains(bufnr, 'pyproject.toml', '%[tool%.ruff%.format%]')
      or (ruff_config and project_file_contains(bufnr, vim.fs.basename(ruff_config), '%[format%]'))
    then
      return { 'ruff_format' }
    end
    if project_file_contains(bufnr, 'pyproject.toml', '%[tool%.black') then return { 'black' } end
    if find_project_file(bufnr, { '.style.yapf' }) or project_file_contains(bufnr, 'pyproject.toml', '%[tool%.yapf') then return { 'yapf' } end
    if project_file_contains(bufnr, 'pyproject.toml', '%[tool%.autopep8') then return { 'autopep8' } end
    return {}
  end

  local conform = require 'conform'
  conform.setup {
    notify_on_error = true,
    notify_no_formatters = true,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      astro = web_formatters,
      css = web_formatters,
      graphql = web_formatters,
      html = web_formatters,
      javascript = web_formatters,
      javascriptreact = web_formatters,
      json = web_formatters,
      jsonc = web_formatters,
      less = web_formatters,
      markdown = web_formatters,
      scss = web_formatters,
      svelte = web_formatters,
      typescript = web_formatters,
      typescriptreact = web_formatters,
      vue = web_formatters,
      yaml = web_formatters,
      python = python_formatters,
      lua = { 'stylua' },
      -- goimports applies gofmt and adds/removes/sorts imports.
      go = { 'goimports', 'gofmt', stop_after_first = true },
      rust = { 'rustfmt' },
    },
  }

  vim.api.nvim_create_user_command('Format', function(args)
    local range
    if args.range > 0 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, false)[1] or ''
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, #end_line },
      }
    end

    local formatters, use_lsp = conform.list_formatters_to_run(0)
    local names = vim.tbl_map(function(formatter) return formatter.name end, formatters)
    if use_lsp then table.insert(names, 'LSP') end
    if #names == 0 then
      vim.notify('No project-configured formatter or formatting LSP is available. Run :ConformInfo for details.', vim.log.levels.WARN)
      return
    end

    vim.notify('Formatting with ' .. table.concat(names, ', '))
    conform.format { async = true, bufnr = 0, range = range, lsp_format = 'fallback' }
  end, { desc = 'Format with the project-configured formatter', range = true })

  vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>', { desc = '[F]ormat buffer' })
  vim.keymap.set('x', '<leader>f', ':Format<CR>', { desc = '[F]ormat selection' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }

  -- Cursor-like next-edit predictions through the hosted Mercury API.
  -- Skip the plugin entirely on machines where the token is unavailable.
  if vim.env.MERCURY_API_TOKEN and vim.env.MERCURY_API_TOKEN ~= '' then
    vim.pack.add { gh 'cursortab/cursortab.nvim' }
    vim.keymap.set('n', '<leader>tc', function()
      local cursortab = require 'cursortab'
      if vim.fn.exists ':CursortabToggle' == 0 then
        cursortab.setup {
          enabled = true,
          contribute_data = false,
          keymaps = {
            accept = '<C-l>',
            partial_accept = false,
            trigger = false,
          },
          ui = {
            jump = { text = ' CTRL-L ' },
          },
          behavior = {
            ignore_filetypes = { '', 'terminal', 'oil', 'TelescopePrompt', 'NeogitStatus', 'gitcommit' },
          },
          provider = {
            type = 'mercuryapi',
            api_key_env = 'MERCURY_API_TOKEN',
            privacy_mode = true,
          },
        }
        vim.notify('CursorTab enabled', vim.log.levels.INFO)
      else
        cursortab.toggle()
      end
    end, { desc = '[T]oggle [C]ursorTab' })
  end
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end

    -- Check if the buffer is valid (might not be after install completes)
    if not vim.api.nvim_buf_is_valid(buf) then return end

    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc. in `lua/custom/plugins/*.lua`.
  --
  -- For independent modules, uncomment the convenience loader:
  -- require 'custom.plugins'
  --
  -- `custom.plugins` automatically loads files from that directory, but their
  -- order is unspecified. If plugins depend on each other, keep them in the same
  -- file and put their `vim.pack.add()` and `setup()` calls in the required order.
  --
  -- If separate modules need a specific order, require them explicitly instead:
  -- require 'custom.plugins.colorscheme'
  -- require 'custom.plugins.ui'
  -- require 'custom.plugins.git'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
