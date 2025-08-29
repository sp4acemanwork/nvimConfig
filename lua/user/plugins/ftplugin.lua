return {
  "mfussenegger/nvim-jdtls",
  config = function()
    -- =================== REMOTE CONFIGURATION ===================
    -- Set the parent directory on your Mac that contains all shared projects.
    local HOST_PROJECTS_BASE_PATH = vim.fn.expand('~/vsc/cloud-comp')

    -- Set the corresponding parent directory where projects are mounted/located inside the VM.
    -- IMPORTANT: Run `pwd` in this directory inside your VM to get the correct absolute path.
    local VM_PROJECTS_BASE_PATH = "/media/share/cloud-comp" -- <-- VERIFY THIS PATH
    -- ==========================================================

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java", -- Only run for Java files
      callback = function(args)
        local bufnr = args.buf
        local current_file_path = vim.api.nvim_buf_get_name(bufnr)

        -- 1. Determine Project Root Dynamically
        local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' }
        local found_project_roots = vim.fs.find(root_markers, {
          upward = true,
          path = current_file_path,
          stop = vim.loop.os_homedir(),
          type = "file",
        })

        local determined_root_dir
        if found_project_roots and #found_project_roots > 0 then
          determined_root_dir = vim.fs.dirname(found_project_roots[1])
        else
          determined_root_dir = vim.fn.fnamemodify(current_file_path, ':p:h')
        end

        if not determined_root_dir then
          vim.notify("JDTLS: Could not determine project root. JDTLS will not start.", vim.log.levels.ERROR)
          return
        end

        local project_name = vim.fn.fnamemodify(determined_root_dir, ':t')
        local host_workspace_dir = vim.fn.stdpath('data') .. "/jdtls-workspace/" .. project_name

        local final_root_dir = determined_root_dir
        local final_workspace_dir = host_workspace_dir

        -- 2. Check if the project is in the shared directory and needs path mapping
        if determined_root_dir:find(HOST_PROJECTS_BASE_PATH, 1, true) then
          vim.notify("JDTLS: Remote project detected. Translating paths.", vim.log.levels.INFO)
          -- Translate the project root and workspace paths for the VM
          final_root_dir = determined_root_dir:gsub(HOST_PROJECTS_BASE_PATH, VM_PROJECTS_BASE_PATH, 1)
          final_workspace_dir = host_workspace_dir:gsub(vim.fn.expand('~'), '/home/debian', 1)
        else
          vim.notify("JDTLS: Local project detected. Using local paths.", vim.log.levels.INFO)
        end

        -- 3. Create the JDTLS configuration
        local jdtls_config = {
          cmd = {
            vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'),
            '-data',
            final_workspace_dir,
          },
          root_dir = final_root_dir,
          on_attach = function(client, attach_bufnr)
            vim.notify("JDTLS attached to project: " .. final_root_dir, vim.log.levels.INFO)
            -- Your on_attach logic can go here
          end,
          -- Other settings...
        }

        require("jdtls").start_or_attach(jdtls_config)
      end,
    })
  end,
}
