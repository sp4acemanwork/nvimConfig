vim.lsp.config("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				jedi = {},
				jedi_definition = {
					enabled = true,
					follow_imports = true,
					follow_builtin_imports = true,
				},
				jedi_completion = {
					enabled = true,
					include_params = true,
					include_class_objects = true,
				},
				pycodestyle = {
					ignore = { "E501", "W391" },
				},
			},
		},
	},
})
