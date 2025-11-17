vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- noob helpers {{{
--vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true })
--vim.keymap.set('n', '\'', ':vsplit<CR>', { noremap = true })
--vim.keymap.set('n', '"', ':split<CR>', { noremap = true })
--vim.keymap.set('n', 't', ':terminal<CR>', { noremap = true })
--vim.keymap.set('n', '<C-b>z', function()
--	local buf = vim.api.nvim_get_current_buf()
--	vim.cmd('tabnew')
--	vim.api.nvim_set_current_buf(buf)
--end, { noremap = true, silent = true })
-- }}}

-- gitsigns (<leader>h) {{{
local gitsigns = require("gitsigns")

require('gitsigns').setup{
	on_attach = function(bufnr)
		local gitsigns = require('gitsigns')

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

	-- Navigation
	map('n', ']h', function()
		if vim.wo.diff then
			vim.cmd.normal({']h', bang = true})
		else
			gitsigns.nav_hunk('next')
		end
	end)
	map('n', '[h', function()
		if vim.wo.diff then
			vim.cmd.normal({'[h', bang = true})
		else
			gitsigns.nav_hunk('prev')
		end
	end)

	-- Open git tab
	map('n', '<leader>hh', function()
		gitsigns.setqflist("all")
		--gitsigns.setqflist("all", { open = false })
		--vim.cmd("rightbelow vertical 40copen")
		--vim.wo.wrap = false
	end)

	-- Stage/reset
	map('n', '<leader>hs', gitsigns.stage_hunk)
	map('n', '<leader>hr', gitsigns.reset_hunk)

	-- Stage/reset (visual)
	map('v', '<leader>hs', function()
		gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
	end)
	map('v', '<leader>hr', function()
		gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
	end)

	-- Stage/reset whole file
	map('n', '<leader>hS', gitsigns.stage_buffer)
	map('n', '<leader>hR', gitsigns.reset_buffer)

	-- Preview
	map('n', '<leader>hp', gitsigns.preview_hunk)
	map('n', '<leader>hi', gitsigns.preview_hunk_inline)

	-- Blame
	map('n', '<leader>hb', function()
		gitsigns.blame_line({ full = true })
	end)

	-- Diff
	map('n', '<leader>hd', gitsigns.diffthis)
	map('n', '<leader>hD', function()
		gitsigns.diffthis('HEAD')
	end)
	end
}
-- }}}

-- Format on save {{{
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !black --quiet %")            
            vim.cmd("edit")
        end,
    }
)
-- }}}

