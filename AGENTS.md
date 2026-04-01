# Agent Instructions

This file contains instructions for AI coding assistants working with this dotfiles repository.

## Overview

- These dotfiles are shared across 3 types of machines - Work (osx + zsh), Personal (osx + zsh), Omarchy (Arch + bash).
- Stow files in `./stow-work`, `./stow-personal` and `./stow-omarchy` symlink the appropriate directory contents for each type of system.
- Work (`./work/`) and Personal (`./personal/`) are separate private Git repositories set up as submodules.
- This dotfiles repository is public, and so no personal or work information should be committed.

---

## Functions

Shell functions can be in a few places:

- `./bin/.local/bin/` - Individual executable function files, shared by all systems
- `./shared/sh/functions` - Single file with smaller functions, shared by all systems
- `./work/sh/functions` - Single file with smaller functions, work only
- `./personal/sh/functions` - Single file with smaller functions, personal only
- `./omarchy/sh/functions` - Single file with smaller functions, omarchy only

All functions follow a standard format, so reference an existing function before writing a new one.
When the user asks for a new 'shared function' - assume this will be `./bin/.local/bin/`. This is the preferred method. Ensure these functions are system agnostic and contain no personal or work references.

## bin/.local/bin Script Standards

All standalone scripts in `./bin/.local/bin/` must follow these standards:

- Shebang: always `#!/usr/bin/env bash`
- Strict mode: always `set -euo pipefail` at the top (omit only in sourced files)
- Help flag: every script must handle `--help` and print usage + required env vars
- No emojis or ANSI colour codes in output
- Error messages go to stderr: `echo "ERROR: ..." >&2`
- Use plain text prefixes: `ERROR:`, `WARNING:`, `OK:` — no symbols
- No `eval` for building commands; use arrays: `cmd=(prog arg1 arg2); "${cmd[@]}"`
- No hardcoded values that should vary by environment — use env vars with fallbacks
- Required env vars: if unset, print the missing var name and suggest the export line, then exit 1:
  ```
  echo "ERROR: FOO_VAR is not set" >&2
  echo "Add to your shell config: export FOO_VAR=" >&2
  exit 1
  ```
- Optional env vars with defaults: use `${VAR:-default}` and warn if using the default when it matters (e.g. container names)

---

## Skills

Agent skills are located at:

- `./skills/` - Shared agnostic skills
- `./work/code/skills/` - Work-specific skills

There is a naming convention for skills:

- `create-*` - Primary job of the skill is to produce output — documents, code, SQL, reviews, etc.
- `guide-{project-name}-*` - How to do something in a specific project or context — implementation patterns, conventions, operational procedures.
- `domain-{project-name}-*` - Business domain knowledge about a feature or product within a project.
- `styleguide-{language}` - Language-level code style and conventions, not specific to any one project.


---

## Configuration Locations

### Neovim
- **Location**: `~/.dotfiles/nvim/.config/nvim/`
- **Entry point**: `init.lua`
- **Plugins**: `lua/plugins/`
- **Colors**: `lua/plugins/color.lua`

### Ghostty
- **Location**: `~/.config/ghostty/config`

### tmux
- **Main config**: `~/dotfiles/tmux/.tmux.conf`
- **Sessionizer**: `~/dotfiles/bin/tmux-sessionizer` (script), `~/.config/tmux-sessionizer/tmux-sessionizer.conf` (search paths)
- **Session switching**: `Ctrl+1/2/3/4` switches to tmux session by position (requires `extended-keys on` and a terminal that passes Ctrl+number, e.g. Ghostty)

## General Guidelines

- Always check this file before making significant changes to configurations
- When editing configs, maintain existing code style and formatting
- Test changes when possible before committing
- Keep this file minimal - only document locations, not implementation details or current settings

## Shell Configuration Pattern

All shell setups follow a consistent two-level sourcing pattern:

| Setup | Shell Config | Sources |
|-------|-------------|---------|
| **Personal** | `zsh/.zshrc` | `shared/sh/rc` + `personal/personal-sh/rc` |
| **Work** | `work/.zshrc` | `shared/sh/rc` + `work/work-sh/rc` |
| **Omarchy** | `omarchy/.bashrc` | `shared/sh/rc` + `omarchy/bash/rc` |

Each `rc` file sources its sibling files (functions, aliases, paths, envs, init, shell).


---

# Neovim Plugin Configuration

This document lists all installed Neovim plugins, their purpose, and where their configuration is located.

## Plugin Manager

### lazy.nvim
**Purpose**: Plugin manager for Neovim
**Configuration**: `~/.config/nvim/lua/config/lazy.lua`
**Repository**: folke/lazy.nvim

---

## LSP & Completion

### Native vim.lsp
**Purpose**: LSP client configuration using Neovim's built-in `vim.lsp.config` and `vim.lsp.enable`
**Configuration**: `~/.config/nvim/lua/lsp.lua` (entry point), `~/.config/nvim/lua/lsp/` (per-server configs)
**Configured LSP Servers**: lua_ls, ruby_lsp, ts_ls, gopls, omnisharp, bash-language-server, marksman, html

