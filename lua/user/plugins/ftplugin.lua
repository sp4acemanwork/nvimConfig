-- ~/.config/nvim/lua/user/plugins/ftplugin.lua

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    if vim.g.jdtls_autocmd_created then
      return
    end
    vim.api.nvim_create_autocmd("FileType", {

      pattern = {"java"},
      callback = function()
        local jdtls = require("jdtls")

        -- Detect the project root (git, Maven, or Gradle)
        local root_dir = require("jdtls.setup").find_root({'.git', 'pom.xml', 'mvnw', 'build.sbt'})
        if not root_dir then
          vim.notify("JDTLS: No project root found, skipping LSP", vim.log.levels.WARN)
          return
        end

        -- Unique workspace folder per project
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace") .. "/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

        -- Ensure host JVM / Maven paths (macOS)
        local jdtls_cmd = {
          vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/bin/jdtls"),
          "-configuration", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_mac"),
          "-data", workspace_dir,
        }

        -- Configure LSP
        local config = {
          cmd = jdtls_cmd,
          root_dir = root_dir,
          settings = {
            java = {
              -- Optional: include Maven dependencies automatically
              -- If you have additional JARs in lib/, you can add them here
              -- project = { referencedLibraries = { vim.fn.glob(root_dir .. "/lib/*.jar", true) } }
            }
          },
          on_attach = function(client, bufnr)
            vim.notify("JDTLS: Attached to " .. client.name, vim.log.levels.INFO)
            -- You can set up keymaps here if desired
          end,
        }

        -- Start or attach a single LSP per project root
        jdtls.start_or_attach(config)
      end,
    })
  end,
}

