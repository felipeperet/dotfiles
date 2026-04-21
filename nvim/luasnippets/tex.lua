local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function in_math()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function not_math()
	return not in_math()
end

local function ma(trig, replacement)
	return s(
		{ trig = trig, snippetType = "autosnippet", wordTrig = false },
		t(replacement),
		{ condition = in_math }
	)
end

local function mw(trig, replacement)
	return s(
		{ trig = trig, snippetType = "autosnippet", wordTrig = true },
		t(replacement),
		{
			condition = function()
				if not in_math() then
					return false
				end
				local _, col = unpack(vim.api.nvim_win_get_cursor(0))
				local line = vim.api.nvim_get_current_line()
				local before = line:sub(col - #trig, col - #trig)
				if before:match("[%w/\\]") then
					return false
				end
				return true
			end,
		}
	)
end

return {
	------------------------------------------------------------------------
	-- AUTO-FRACTION
	------------------------------------------------------------------------
	s({
		trig = "([%w]+)/",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\frac{" .. snip.captures[1] .. "}{"
		end),
		i(1),
		t("}"),
		i(0),
	}, { condition = in_math }),

	s({
		trig = "%(([^%(%)]+)%)/",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\frac{" .. snip.captures[1] .. "}{"
		end),
		i(1),
		t("}"),
		i(0),
	}, { condition = in_math }),

	------------------------------------------------------------------------
	-- SUPERSCRIPT / SUBSCRIPT
	------------------------------------------------------------------------
	s({
		trig = "([%a])(%d)",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return snip.captures[1] .. "^{" .. snip.captures[2] .. "}"
		end),
	}, { condition = in_math }),

	s({ trig = "^", snippetType = "autosnippet", wordTrig = false }, {
		t("^{"),
		i(1),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "_", snippetType = "autosnippet", wordTrig = false }, {
		t("_{"),
		i(1),
		t("}"),
	}, { condition = in_math }),

	ma("sr", "^{2}"),
	ma("cb", "^{3}"),
	ma("inv", "^{-1}"),
	ma("tp", "^{\\top}"),

	------------------------------------------------------------------------
	-- GREEK LETTERS (@ prefix)
	------------------------------------------------------------------------
	mw("@a", "\\alpha"),
	mw("@b", "\\beta"),
	mw("@g", "\\gamma"),
	mw("@G", "\\Gamma"),
	mw("@d", "\\delta"),
	mw("@D", "\\Delta"),
	mw("@e", "\\epsilon"),
	mw("@ve", "\\varepsilon"),
	mw("@z", "\\zeta"),
	mw("@t", "\\theta"),
	mw("@T", "\\Theta"),
	mw("@k", "\\kappa"),
	mw("@l", "\\lambda"),
	mw("@L", "\\Lambda"),
	mw("@s", "\\sigma"),
	mw("@S", "\\Sigma"),
	mw("@o", "\\omega"),
	mw("@O", "\\Omega"),
	mw("@p", "\\phi"),
	mw("@P", "\\Phi"),
	mw("@ps", "\\psi"),
	mw("@Ps", "\\Psi"),
	mw("@r", "\\rho"),
	mw("@x", "\\xi"),
	mw("@X", "\\Xi"),
	mw("@c", "\\chi"),
	mw("@n", "\\nu"),
	mw("@m", "\\mu"),
	mw("@et", "\\eta"),
	mw("@i", "\\iota"),
	mw("@ta", "\\tau"),

	------------------------------------------------------------------------
	-- GREEK LETTERS (full name)
	------------------------------------------------------------------------
	mw("pi", "\\pi"),
	mw("Pi", "\\Pi"),
	mw("alpha", "\\alpha"),
	mw("beta", "\\beta"),
	mw("gamma", "\\gamma"),
	mw("delta", "\\delta"),
	mw("zeta", "\\zeta"),
	mw("eta", "\\eta"),
	mw("theta", "\\theta"),
	mw("iota", "\\iota"),
	mw("kappa", "\\kappa"),
	mw("sigma", "\\sigma"),
	mw("omega", "\\omega"),
	mw("phi", "\\phi"),
	mw("psi", "\\psi"),
	mw("chi", "\\chi"),
	mw("rho", "\\rho"),
	mw("mu", "\\mu"),
	mw("nu", "\\nu"),
	mw("tau", "\\tau"),
	mw("Gamma", "\\Gamma"),
	mw("Delta", "\\Delta"),
	mw("Theta", "\\Theta"),
	mw("Lambda", "\\Lambda"),
	mw("Sigma", "\\Sigma"),
	mw("Phi", "\\Phi"),
	mw("Psi", "\\Psi"),
	mw("Omega", "\\Omega"),
	mw("Xi", "\\Xi"),

	------------------------------------------------------------------------
	-- DECORATORS
	------------------------------------------------------------------------
	s({
		trig = "([%a])hat",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\hat{" .. snip.captures[1] .. "}"
		end),
	}, { condition = in_math }),

	s({
		trig = "([%a])bar",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\bar{" .. snip.captures[1] .. "}"
		end),
	}, { condition = in_math }),

	s({
		trig = "([%a])vec",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\vec{" .. snip.captures[1] .. "}"
		end),
	}, { condition = in_math }),

	s({
		trig = "([%a])dot",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\dot{" .. snip.captures[1] .. "}"
		end),
	}, { condition = in_math }),

	s({
		trig = "([%a])tilde",
		snippetType = "autosnippet",
		wordTrig = false,
		regTrig = true,
	}, {
		f(function(_, snip)
			return "\\tilde{" .. snip.captures[1] .. "}"
		end),
	}, { condition = in_math }),

	------------------------------------------------------------------------
	-- COMMON OPERATIONS
	------------------------------------------------------------------------
	s({ trig = "sqrt", snippetType = "autosnippet", wordTrig = true }, {
		t("\\sqrt{"),
		i(1),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "//", snippetType = "autosnippet", wordTrig = false }, {
		t("\\dfrac{"),
		i(1),
		t("}{"),
		i(2),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "sum", snippetType = "autosnippet", wordTrig = true }, {
		t("\\displaystyle\\sum_{"),
		i(1, "i=1"),
		t("}^{"),
		i(2, "n"),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "prod", snippetType = "autosnippet", wordTrig = true }, {
		t("\\displaystyle\\prod_{"),
		i(1),
		t("}^{"),
		i(2),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "lim", snippetType = "autosnippet", wordTrig = true }, {
		t("\\displaystyle\\lim_{"),
		i(1, "n"),
		t("\\to "),
		i(2, "\\infty"),
		t("}"),
	}, { condition = in_math }),

	s({ trig = "int", snippetType = "autosnippet", wordTrig = true }, {
		t("\\displaystyle\\int_{"),
		i(1),
		t("}^{"),
		i(2),
		t("}"),
	}, { condition = in_math }),

	------------------------------------------------------------------------
	-- LOGIC
	------------------------------------------------------------------------
	mw("and", "\\land"),
	mw("or", "\\lor"),
	mw("not", "\\neg"),
	mw("=>", "\\implies"),
	mw("<=>", "\\iff"),
	mw("->", "\\to"),
	mw("<-", "\\leftarrow"),
	mw("top", "\\top"),
	mw("bot", "\\bot"),
	mw("forall", "\\forall"),
	mw("exists", "\\exists"),
	mw("nexists", "\\nexists"),

	------------------------------------------------------------------------
	-- TURNSTILES
	------------------------------------------------------------------------
	mw("|-", "\\vdash"),
	mw("|=", "\\models"),
	mw("|/-", "\\nvdash"),
	mw("-|", "\\dashv"),

	------------------------------------------------------------------------
	-- RELATIONS
	------------------------------------------------------------------------
	mw("!=", "\\neq"),
	mw("<=", "\\leq"),
	mw(">=", "\\geq"),
	mw("~=", "\\simeq"),
	mw("~~", "\\approx"),
	mw("==", "\\equiv"),
	mw("~", "\\sim"),

	------------------------------------------------------------------------
	-- SETS
	------------------------------------------------------------------------
	mw("inn", "\\in"),
	mw("notin", "\\notin"),
	mw("sub", "\\subseteq"),
	mw("sup", "\\supseteq"),
	mw("union", "\\cup"),
	mw("intersec", "\\cap"),
	mw("\\\\", "\\setminus"),
	mw("emp", "\\emptyset"),

	mw("NN", "\\mathbb{N}"),
	mw("RR", "\\mathbb{R}"),
	mw("ZZ", "\\mathbb{Z}"),
	mw("QQ", "\\mathbb{Q}"),
	mw("CC", "\\mathbb{C}"),
	mw("FF", "\\mathbb{F}"),
	mw("EE", "\\mathbb{E}"),
	mw("PP", "\\mathbb{P}"),
	mw("HH", "\\mathbb{H}"),

	mw("cA", "\\mathcal{A}"),
	mw("cB", "\\mathcal{B}"),
	mw("cC", "\\mathcal{C}"),
	mw("cD", "\\mathcal{D}"),
	mw("cE", "\\mathcal{E}"),
	mw("cF", "\\mathcal{F}"),
	mw("cG", "\\mathcal{G}"),
	mw("cH", "\\mathcal{H}"),
	mw("cL", "\\mathcal{L}"),
	mw("cM", "\\mathcal{M}"),
	mw("cN", "\\mathcal{N}"),
	mw("cO", "\\mathcal{O}"),
	mw("cP", "\\mathcal{P}"),
	mw("cR", "\\mathcal{R}"),
	mw("cS", "\\mathcal{S}"),
	mw("cT", "\\mathcal{T}"),
	mw("cU", "\\mathcal{U}"),
	mw("cV", "\\mathcal{V}"),
	mw("cW", "\\mathcal{W}"),

	------------------------------------------------------------------------
	-- MISC
	------------------------------------------------------------------------
	mw("inf", "\\infty"),
	mw("nabla", "\\nabla"),
	mw("part", "\\partial"),
	mw("ldots", "\\ldots"),
	mw("cdots", "\\cdots"),
	mw("cdot", "\\cdot"),
	mw("times", "\\times"),
	mw("oplus", "\\oplus"),
	mw("otimes", "\\otimes"),
	mw("map", "\\mapsto"),
	mw("inj", "\\hookrightarrow"),
	mw("surj", "\\twoheadrightarrow"),
	mw("lra", "\\longrightarrow"),

	------------------------------------------------------------------------
	-- MODAL LOGIC / PRSPDL
	------------------------------------------------------------------------
	-- Diamond and box symbols
	mw("dia", "\\Diamond"),
	mw("box", "\\Box"),

	-- Diamond with program: \langle pi \rangle
	s({ trig = "ldiam", snippetType = "autosnippet", wordTrig = true }, {
		t("\\langle "),
		i(1, "\\pi"),
		t(" \\rangle"),
	}, { condition = in_math }),

	-- Box with program: [pi]
	s({ trig = "lbox", snippetType = "autosnippet", wordTrig = true }, {
		t("["),
		i(1, "\\pi"),
		t("]"),
	}, { condition = in_math }),

	-- Angle brackets with cursor inside: <>
	s({ trig = "<>", snippetType = "autosnippet", wordTrig = false }, {
		t("\\langle "),
		i(1),
		t(" \\rangle"),
	}, { condition = in_math }),

	-- Square brackets with cursor inside: []
	s({ trig = "[]", snippetType = "autosnippet", wordTrig = false }, {
		t("["),
		i(1),
		t("]"),
	}, { condition = in_math }),

	mw("Rpi", "R_{\\pi}"),

	s({ trig = "sat", snippetType = "autosnippet", wordTrig = true }, {
		t("\\mathcal{M}, "),
		i(1, "s"),
		t(" \\models "),
		i(2),
	}, { condition = in_math }),

	------------------------------------------------------------------------
	-- MATH MODE
	------------------------------------------------------------------------
	s({ trig = ";mk", snippetType = "autosnippet", wordTrig = true }, {
		t("\\( "),
		i(1),
		t(" \\)"),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";dm", snippetType = "autosnippet", wordTrig = true }, {
		t({ "\\[", "    " }),
		i(1),
		t({ "", "\\]", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";ali", snippetType = "autosnippet", wordTrig = true }, {
		t({ "\\begin{align*}", "    " }),
		i(1),
		t({ "", "\\end{align*}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";eq", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{equation}\\label{eq:"),
		i(1, "label"),
		t({ "}", "    " }),
		i(2),
		t({ "", "\\end{equation}", "" }),
		i(0),
	}, { condition = not_math }),

	------------------------------------------------------------------------
	-- THEOREM ENVIRONMENTS
	------------------------------------------------------------------------
	s({ trig = ";thm", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{theorem}["),
		i(1, "Title"),
		t({ "]", "    " }),
		i(2),
		t({ "", "\\end{theorem}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";lem", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{lemma}["),
		i(1, "Title"),
		t({ "]", "    " }),
		i(2),
		t({ "", "\\end{lemma}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";prop", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{proposition}["),
		i(1, "Title"),
		t({ "]", "    " }),
		i(2),
		t({ "", "\\end{proposition}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";def", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{definition}["),
		i(1, "Title"),
		t({ "]", "    " }),
		i(2),
		t({ "", "\\end{definition}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";prf", snippetType = "autosnippet", wordTrig = true }, {
		t({ "\\begin{proof}", "    " }),
		i(1),
		t({ "", "\\end{proof}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";crl", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{corollary}["),
		i(1, "Title"),
		t({ "]", "    " }),
		i(2),
		t({ "", "\\end{corollary}", "" }),
		i(0),
	}, { condition = not_math }),

	s({ trig = ";beg", snippetType = "autosnippet", wordTrig = true }, {
		t("\\begin{"),
		i(1, "env"),
		t({ "}", "    " }),
		i(2),
		t({ "", "\\end{" }),
		f(function(args)
			return args[1][1]
		end, { 1 }),
		t("}"),
		i(0),
	}, { condition = not_math }),

	------------------------------------------------------------------------
	-- LABEL
	------------------------------------------------------------------------
	s({ trig = ";lab", snippetType = "autosnippet", wordTrig = true }, {
		t("\\label{"),
		i(1),
		t("}"),
		i(0),
	}, { condition = not_math }),
}
