
-- ~/.config/nvim/lua/user/plugins/ftplugin.lua

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"java", "scala"},
      callback = function()
        local jdtls = require("jdtls")

        -- Find the project root (git or Maven/Gradle)
        local root_dir = require("jdtls.setup").find_root({'.git', 'pom.xml', 'mvnw', 'build.sbt'})
        if not root_dir then
          vim.notify("JDTLS: No root_dir found, skipping LSP", vim.log.levels.WARN)
          return
        end

        -- Workspace directory per project
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace") .. "/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

        -- Only start or attach one server per root
        local config = {
          cmd = {
            vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/bin/jdtls"),
            "-configuration", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_mac"), -- adjust per OS
            "-data", workspace_dir,
          },
          root_dir = root_dir,
          settings = {
            java = {}
          },
          on_attach = function(client, bufnr)
            vim.notify("JDTLS: Attached to " .. client.name, vim.log.levels.INFO)
          end,
        }

        jdtls.start_or_attach(config)
      end,
    })
  end,
}

