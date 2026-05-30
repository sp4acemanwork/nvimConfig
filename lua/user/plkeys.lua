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

local status_ok, moltenkeys = pcall(function()
	keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
	keymap.set("n", "<leader>o", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
	keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
	keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
	keymap.set(
		"v",
		"<leader>r",
		":<C-u>MoltenEvaluateVisual<CR>gv",
		{ silent = true, desc = "evaluate visual selection" }
	)
	keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
	keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
	keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })
	keymap.set("n", "<leader>ik", ":moltenInterrupt<CR>", { desc = "interrupt kernal", silent = true })
	keymap.set(
		"v",
		"<leader>r",
		":<C-u>MoltenEvaluateVisual<CR>gv",
		{ desc = "execute visual selection", silent = true }
	)
	keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
	keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

	-- if you work with html outputs:
	keymap.set("n", "<leader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })
	keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
	keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
end)
if not status_ok then
	vim.notify("An Error has occured setting keymap for trouble")
end
