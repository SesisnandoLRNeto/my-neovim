return {
    {
      "mfussenegger/nvim-jdtls",
      ft = { "java" },
      config = function()
        local jdtls = require("jdtls")
        local mason_registry = require("mason-registry")

        local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
        local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
        local java_test_path = mason_registry.get_package("java-test"):get_install_path()

        local bundles = {}
        vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
   "\n"))
        vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration", jdtls_path .. "/config_mac_arm",
            "-data", vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name,
          },
          root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "build.gradle", "pom.xml" }),
          settings = {
            java = {
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.jupiter.api.Assertions.*",
                  "org.mockito.Mockito.*",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
          init_options = {
            bundles = bundles,
          },
        }

        jdtls.start_or_attach(config)
      end,
    },
  }
