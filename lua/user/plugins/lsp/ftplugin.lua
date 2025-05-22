return {
  "mfussenegger/nvim-jdtls",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java", -- Crucial: Only run for Java files
      callback = function(args)
        local bufnr = args.buf
        local current_file_path = vim.api.nvim_buf_get_name(bufnr)

        -- 1. Determine Project Root Dynamically for the current Java file
        local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' } -- Common project root indicators
        local found_project_roots = vim.fs.find(root_markers, {
          upward = true,
          path = current_file_path,
          stop = vim.loop.os_homedir(), -- Don't go past home directory
          type = "file",
        })

        local determined_root_dir
        if found_project_roots and #found_project_roots > 0 then
          determined_root_dir = vim.fs.dirname(found_project_roots[1])
        else
          determined_root_dir = vim.fn.fnamemodify(current_file_path, ':p:h')
          vim.notify(
            "JDTLS: No project markers found. Using file's directory as root: " .. determined_root_dir,
            vim.log.levels.WARN
          )
        end

        if not determined_root_dir then
          vim.notify("JDTLS: Could not determine project root for " .. current_file_path .. ". JDTLS will not start.", vim.log.levels.ERROR)
          return
        end

        -- 2. Create a JDTLS configuration specific to this project
        local project_name = vim.fn.fnamemodify(determined_root_dir, ':t')
        local workspace_dir = vim.fn.stdpath('data') .. "/jdtls-workspace/" .. project_name

        local jdtls_config = {
          cmd = {
            vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'),
            '-data',
            workspace_dir,
          },
          root_dir = determined_root_dir,
          on_attach = function(client, attach_bufnr)
            vim.notify("JDTLS attached to buffer: " .. attach_bufnr .. " (Project: " .. determined_root_dir .. ")", vim.log.levels.INFO)

            -- Keymappings are handled elsewhere, as per your setup.
            -- You can use this space for other JDTLS-specific initializations
            -- that need to run when the server attaches to a buffer.
            -- For example:
            -- require('jdtls').setup_dap({ hotcodereplace = 'auto' }) -- If you use nvim-dap
            -- require('jdtls.dap').setup_dap_main_class_configs() -- If using nvim-dap for main class execution
            -- require('jdtls.setup').add_commands() -- Adds JDTLS specific commands like JdtCompile, JdtUpdateConfig, etc.

            -- If you have custom UI handlers or other specific setups for nvim-jdtls:
            -- require('jdtls.ui').setup_handlers({ client_id = client.id })
          end,
          -- init_options = {
          --   bundles = {}, -- Add paths to any custom lombok.jar or other bundles if needed
          --   extendedClientCapabilities = require('jdtls').extendedClientCapabilities -- If needed by other JDTLS features
          -- },
          -- capabilities = require('cmp_nvim_lsp').default_capabilities(), -- If using nvim-cmp for completion
        }

        vim.notify("JDTLS: Attempting to start/attach for project at: " .. determined_root_dir, vim.log.levels.INFO)

        -- 3. Safely start or attach JDTLS
        local status_ok, result = pcall(require("jdtls").start_or_attach, jdtls_config)

        if not status_ok then
          vim.notify("JDTLS: FAILED to start/attach. Error: " .. tostring(result), vim.log.levels.ERROR)
        else
          if result then
            vim.notify("JDTLS: start_or_attach successful. Client/Result: " .. vim.inspect(result), vim.log.levels.INFO)
          else
            vim.notify("JDTLS: start_or_attach called, but returned nil/false. This might be okay if already attached.", vim.log.levels.WARN)
          end
        end
      end,
    })
  end,
}
