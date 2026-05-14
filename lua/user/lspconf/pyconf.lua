-- pyconf.lua
local cmp_lsp = require("cmp_nvim_lsp")

-- Define the configuration with capabilities
vim.lsp.config("pylsp", {
	-- This line tells the LSP that we have a completion engine ready
	capabilities = cmp_lsp.default_capabilities(),
	settings = {
		pylsp = {
			plugins = {
				jedi_completion = {
					enabled = true,
					include_params = true,
					include_class_objects = true,
				},
				jedi_definition = {
					enabled = true,
					follow_imports = true,
				},
				pycodestyle = {
					ignore = { "E501", "W391" },
				},
			},
		},
	},
})
vim.lsp.enable("pylsp")
