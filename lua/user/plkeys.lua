local keymap = vim.keymap

local status_ok, treekey = pcall(function()
	keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
	keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
	keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
	keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
end)
if not status_ok then
	vim.notify("Error occured loading tree sitter keymaps: falure to load plugin?")
end
--telescope keys
local status_ok, tlscp = pcall(function()
	local builtin = require("telescope.builtin")
	keymap.set("n", "<leader>ff", builtin.find_files, {})
	keymap.set("n", "<leader>fg", builtin.live_grep, {})
	keymap.set("n", "<leader>fb", builtin.buffers, {})
	keymap.set("n", "<leader>fh", builtin.help_tags, {})
end)
if not status_ok then
	vim.notify("telescope is broken")
end
local status_ok, troublekeymap = pcall(function()
	local trouble = require("trouble")
	keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
	keymap.set(
		"n",
		"<leader>xX",
		"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
		{ desc = "Buffer Diagnostics (Trouble)" }
	)
	keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
	keymap.set(
		"n",
		"<leader>cl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
		{ desc = "LSP Definitions / References (Trouble)" }
	)
	keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
	keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
end)
if not status_ok then
	vim.notify("An Error has occured setting keymap for trouble")
end
