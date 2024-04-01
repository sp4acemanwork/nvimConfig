local opts = {noremap = true, silent = false}

local term_opts = {silent = true}

--keymap abrev
local keymap = vim.api.nvim_set_keymap

-- remap space as leader key 
keymap("","<Space>", "<Nop>" ,opts)
vim.g.mapleader = " "
vim.g.localleader = " "

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",
--


-- Normal --
-- Better window nav

keymap("n","<C-h>","<C-w>h", opts)
keymap("n","<C-j>","<C-w>j", opts)
keymap("n","<C-k>","<C-w>k", opts)
keymap("n","<C-l>","<C-w>l", opts)

keymap("n","<leader>e",":Lex 30<cr>", opts)

-- split keybinds
keymap("n","<C-s><C-r>",":vsplit<cr>", opts)

keymap("n","<C-s><C-d>",":split<cr>", opts)
--resize keybinds

keymap("n","<C-Up>",":resize +2<CR>",opts)
keymap("n","<C-Down>",":resize -2<CR>",opts)
keymap("n","<C-Left>",":vertical resize -2<CR>",opts)
keymap("n","<C-Right>",":vertical resize +2<CR>",opts)
-- Nav buffer
keymap("n","<S-l>",":bnext<cr>", opts)
keymap("n","<S-h>",":bprevious<cr>", opts)
-- something to try later
keymap("i","jk","<ESC>", opts)

keymap("i","jk","<ESC>", opts)
keymap("i","jk","<ESC>", opts)

--visual 

keymap("v","<","<gv", opts)
keymap("v",">",">gv", opts)


