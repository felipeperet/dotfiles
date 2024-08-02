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
	-- TokyoNight Color Scheme.
	"folke/tokyonight.nvim",
	-- Sonokai Color Scheme.
	"sainnhe/sonokai",
	-- Status line plugin.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
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
	-- Tree sitter.
	"nvim-treesitter/nvim-treesitter",
	-- Neovim comments.
	"terrortylor/nvim-comment",
	-- Transparent.
	"xiyaowong/transparent.nvim",
	-- Indentation guide.
	{
		"lukas-reineke/indent-blankline.nvim",
		commit = "9637670896b68805430e2f72cf5d16be5b97a22a",
	},
	-- Telescope.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	},
	-- Nvim Tree.
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	-- GitSigns.
	"lewis6991/gitsigns.nvim",
	-- Auto trim trailing whitespaces and lines.
	"cappyzawa/trim.nvim",
	-- Auto pairs.
	"windwp/nvim-autopairs",
	-- Direnv.
	"direnv/direnv.vim",
	-- Aiken Programming Language Support.
	"aiken-lang/editor-integration-nvim",
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
-- Set color scheme to Kanagawa.
vim.cmd([[
  syntax enable
  colorscheme tokyonight-storm
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
vim.api.nvim_exec2(
	[[
    autocmd FileType aiken setlocal commentstring=//%s
    autocmd FileType nix setlocal commentstring=#%s
  ]],
	{}
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

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*.ak",
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = false })
-- 	end,
-- })

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
		lsp_fallback = false,
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
		"TelescopePromptTitle",
		"TelescopePromptBorder",
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

require("indent_blankline").setup({
	char = "│",
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	use_treesitter = true,
})

require("trim").setup({
	ft_blocklist = { "markdown" },
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
		lualine_b = {
			{ "branch", icon = "" }, -- nf-pl-branch is broken
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