**Keybindings** (via `~/.config/nvim/lua/lsp/common.lua`):
- `gd` - Go to definition (markdown: also follows `[[wiki-links]]` and `![[embedded]]`)
- `K` - Hover documentation
- `gi` - Go to implementation
- `gr` - Find references
- `<leader>ca` - Code actions
- `gl` - Open diagnostic float
- `ql` - Send diagnostics to quickfix list

### blink.cmp
**Purpose**: Modern, fast completion engine with LSP support
**Configuration**: `~/.config/nvim/lua/plugins/completion.lua`
**Repository**: saghen/blink.cmp
**Features**:
- Auto-show completion menu with documentation preview
- Snippet support via built-in snippets source (loads from friendly-snippets and custom snippets)
- Default keybindings (`<Tab>` / `<S-Tab>` for snippet tabstops)
- Signature help
- Sources: lsp, path, snippets, buffer

### mason.nvim
**Purpose**: Package manager for LSP servers, linters, and formatters
**Configuration**: `~/.config/nvim/lua/plugins/mason.lua`
**Repository**: mason-org/mason.nvim

### fidget.nvim
**Purpose**: LSP progress notifications UI
**Configuration**: `~/.config/nvim/lua/plugins/fidget.lua`
**Repository**: j-hui/fidget.nvim
**Features**: Shows LSP server status and progress in the corner

---

## Snippets

### friendly-snippets
**Purpose**: Collection of pre-configured snippets for various languages
**Configuration**: `~/.config/nvim/lua/plugins/snippets.lua`
**Repository**: rafamadriz/friendly-snippets

### Custom Snippets
**Purpose**: Project-specific snippet definitions loaded by blink.cmp's snippets source
**Location**: `~/.config/nvim/snippets/`
**Files**:
- `cs.json` - C# snippets (e.g., Public API operation interface)

---

## Fuzzy Finder & Navigation

### telescope.nvim
**Purpose**: Highly extensible fuzzy finder for files, text, commands, and more
**Configuration**: `~/.config/nvim/lua/plugins/telescope.lua`
**Repository**: nvim-telescope/telescope.nvim
**Extensions**:
- `fzf` - Native FZF sorter for better performance
- `harpoon` - Integration with Harpoon
- `luasnip` - Browse and insert snippets

**Keybindings**:
- `<C-f>` - Find files
- `<leader>fg` - Live grep (including hidden files)
- `<leader>fj` - Grep word under cursor
- `<leader>fr` - Resume last search
- `<leader>ff` - Find files
- `<leader>fb` - List buffers
- `<leader>fh` - Help tags
- `<leader>fq` - Quickfix list
- `<leader>fk` - Git files
- `<leader>fc` - Commands
- `<leader>fi` - Keymaps
- `<leader>gl` - Git commits
- `<leader>fv` - Search dotfiles
- `<leader>fd` - Search docs
- `<leader>fD` - Live search docs
- `<leader>fm` - Files changed since main (git diff vs main/origin/main)
- `<leader>fo` - Vim options
- `<leader>fa` - Telescope builtins
- `<leader>fs` - Spell suggestions
- `<leader>fl` - LuaSnip suggestions

### telescope-fzf-native.nvim
**Purpose**: Native FZF sorter for Telescope (faster performance)
**Configuration**: `~/.config/nvim/lua/plugins/telescope.lua`
**Repository**: nvim-telescope/telescope-fzf-native.nvim

### telescope-luasnip.nvim
**Purpose**: Telescope extension for browsing snippets
**Configuration**: `~/.config/nvim/lua/plugins/telescope.lua`
**Repository**: benfowler/telescope-luasnip.nvim

### harpoon
**Purpose**: Quick file navigation - mark and jump to frequently used files
**Configuration**: `~/.config/nvim/lua/plugins/harpoon.lua`
**Repository**: ThePrimeagen/harpoon
**Keybindings**:
- `<C-e>` - Toggle Harpoon menu
- `<leader>a` - Add current file to Harpoon
- `<leader>j` - Navigate to file 1
- `<leader>k` - Navigate to file 2
- `<leader>l` - Navigate to file 3
- `<leader>;` - Navigate to file 4

### NERDTree
**Purpose**: File system explorer tree
**Configuration**: `~/.config/nvim/lua/plugins/nerdtree.lua`
**Repository**: preservim/nerdtree

---

## Syntax & Parsing

### nvim-treesitter
**Purpose**: Advanced syntax highlighting and code understanding using tree-sitter
**Configuration**: `~/.config/nvim/lua/plugins/treesitter.lua`
**Repository**: nvim-treesitter/nvim-treesitter
**Features**:
- Syntax highlighting
- Code folding
- Indentation
- Text objects

