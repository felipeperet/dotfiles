--------------------------------------------------------------------------------
-- 1. Installing Packer
--------------------------------------------------------------------------------
-- Install packer if not installed.
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

--------------------------------------------------------------------------------
-- 2. Plugin Management
--------------------------------------------------------------------------------
-- Using Packer to manage plugins.
require("packer").startup(function()
	-- Packer can manage itself.
	use("wbthomason/packer.nvim")
	-- TokyoNight Color Scheme.
	use("folke/tokyonight.nvim")
	-- Status line plugin.
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	-- LSP.
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support.
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				run = function()
					pcall(function()
						vim.cmd("MasonUpdate")
					end)
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion.
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	-- Formatting.
	use("stevearc/conform.nvim")
	-- Fancy notification popups.
	use("rcarriga/nvim-notify")
	-- Better UI.
	use({
		"folke/noice.nvim",
		requires = { "MunifTanjim/nui.nvim" },
	})
	-- Tree sitter.
	use("nvim-treesitter/nvim-treesitter")
	-- Neovim comments.
	use("terrortylor/nvim-comment")
	-- Transparent.
	use("xiyaowong/transparent.nvim")
	-- Indentation guide.
	use({
		"lukas-reineke/indent-blankline.nvim",
		commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
	})
	-- Telescope.
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	})
	-- Nvim Tree.
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	-- GitSigns.
	use("lewis6991/gitsigns.nvim")
	-- Auto pairs.
	use("windwp/nvim-autopairs")
	-- Direnv.
	use("direnv/direnv.vim")
	-- Necessary plugins for Agda.
	use("kana/vim-textobj-user")
	use("neovimhaskell/nvim-hs.vim")
	use({
		"isovector/cornelis",
		run = "stack build",
	})
	-- Aiken Programming Language Support.
	use("aiken-lang/editor-integration-nvim")
end)

--------------------------------------------------------------------------------
-- 3. Neovim Settings
--------------------------------------------------------------------------------
-- Set color scheme to Kanagawa.
vim.cmd([[
  syntax enable
  colorscheme tokyonight
]])

-- Disable netrw at the very start of your init.lua (strongly advised).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups.
vim.opt.termguicolors = true

-- Enable relative line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Use system's clipboard.
vim.o.clipboard = "unnamedplus"

-- 80 characters per line limit.
vim.wo.colorcolumn = "81"

-- Set default indentation
vim.opt.tabstop = 2 -- Set the number of spaces for <Tab> in the file.
vim.opt.softtabstop = 2 -- Set the number of spaces for a <Tab> in insert mode.
vim.opt.shiftwidth = 2 -- Set the number of spaces for autoindenting.
vim.opt.expandtab = true -- Converts tabs to spaces.

-- Settings for agda-mode.
vim.g.cornelis_split_location = "right"
vim.g.cornelis_max_width = 52

-- Function to create autocmd for 4 spaces indentation.
local function setupFourSpacesIndentation()
	local four_spaces_languages = { "c", "cpp", "rust", "haskell" }
	for _, lang in ipairs(four_spaces_languages) do
		local cmd = string.format(
			"autocmd FileType %s setlocal tabstop=4 "
				.. "shiftwidth=4 softtabstop=4 expandtab",
			lang
		)
		vim.cmd(cmd)
	end
end

setupFourSpacesIndentation()

-- Function to create autocmd for setting colorcolumn based on the language.
local function setupColorColumn()
	local languages =
		{ "rust", "aiken", "javascript", "typescript", "typescriptreact" }
	local col = 101

	for _, lang in ipairs(languages) do
		vim.cmd(
			string.format(
				"autocmd FileType %s setlocal colorcolumn=%s",
				lang,
				tostring(col)
			)
		)
	end
end

setupColorColumn()

-- Setting comment symbols for Aiken and Nix.
vim.api.nvim_exec(
	[[
  autocmd FileType aiken setlocal commentstring=//%s
  autocmd FileType nix setlocal commentstring=#%s
]],
	false
)

--------------------------------------------------------------------------------
-- 4. LSP Configuration
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")

-- LSP configuration.
require("mason").setup()
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

