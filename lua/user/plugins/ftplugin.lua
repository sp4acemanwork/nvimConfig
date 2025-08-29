
-- In your local ~/.config/nvim/lua/user/plugins/ftplugin.lua

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        -- === Configuration for Remote (Docker) Projects ===
        -- This is the path to your shared projects on your LOCAL MAC
        local HOST_PROJECTS_BASE_PATH = vim.fn.expand('~/vsc/cloud-comp') -- Adjust if needed

        -- This is the corresponding path INSIDE the Docker container
        local CONTAINER_PROJECTS_BASE_PATH = "/home/developer/projects"
        -- =================================================

        local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
        if not root_dir then 
          vim.notify("JDTLS: No root_dir found, skipping setup", vim.log.levels.WARN)
          return 
        end

        local config

        -- Check if the current project is inside your special shared directory
        if root_dir:find(HOST_PROJECTS_BASE_PATH, 1, true) then
          -- IT IS: Use the remote Docker LSP
          vim.notify("JDTLS: Remote project detected. Connecting to container (tcp://127.0.0.1:8080)...", vim.log.levels.INFO)

          -- Translate the local root_dir to the path the container understands
          local final_root_dir = root_dir:gsub(HOST_PROJECTS_BASE_PATH, CONTAINER_PROJECTS_BASE_PATH, 1)
          vim.notify("JDTLS: Using remote root_dir → " .. final_root_dir, vim.log.levels.INFO)

          config = {
            cmd_type = 'tcp',
            host = '127.0.0.0.1',
            port = 8080,
            root_dir = final_root_dir,
          }
        else
          -- IT IS NOT: Fall back to a standard local LSP
          vim.notify("JDTLS: Local project detected. Starting local server...", vim.log.levels.INFO)
          vim.notify("JDTLS: Using local root_dir → " .. root_dir, vim.log.levels.INFO)

          config = {
            -- The standard command to run a local jdtls instance
            cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
            root_dir = root_dir,
          }
        end

        -- Attach any common settings or keymaps here
        config.on_attach = function(client, bufnr)
          vim.notify("JDTLS: Attached to client " .. client.name .. " (id=" .. client.id .. ")", vim.log.levels.INFO)
        end

        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}

