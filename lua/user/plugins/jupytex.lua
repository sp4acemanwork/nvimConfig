return {
	"GCBallesteros/jupytext.nvim",
	config = function()
		local status_ok, jupytext = pcall(require("jupytext").setup, {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		})

		if not status_ok then
			vim.error("Error occured loading jupytext")
		end
	end,

	--
	-- Depending on your nvim distro or config you may need to make the loading not lazy
	-- lazy=false,
}