-- Lua LSP
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "use" },
				disable = { "missing-fields" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- C/C++ LSP
lspconfig.clangd.setup({})

-- Rust LSP
lspconfig.rust_analyzer.setup({})

-- OCaml LSP
lspconfig.ocamllsp.setup({})

-- Haskell LSP
lspconfig.hls.setup({})

-- Aiken LSP
lspconfig.aiken.setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.ak",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Conform Formatting.
require("conform").setup({
	formatters_by_ft = {
		nix = { "alejandra" },
		lua = { "stylua" },
		rust = { "rustfmt" },
		haskell = { "fourmolu" },
		ocaml = { "ocamlformat" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		markdown = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		toml = { "taplo" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

--------------------------------------------------------------------------------
-- 5. Plugin Configuration
--------------------------------------------------------------------------------
require("gitsigns").setup()

require("nvim_comment").setup()

require("transparent").setup({
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLineNr",
		"EndOfBuffer",
	},
	extra_groups = {
		"NormalFloat",
		"FloatBorder",
		"NvimTreeNormal",
		"NvimTreeNormalNC",
		"NvimTreeEndOfBuffer",
		"NvimTreeWinSeparator",
		"TelescopeNormal",
		"TelescopeBorder",
		"GitSignsAdd",
		"GitSignsChange",
		"GitSignsDelete",
		"DiagnosticSignError",
		"DiagnosticSignWarn",
		"DiagnosticSignHint",
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextWarn",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextHint",
		"NotifyERRORBorder",
		"NotifyWARNBorder",
		"NotifyINFOBorder",
		"NotifyDEBUGBorder",
		"NotifyTRACEBorder",
		"NotifyERRORBody",
		"NotifyWARNBody",
		"NotifyINFOBody",
		"NotifyDEBUGBody",
		"NotifyTRACEBody",
	},
	exclude_groups = {},
})

local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
					"n"
				)
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["|"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
					"n"
				)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"vim",
		"vimdoc",
		"nix",
		"lua",
		"javascript",
		"typescript",
		"c",
		"cpp",
		"rust",
		"ocaml",
		"haskell",
	},
	highlight = {
		enable = true,
		disable = {},
	},
})

require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "written",
			},
			opts = { skip = true },
		},
	},
})

require("indent_blankline").setup({
	char = "│",
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	use_treesitter = true,
})

require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 20,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = { "location" },
	},
	tabline = {
		lualine_a = { "buffers" },
	},
})

--------------------------------------------------------------------------------
-- 6. Keymaps
--------------------------------------------------------------------------------
-- Shorten function name.
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Scroll up/down while maintaining the cursor centered.
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap({ "n", "x" }, "{", "{zz", opts)
keymap({ "n", "x" }, "}", "}zz", opts)

-- Move to end of file while maintaining the cursor centered.
keymap("n", "<S-g>", "<S-g>zz", opts)

-- Keybindings for searching files and words with Telescope.
keymap("n", "<Space>sf", "<Cmd>Telescope find_files<CR>", opts)
keymap("n", "<Space>sw", "<Cmd>Telescope live_grep<CR>", opts)

-- Keybindings for hovering LSP information with <Shift-k>.
keymap("n", "<S-k>", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- Keybindings for jumping to the next warning/error with <C-k>.
keymap("n", "<C-k>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Navigate buffers.
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Toggle Nvim Tree.
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Center the screen after scrolling with 'j' or 'k'.
keymap("n", "j", "jzz", opts)
keymap("n", "k", "kzz", opts)

-- Keymap for 'go to definition' with screen centering and a slight delay.
keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>:sleep 5m<CR>zz", opts)

-- Keymap for applying LSP code action.
keymap("n", "<C-a>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- GitSigns Keymaps.
keymap(
	"n",
	"<C-f>",
	":Gitsigns next_hunk<CR>:sleep 5m<CR>"
		.. ":Gitsigns preview_hunk_inline<CR>:sleep 5m<CR>zz",
	opts
)
keymap(
	"n",
	"<C-b>",
	":Gitsigns prev_hunk<CR>:sleep 5m<CR>"
		.. ":Gitsigns preview_hunk_inline<CR>:sleep 5m<CR>zz",
	opts
)
keymap("n", "<S-f>", ":Gitsigns preview_hunk_inline<CR>", opts)
keymap({ "n", "x" }, "<S-p>", ":Gitsigns reset_hunk<CR>", opts)

-- Cornelis Agda Keymaps.
keymap("n", "<C-c><C-l>", "<Cmd>CornelisLoad<CR>", opts)
keymap("n", "<C-c><C-g>", "<Cmd>CornelisGoals<CR>", opts)
keymap("n", "<C-c><C-s>", "<Cmd>CornelisSolve<CR>", opts)
keymap("n", "<C-c><C-d>", "<Cmd>CornelisGoToDefinition<CR>", opts)
keymap("n", "<C-c><C-b>", "<Cmd>CornelisPrevGoal<CR>:sleep 5m<CR>zz", opts)
keymap("n", "<C-c><C-f>", "<Cmd>CornelisNextGoal<CR>:sleep 5m<CR>zz", opts)
keymap("n", "<C-c><C-r>", "<Cmd>CornelisRefine<CR>", opts)
keymap("n", "<C-c><C-a>", "<Cmd>CornelisAuto<CR>", opts)
keymap("n", "<C-c><C-c>", "<Cmd>CornelisMakeCase<CR>", opts)
keymap("n", "<C-c><C-,>", "<Cmd>CornelisTypeContext<CR>", opts)
keymap("n", "<C-c><C-i>", "<Cmd>CornelisTypeInfer<CR>", opts)
keymap("n", "<C-c><C-n>", "<Cmd>CornelisNormalize<CR>", opts)
keymap("n", "<C-c><C-k>", "<Cmd>CornelisQuestionToMeta<CR>", opts)
keymap("n", "<C-c><C-x><C-r>", "<Cmd>CornelisRestart<CR>", opts)
