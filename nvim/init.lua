--  _   _  _____ _____  _   _ ________  ___
-- | \ | ||  ___|  _  || | | |_   _|  \/  |
-- |  \| || |__ | | | || | | | | | | .  . |
-- | . ` ||  __|| | | || | | | | | | |\/| |
-- | |\  || |___\ \_/ /\ \_/ /_| |_| |  | |
-- \_| \_/\____/ \___/  \___/ \___/\_|  |_/

--------------------------------------------------------------------------------
-- 1. Installing Lazy
--------------------------------------------------------------------------------
-- Install lazy.nvim if not installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- 2. Plugin Management
--------------------------------------------------------------------------------
-- Using Lazy to manage plugins.
require("lazy").setup({
	-- Lazy can manage itself.
	"folke/lazy.nvim",
	-- Catppuccin Color Scheme.
	"catppuccin/nvim",
	-- TokyoNight Color Scheme.
	"folke/tokyonight.nvim",
	-- Gruvbox Material Color Scheme.
	"sainnhe/gruvbox-material",
	-- Gruvbox Color Scheme.
	"ellisonleao/gruvbox.nvim",
	-- Status line plugin.
	"nvim-lualine/lualine.nvim",
	-- LSP.
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
			},
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion.
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
	},
	-- Formatting.
	"stevearc/conform.nvim",
	-- Fancy notification popups.
	"rcarriga/nvim-notify",
	-- Better UI.
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	-- Dashboard UI.
	"goolord/alpha-nvim",
	-- Render Markdown.
	"MeanderingProgrammer/render-markdown.nvim",
	-- ToggleTerm.
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	-- Tree sitter.
	"nvim-treesitter/nvim-treesitter",
	-- Neovim comments.
	"terrortylor/nvim-comment",
	-- Indentation guide.
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	-- Telescope.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	},
	-- Harpoon.
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
	},
	-- Yazi.
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>f",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>d",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<leader>r",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			open_for_directories = false,
			keymaps = { show_help = "<f1>" },
			yazi_args = {},
		},
	},
	-- Nvim Tree.
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	-- Nvim UFO.
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{
								text = { builtin.foldfunc },
								click = "v:lua.ScFa",
							},
							{ text = { "%s " }, click = "v:lua.ScSa" },
							{
								text = { builtin.lnumfunc, " " },
								click = "v:lua.ScLa",
							},
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			provider_selector = function(_, _, buftype)
				if buftype == "nofile" then
					return ""
				end
				return { "treesitter", "indent" }
			end,
		},
		init = function()
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
	-- GitSigns.
	"lewis6991/gitsigns.nvim",
	-- LazyGit.
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Auto trim trailing whitespaces and lines.
	"cappyzawa/trim.nvim",
	-- Auto pairs.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- Direnv.
	"direnv/direnv.vim",
	-- Quarto mode for Neovim.
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- Aiken Programming Language Support.
	{
		"aiken-lang/editor-integration-nvim",
		event = { "BufReadPre *.ak", "BufNewFile *.ak" },
	},
	-- Agda Theorem Prover.
	{
		"isovector/cornelis",
		name = "cornelis",
		ft = "agda",
		build = "stack install",
		dependencies = { "neovimhaskell/nvim-hs.vim", "kana/vim-textobj-user" },
		version = "*",
	},
	-- Lean Theorem Prover.
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			lsp = {},
			mappings = true,
		},
	},
})

--------------------------------------------------------------------------------
-- 3. Neovim Settings
--------------------------------------------------------------------------------
-- Set color scheme to Gruvbox Material.
vim.cmd([[
  syntax enable
  colorscheme catppuccin-mocha
]])

-- Set the colors for Yazi to match Catppuccin.
vim.api.nvim_create_autocmd("User", {
	pattern = "YaziReady",
	callback = function()
		vim.api.nvim_set_hl(0, "YaziDirectory", { fg = "#8caaee", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziFile", { fg = "#c6d0f5", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziSymlink", { fg = "#ca9ee6", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziSocket", { fg = "#a6d189", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziBlock", { fg = "#ef9f76", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziFifo", { fg = "#99d1db", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziChar", { fg = "#ca9ee6", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziMissing", { fg = "#e78284", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziCursorLine", { bg = "#414559" })
		vim.api.nvim_set_hl(0, "YaziNormal", { fg = "#c6d0f5", bg = "NONE" })
		vim.api.nvim_set_hl(0, "YaziBorder", { fg = "#626880", bg = "NONE" })
	end,
})

-- Set the colors for ToggleTerm to match Catppuccin.
vim.api.nvim_set_var("terminal_color_0", "#303446")
vim.api.nvim_set_var("terminal_color_1", "#e78284")
vim.api.nvim_set_var("terminal_color_2", "#a6d189")
vim.api.nvim_set_var("terminal_color_3", "#e5c890")
vim.api.nvim_set_var("terminal_color_4", "#8caaee")
vim.api.nvim_set_var("terminal_color_5", "#ca9ee6")
vim.api.nvim_set_var("terminal_color_6", "#99d1db")
vim.api.nvim_set_var("terminal_color_7", "#c6d0f5")
vim.api.nvim_set_var("terminal_color_8", "#626880")
vim.api.nvim_set_var("terminal_color_9", "#e78284")
vim.api.nvim_set_var("terminal_color_10", "#a6d189")
vim.api.nvim_set_var("terminal_color_11", "#e5c890")
vim.api.nvim_set_var("terminal_color_12", "#8caaee")
vim.api.nvim_set_var("terminal_color_13", "#ca9ee6")
vim.api.nvim_set_var("terminal_color_14", "#99d1db")
vim.api.nvim_set_var("terminal_color_15", "#c6d0f5")

-- Disable netrw at the very start of your init.lua (strongly advised).
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)

-- Enable the Neovim module loader.
vim.loader.enable()

-- Set termguicolors to enable highlight groups.
vim.opt.termguicolors = true

-- Enable relative line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight the text line of the cursor.
vim.opt.cursorline = false

-- Set the font family and size in neovide.
vim.o.guifont = "VictorMono Nerd Font:h17"

-- Decrease the neovide cursor trail size.
vim.api.nvim_set_var("neovide_cursor_trail_size", 0.10)

-- Use system's clipboard.
vim.o.clipboard = "unnamedplus"

-- 80 characters per line limit.
vim.wo.colorcolumn = "81"

-- UFO settings.
-- Disable folding and foldcolumn globally by default.
vim.opt.foldmethod = "manual"
vim.opt.foldenable = false
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 0

-- Enable specific folding settings.
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"nix",
		"lua",
		"rust",
		"gleam",
		"aiken",
		"typescript",
		"c",
		"cpp",
		"hpp",
		"markdown",
	},
	callback = function()
		if vim.bo.buftype ~= "nofile" then
			vim.opt_local.foldlevel = 99
			vim.opt_local.foldlevelstart = 99
			vim.opt_local.foldenable = true

			vim.opt_local.fillchars:append({
				eob = " ",
				fold = " ",
				foldopen = "▾",
				foldsep = " ",
				foldclose = "▸",
			})

			if vim.bo.filetype == "markdown" then
				vim.opt_local.foldcolumn = "0"
			else
				vim.opt_local.foldcolumn = "1"
			end
		end
	end,
})

-- Set default indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Settings for agda-mode.
vim.api.nvim_set_var("cornelis_split_location", "bottom")

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
	local languages = {
		"agda",
		"lean",
		"rust",
		"aiken",
		"javascript",
		"typescript",
		"typescriptreact",
	}
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

	vim.cmd("autocmd FileType markdown setlocal colorcolumn=")
	vim.cmd("autocmd BufNewFile,BufRead .env* setlocal colorcolumn=")
end

setupColorColumn()

-- Setting comment symbols for Nix, Gleam and Aiken.
vim.api.nvim_exec2(
	[[
    autocmd FileType nix setlocal commentstring=#%s
    autocmd FileType gleam setlocal commentstring=//%s
    autocmd FileType aiken setlocal commentstring=//%s
  ]],
	{}
)

-- Disable ~ symbols in the Alpha buffer.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		vim.opt_local.fillchars = "eob: "
	end,
})

-- Disables the screen centering while pressing 'j' 'k' in the Alpha Dashboard.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"j",
			"j",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"k",
			"k",
			{ noremap = true, silent = true }
		)
	end,
})

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
				disable = { "missing-fields", "undefined-field" },
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

-- Rust LSP
lspconfig.rust_analyzer.setup({})

-- Gleam LSP
lspconfig.gleam.setup({})

-- Aiken LSP
lspconfig.aiken.setup({})

-- Haskell LSP
lspconfig.hls.setup({})

-- OCaml LSP
lspconfig.ocamllsp.setup({})

-- C/C++ LSP
lspconfig.clangd.setup({})

-- Enables autoformatting for Aiken files.
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
		gleam = { "gleam" },
		haskell = { "fourmolu" },
		ocaml = { "ocamlformat" },
		typescript = { "prettierd" },
		javascript = { "prettierd" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		markdown = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		toml = { "taplo" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = false,
	},
})

--------------------------------------------------------------------------------
-- 5. Plugin Configuration
--------------------------------------------------------------------------------
require("alpha").setup(require("alpha.themes.dashboard").opts)

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  > Find file", "<Cmd>Telescope find_files<CR>"),
	dashboard.button("d", "  > Find directory", ":Yazi cwd<CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC<CR>"),
	dashboard.button("q", "⏻  > Quit NVIM", ":qa<CR>"),
}

-- Apply the updated settings to Alpha
alpha.setup(dashboard.opts)

local signs = {
	Error = " E",
	Warn = " W",
	Hint = " H",
	Info = " I",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon })
end

require("gitsigns").setup({
	signcolumn = true,
	numhl = false,
	linehl = false,
	signs = {
		add = { text = " │" },
		change = {
			text = " │",
		},
		delete = { text = " _" },
		topdelete = {
			text = " ‾",
		},
		changedelete = {
			text = " ~",
		},
	},
})

require("nvim_comment").setup()

require("ufo").setup()

require("toggleterm").setup({
	direction = "float",
	float_opts = {
		border = "curved",
		width = 105,
		height = 27,
		winblend = 0,
	},
})

local harpoon = require("harpoon")
harpoon:setup({
	settings = {
		save_on_toggle = false,
		sync_on_ui_close = false,
	},
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
		"gleam",
	},
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
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
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "Checking",
			},
			opts = { skip = true },
		},
	},
})

require("notify").setup({
	background_colour = "#000000",
})

require("ibl").setup({
	indent = {
		char = "│",
		highlight = "LineNr",
	},
	exclude = {
		buftypes = { "terminal" },
		filetypes = { "alpha" },
	},
	whitespace = {
		remove_blankline_trail = true,
	},
	scope = {
		enabled = false,
	},
})

-- Register hooks to hide first indent level.
local hooks = require("ibl.hooks")
hooks.register(
	hooks.type.WHITESPACE,
	hooks.builtin.hide_first_space_indent_level
)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

require("trim").setup({
	ft_blocklist = { "markdown" },
})

require("nvim-autopairs").setup()

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 25,
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
		theme = "catppuccin-macchiato",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			"diagnostics",
		},
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = { "location" },
	},
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local colorscheme = vim.g.colors_name
		require("lualine").setup({
			options = {
				theme = colorscheme,
			},
		})
	end,
})

--------------------------------------------------------------------------------
-- 6. Keymaps
--------------------------------------------------------------------------------
-- Set the leader key to Space.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Keybindings for searching with Telescope.
keymap("n", "<leader>sf", "<Cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>sw", "<Cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>sb", "<Cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>sg", "<Cmd>Telescope git_status<CR>", opts)

-- Open LazyGit.
keymap("n", "<leader>lg", "<cmd>LazyGitCurrentFile<cr>", opts)

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

-- Keybinding to toggle the terminal and open it in the home directory if in the
-- Alpha buffer, otherwise in the current file's directory.
keymap("n", "<leader>t", function()
	local is_alpha = vim.bo.filetype == "alpha"
	local term_dir = is_alpha and vim.fn.expand("~") or vim.fn.expand("%:p:h")
	require("toggleterm.terminal").Terminal:new({ dir = term_dir }):toggle()
end, opts)

-- Switch to previous buffer (code) when in the terminal with <C-h>.
keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)

-- Switch to terminal from code with <C-l>.
keymap("n", "<C-l>", "<Cmd>ToggleTerm direction=float<CR>", opts)

-- Go to Dashboard.
keymap("n", "<leader>a", ":Alpha<CR>", opts)

-- Deletes all buffers and restart all LSP servers.
keymap(
	"n",
	"<leader>0",
	":bufdo bd<CR>:LspRestart<CR>:Alpha<CR>:bdelete#<CR>",
	opts
)

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

-- Harpoon Keymaps.
keymap("n", "<leader>h", function()
	harpoon:list():add()
end, opts)
keymap("n", "<leader><leader>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, opts)
keymap("n", "<leader>1", function()
	harpoon:list():select(1)
end, opts)
keymap("n", "<leader>2", function()
	harpoon:list():select(2)
end, opts)
keymap("n", "<leader>3", function()
	harpoon:list():select(3)
end, opts)
keymap("n", "<leader>4", function()
	harpoon:list():select(4)
end, opts)
keymap("n", "<leader>5", function()
	harpoon:list():select(5)
end, opts)

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

-- Function to increase the font size.
local function increase_font_size()
	local current_font = vim.o.guifont
	local font, size = string.match(current_font, "([^:]+):h(%d+)")
	size = tonumber(size) + 1
	vim.o.guifont = font .. ":h" .. size
	print("Font size increased to: " .. size)
end

-- Function to decrease the font size.
local function decrease_font_size()
	local current_font = vim.o.guifont
	local font, size = string.match(current_font, "([^:]+):h(%d+)")
	size = tonumber(size) - 1
	if size > 8 then
		vim.o.guifont = font .. ":h" .. size
		print("Font size decreased to: " .. size)
	else
		print("Font size is already at the minimum!")
	end
end

-- Keymap for Ctrl-Shift-+ to increase the font size.
keymap("n", "<C-+>", increase_font_size, opts)

-- Keymap for Ctrl-Shift-- to decrease the font size.
keymap("n", "<C-_>", decrease_font_size, opts)

-- Keymap for splitting the window (vertically).
keymap("n", "<leader>v", ":vs<CR>", opts)

-- Save.
keymap("n", "<leader>w", ":w<CR>", opts)

-- Quit.
keymap("n", "<leader>q", ":q<CR>", opts)

-- Delete buffer.
keymap("n", "<leader>bd", ":bd<CR>", opts)

-- Erase highlight.
keymap("n", "<leader>noh", ":noh<CR>", opts)
