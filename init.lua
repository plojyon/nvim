require('options')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
	-- color scheme
	"tanvirtin/monokai.nvim",

	-- completion (blink.cmp) {{{ 
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",
		opts = {
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			keymap = {
				preset = "none",
				-- commands must be one of: {{{
				-- fallback
				-- fallback_to_mappings
				-- show
				-- show_and_insert
				-- show_and_insert_or_accept_single
				-- hide
				-- cancel
				-- accept
				-- accept_and_enter
				-- select_and_accept
				-- select_accept_and_enter
				-- select_prev
				-- select_next
				-- insert_prev
				-- insert_next
				-- show_documentation
				-- hide_documentation
				-- scroll_documentation_up
				-- scroll_documentation_down
				-- show_signature
				-- hide_signature
				-- scroll_signature_up
				-- scroll_signature_down
				-- snippet_forward
				-- snippet_backward
				-- or false to disable
				-- }}}
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-y>"] = { "accept" },
				["<C-e>"] = { "hide" },
				["<C-Space>"] = { "show" },
			},
			appearance = { nerd_font_variant = "mono" },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			completion = {
				keyword = { range = "prefix" },
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				trigger = { show_on_trigger_character = true },
				documentation = { auto_show = true },
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
	-- completion (blink.cmp) }}}

	-- multicursor (jake-stewart) {{{
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set
			-- Add or skip adding a new cursor by matching word/selection
			set({"n", "x", "i"}, "<C-d>", function() mc.matchAddCursor(1) end)
			-- most terminals can't reliably differentiate C-d from C-D
			--set({"n", "x", "i"}, "<C-S-D>", function() mc.matchAddCursor(-1) end)

			-- Add and remove cursors with control + left click.
			--set("n", "<c-leftmouse>", mc.handleMouse)
			--set("n", "<c-leftdrag>", mc.handleMouseDrag)
			--set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Disable and enable cursors.
			set({"n", "x"}, "<c-q>", mc.toggleCursor)

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)

				-- Select a different cursor as the main one.
				layerSet({"n", "x"}, "<leader><left>", mc.prevCursor)
				layerSet({"n", "x"}, "<leader><right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { reverse = true })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn"})
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { reverse = true })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
		end
	},
	-- }}}

	-- visual whitespace {{{
	{
		'mcauley-penney/visual-whitespace.nvim',
		config = true,
		event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
		opts = {},
	},
	-- visual whitespace }}}

	-- neo-tree  {{{
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- optional, but recommended
			"nvim-tree/nvim-web-devicons",
		},
		-- neo-tree will lazily load itself
		lazy = false,
		config = {
			close_if_last_window = true,
			enable_git_status = true,
		},
	},
	-- }}}

	-- Fancy qflist (trouble) {{{
	{ "folke/trouble.nvim", opts = {}, cmd = "Trouble" },
	-- }}}

	-- Git {{{
	{ "tpope/vim-fugitive" },
	{ "junegunn/gv.vim" },
	{
		"lewis6991/gitsigns.nvim",
		opts = { current_line_blame = true },
		config = { trouble = true },
	},
	-- }}}

	-- LSP manager
	{ "mason-org/mason.nvim", opts = {} },

	-- LSP for helm
	{ "qvalentin/helm-ls.nvim", ft = "helm" },

	-- copilot
	{ "github/copilot.vim" },
})

require('keymaps')
require('colorscheme')
require('lsp')