### nvim-treesitter-endwise
**Purpose**: Auto-add `end` keywords for Ruby, Lua, Bash, etc.
**Configuration**: `~/.config/nvim/lua/plugins/treesitter.lua`
**Repository**: RRethy/nvim-treesitter-endwise
**Status**: Currently disabled in config

### nvim-treesitter-textsubjects
**Purpose**: Smart text object selection using tree-sitter
**Configuration**: `~/.config/nvim/lua/plugins/treesitter.lua`
**Repository**: RRethy/nvim-treesitter-textsubjects
**Keybindings**:
- `.` - Select smart text object
- `am` - Select outer container
- `im` - Select inner container
- `,` - Previous selection

---

## Testing

### neotest
**Purpose**: Testing framework integration - run and view test results
**Configuration**: `~/.config/nvim/lua/plugins/neotest.lua`
**Repository**: nvim-neotest/neotest
**Adapters**:
- `neotest-go` - Go test adapter

### neotest-go
**Purpose**: Go language adapter for neotest
**Configuration**: `~/.config/nvim/lua/plugins/neotest.lua`
**Repository**: nvim-neotest/neotest-go

### FixCursorHold.nvim
**Purpose**: Fix CursorHold performance issue (required by neotest)
**Configuration**: Dependency of neotest
**Repository**: antoinemadec/FixCursorHold.nvim

---

## Debugging

### nvim-dap
**Purpose**: Debug Adapter Protocol client - debugging support
**Configuration**: `~/.config/nvim/lua/plugins/dap.lua`
**Repository**: mfussenegger/nvim-dap
**Keybindings**:
- `<space>b` - Toggle breakpoint
- `<space>gb` - Run to cursor
- `<space>?` - Evaluate expression
- `<F1>` - Continue
- `<F2>` - Step into
- `<F3>` - Step over
- `<F4>` - Step out
- `<F5>` - Step back
- `<F13>` - Restart

### nvim-dap-go
**Purpose**: Go language adapter for DAP
**Configuration**: `~/.config/nvim/lua/plugins/dap.lua`
**Repository**: leoluz/nvim-dap-go

### nvim-dap-ui
**Purpose**: UI for nvim-dap with windows for scopes, breakpoints, stack traces
**Configuration**: `~/.config/nvim/lua/plugins/dap.lua`
**Repository**: rcarriga/nvim-dap-ui

### nvim-dap-virtual-text
**Purpose**: Show variable values as virtual text during debugging
**Configuration**: `~/.config/nvim/lua/plugins/dap.lua`
**Repository**: theHamsta/nvim-dap-virtual-text

---

## Git Integration

### vim-fugitive
**Purpose**: Git wrapper - run Git commands from Neovim
**Configuration**: `~/.config/nvim/lua/plugins/fugative.lua`
**Repository**: tpope/vim-fugitive

---

## AI Assistance

### codecompanion.nvim
**Purpose**: AI coding assistant with chat and inline editing
**Configuration**: `~/.config/nvim/lua/plugins/codecompanion.lua`
**Repository**: olimorris/codecompanion.nvim
**Features**:
- Chat interface with AI
- Inline code suggestions
- Agent mode
- Uses Anthropic (Claude) by default

### dressing.nvim
**Purpose**: Improve default Neovim UI (used by codecompanion)
**Configuration**: Dependency of codecompanion
**Repository**: stevearc/dressing.nvim

---

## UI & Appearance

### tokyonight.nvim
**Purpose**: Color scheme
**Configuration**: `~/.config/nvim/lua/plugins/color.lua`
**Repository**: folke/tokyonight.nvim
**Style**: "moon" with transparent background

### mini.statusline (from mini.nvim)
**Purpose**: Minimal statusline
**Configuration**: `~/.config/nvim/lua/plugins/mini.lua`
**Features**: Shows file info, git status, diagnostics, and active LSP server names

---

## Utilities

### plenary.nvim
**Purpose**: Lua utility functions (required by many plugins)
**Configuration**: Dependency for multiple plugins
**Repository**: nvim-lua/plenary.nvim

### nvim-nio
**Purpose**: Async IO library (required by DAP UI and neotest)
**Configuration**: Dependency for DAP and neotest
**Repository**: nvim-neotest/nvim-nio

---

## Configuration Entry Points

- **Main config**: `~/.config/nvim/init.lua`
- **Lazy plugin manager**: `~/.config/nvim/lua/config/lazy.lua`
- **All plugins**: `~/.config/nvim/lua/plugins/` directory
- **Custom utilities**: `~/.config/nvim/lua/utils/` directory
- **Keybindings**: `~/.config/nvim/lua/remap.lua`
- **Settings**: `~/.config/nvim/lua/set.lua`
- **Commands**: `~/.config/nvim/lua/commands.lua`
- **Custom snippets**: `~/.config/nvim/snippets/` (e.g., `cs.json` for C#)

---

## Plugin Lock File

The exact versions of all installed plugins are tracked in:
`~/.config/nvim/lazy-lock.json`

This ensures reproducible plugin installations across machines.


