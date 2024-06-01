require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
-- Function to set terminal keymaps
local function set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', vim.cmd.wincmd("h"), opts)
    vim.keymap.set('t', '<C-j>', vim.cmd.wincmd("j"), opts)
    vim.keymap.set('t', '<C-k>', vim.cmd.wincmd("k"), opts)
    vim.keymap.set('t', '<C-l>', vim.cmd.wincmd("l"), opts)
end

-- Autocmd for TermOpen
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = [[term://*]],
    callback = set_terminal_keymaps
})

require "plugins"
