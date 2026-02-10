# Agent Instructions

This file contains instructions for AI coding assistants working with this dotfiles repository.

## Configuration Locations

### Neovim
- **Location**: `~/.dotfiles/nvim/.config/nvim/`
- **Entry point**: `init.lua`
- **Plugins**: `lua/plugins/`
- **Colors**: `lua/plugins/color.lua`

### Ghostty
- **Location**: `~/.config/ghostty/config`

## General Guidelines

- Always check this file before making significant changes to configurations
- When editing configs, maintain existing code style and formatting
- Test changes when possible before committing
- Keep this file minimal - only document locations, not implementation details or current settings

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

### blink.cmp
**Purpose**: Modern, fast completion engine with LSP support  
**Configuration**: `~/.config/nvim/lua/plugins/completion.lua`  
**Repository**: saghen/blink.cmp  
**Features**:
- Auto-show completion menu
- Default keybindings for navigation
- Signature help
- LSP integration

### nvim-lspconfig
**Purpose**: Configurations for Neovim's built-in LSP client  
**Configuration**: `~/.config/nvim/lua/plugins/lsp.lua`  
**Repository**: neovim/nvim-lspconfig  
**Configured LSP Servers**:
- `lua_ls` - Lua language server
- `ruby_ls` - Ruby language server
- `omnisharp` - C# language server (at `/usr/local/bin/omnisharp/OmniSharp.dll`)

**Keybindings** (on LSP attach):
- `gd` - Go to definition
- `K` - Hover documentation
- `gi` - Go to implementation
- `gr` - Find references
- `<leader>ca` - Code actions

### mason.nvim
**Purpose**: Package manager for LSP servers, linters, and formatters  
**Configuration**: `~/.config/nvim/lua/plugins/lsp.lua`  
**Repository**: williamboman/mason.nvim

### mason-lspconfig.nvim
**Purpose**: Bridge between mason.nvim and nvim-lspconfig  
**Configuration**: `~/.config/nvim/lua/plugins/lsp.lua`  
**Repository**: williamboman/mason-lspconfig.nvim

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

### mini.snippets (from mini.nvim)
**Purpose**: Snippet engine and loader  
**Configuration**: `~/.config/nvim/lua/plugins/mini.lua`  
**Snippet Locations**:
- `~/.config/nvim/snippets/global.json` - Custom global snippets
- Language-specific snippets loaded automatically

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
**Features**: Shows file info, git status, diagnostics

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

### nvim-cmp
**Purpose**: Completion engine (legacy, currently using blink.cmp)  
**Configuration**: Installed but not actively configured  
**Repository**: hrsh7th/nvim-cmp  
**Note**: You have this installed but are using blink.cmp as primary completion

---

## Configuration Entry Points

- **Main config**: `~/.config/nvim/init.lua`
- **Lazy plugin manager**: `~/.config/nvim/lua/config/lazy.lua`
- **All plugins**: `~/.config/nvim/lua/plugins/` directory
- **Custom utilities**: `~/.config/nvim/lua/utils/` directory
- **Keybindings**: `~/.config/nvim/lua/remap.lua`
- **Settings**: `~/.config/nvim/lua/set.lua`
- **Commands**: `~/.config/nvim/lua/commands.lua`
- **Custom snippets**: `~/.config/nvim/snippets/global.json`

---

## Plugin Lock File

The exact versions of all installed plugins are tracked in:
`~/.config/nvim/lazy-lock.json`

This ensures reproducible plugin installations across machines.
