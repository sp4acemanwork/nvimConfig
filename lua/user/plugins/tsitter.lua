return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		-- Protected call to avoid crashing if the plugin is missing/corrupted
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not status_ok then
			return
		end

		configs.setup({
			-- 1. Empty list: do not pre-install anything
			ensure_installed = {},

			-- 2. Auto-install parsers when you open a file that needs one
			auto_install = true,

			-- 3. Core highlighting enabled
			sync_install = false,
			ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
