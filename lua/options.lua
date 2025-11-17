
-- use system clipboard
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
-- allow mouse
vim.opt.mouse = 'a'

-- Folds {{{
vim.opt.foldmethod="indent"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vim", "lua" },
  callback = function()
    vim.opt_local.foldmethod = "marker"
	vim.opt_local.foldmarker = "{{{,}}}"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "vim" or vim.bo.filetype == "lua" then return end
    vim.cmd("normal! zR")
  end,
})
-- }}}

-- Tab {{{
-- number of visual spaces per TAB
vim.opt.tabstop = 4
-- number of spaces in tab when editing
vim.opt.softtabstop = 4
-- insert 4 spaces on a tab
vim.opt.shiftwidth = 4
-- tabs are spaces?
vim.opt.expandtab = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.expandtab = true
  end,
})
-- }}}

-- UI config {{{
-- show absolute number
vim.opt.number = true
-- add numbers to each line on the left side
vim.opt.relativenumber = false
-- highlight cursor line underneath the cursor horizontally
vim.opt.cursorline = true
-- open new vertical split bottom
vim.opt.splitbelow = true
-- open new horizontal splits right
vim.opt.splitright = true
-- enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true
-- we are experienced, we don't need the "INSERT" mode hint
vim.opt.showmode = false
-- shift + arrow keys do a selection
vim.opt.keymodel="startsel,stopsel"
-- ruler
vim.opt.colorcolumn="80,100"
-- }}}

-- Searching {{{
-- search as characters are entered
vim.opt.incsearch = true
-- highlight matches
vim.opt.hlsearch = true
-- ignore case in searches by default
vim.opt.ignorecase = true
-- but make it case sensitive if an uppercase is entered
vim.opt.smartcase = true
-- }}}


