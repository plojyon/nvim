
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

-- Treesitter config {{{
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
	  "lua",
	  "vim",
	  "vimdoc",
	  "query",
	  "markdown",
	  "markdown_inline",
	  "python",
	  "yaml",
	  "hcl",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- }}}

