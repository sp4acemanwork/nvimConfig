-- lua/user/plugins/mscala.lua
return {}
--[[return {
  "scalameta/nvim-metals",
  -- Add plenary as a required dependency for nvim-metals
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "scala", "sbt" }, -- Keep this limited to scala and sbt
  opts = function()
    local metals_config = require("metals").bare_config()

    -- This is the most important change.
    -- We are telling Metals to use a specific, compatible Java version
    -- instead of letting it find your system's Java 21.
    -- Make sure the path to your Java 17 or 11 home is correct.
    -- You can find paths with: /usr/libexec/java_home -V
    metals_config.server_settings = {
      ["java-home"] = "/opt/homebrew/opt/openjdk@11", -- Or your path to JDK 11
    }

    metals_config.on_attach = function(client, bufnr)
      -- Your on_attach keymaps can go here if you want them specific to Metals
      -- For example:
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}]]
