vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = a
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Nvim has no direct connection to the system clipboard. Instead it depends on
--a |provider| which transparently uses shell commands to communicate with the
--system clipboard or any other clipboard "backend".
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.o.swapfile = false
vim.opt.undofile = true

vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.opt.confirm = true

-- TIP: Disable arrow keys in normal mode
 vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
 vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
 vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
 vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)



-- keymaps in vim 
vim.keymap.set('n', 'ex', ':Neotree toggle<CR>', {silent =true , desc = "Toggles the neotree file explorer"})
vim.keymap.set("i", "kk", "<Esc>", { silent = true, noremap = true })

-- Dont like the ~ that vim does, instead just give space
vim.opt.fillchars:append({ eob = " " })
require('config.lazy')




