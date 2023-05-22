-- init.lua
-- Install packer if not installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Use packer to manage plugins
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Tokyo Night theme
  use 'folke/tokyonight.nvim'
  -- Status line plugin
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'VonHeikemen/lsp-zero.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }
  -- Tree sitter
  use 'nvim-treesitter/nvim-treesitter'
  -- Neovim comments
  use 'terrortylor/nvim-comment'
  -- Indentation guide
  use 'lukas-reineke/indent-blankline.nvim'
  -- Telescope plugin
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }
end)

-- Nvim Tree settings:
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  }
})

-- Configure statusline for LSP
local lsp_status = require('lsp-status')
lsp_status.register_progress()

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_c = {'filename'},
    lualine_x = {'location'},
  },
  tabline = {
    lualine_a = {'buffers'},
  }
}

-- Set theme to Tokyo Night
vim.cmd [[
  syntax enable
  colorscheme tokyonight
]]

-- No background color
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.cmd [[
  hi NvimTreeNormal guibg=NONE ctermbg=NONE
  hi NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
]]

-- Enable relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Use system's clipboard
vim.o.clipboard = "unnamedplus"

-- 80 characters per line limit
vim.wo.colorcolumn = "81"

-- No sign column
vim.wo.signcolumn = "no"

-- Set scroll off to 5 lines
vim.o.scrolloff = 5

-- Hide end of buffer lines
-- vim.wo.fillchars = "eob: "

-- LSP configuration
require("mason").setup()
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
  'hls'
})

lsp.setup()

require'lspconfig'.metals.setup{}
require'lspconfig'.hls.setup{}


require('nvim-treesitter.configs').setup {
  -- Install these parsers
  ensure_installed = {"lua", "haskell", "scala", "elm", "typescript"},
  highlight = {
    enable = true, -- Enable highlighting
  },
}

require('nvim_comment').setup()

require("indent_blankline").setup {
  -- The character used for indentation guides
  char = "│",
  -- Exclude indentation guides in terminal buffers
  buftype_exclude = { "terminal" },
  -- Disable indentation guides for blank lines
  show_trailing_blankline_indent = false,
  -- Disable indentation guide for the first indent level
  show_first_indent_level = false,
  -- Use treesitter to determine indentation level
  use_treesitter = true,
}

-- Scroll up/down while maintaing the cursor in the middle of the screen
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Key mapping for opening Telescope
vim.api.nvim_set_keymap('n', '<Space>sf', '<Cmd>Telescope<CR>', { noremap = true, silent = true })
-- Key mapping for searching files with Telescope
vim.api.nvim_set_keymap('n', '<Space>sf', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })

-- Key mapping for hovering LSP information with <Shift-k>
vim.api.nvim_set_keymap('n', '<S-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
-- Key mapping for jumping to the next warning/error with <C-k>
vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Toggle Nvim Tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
