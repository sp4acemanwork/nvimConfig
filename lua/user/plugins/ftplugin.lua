return {
"mfussenegger/nvim-jdtls",
config = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java", -- Only run for Java files
    callback = function(args)
      local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' }
      local root_dir = require('jdtls.setup').find_root(root_markers)
      if root_dir == nil then
        return
      end

      local jdtls_config = {
        -- This uses the standard command provided by nvim-jdtls,
        -- which correctly finds the java executable managed by mason.
        cmd = require('jdtls').java_cmd(),
        root_dir = root_dir,

        -- These settings enable Maven/Gradle support
        init_options = {
          java = {
            import = {
              gradle = { enabled = true },
              maven = { enabled = true }
            },
            autobuild = {
              enabled = true,
            },
          },
        },

        -- on_attach function to run when the server connects to a buffer
        on_attach = function(client, attach_bufnr)
          vim.notify("JDTLS attached to project: " .. root_dir, vim.log.levels.INFO)
        end,
      }

      require("jdtls").start_or_attach(jdtls_config)
    end,
  })
end,
}
