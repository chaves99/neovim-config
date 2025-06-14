local dataDir = "/home/vinicius/.local/state/nvim/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

return {
    "mfussenegger/nvim-jdtls",
    opts = {
        cmd = {
            '/home/vinicius/Workspace/jdk/jdk-21.0.6/bin/java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:/opt/jdtls/lombok.jar',
            '-jar', '/opt/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar',
            '-configuration', '/opt/jdtls/config_linux/',
            '-data', dataDir,
        },

        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

        settings = {
            init_options = {
                bundles = {
                    "/opt/jdtls/lombok.jar",
                },
            },
            java = {
                jdt = {
                    ls = {
                        lombokSupport = { enabled = true },
                    },
                },
                autoBuild = { enabled = true },
                configuration = {
                    updateBuildConfiguration = "interactive",
                    runtimes = {
                        {
                            name = "JavaSE-1.8",
                            path = "/opt/jdk-corretto-8.442.06.1/",
                            default = false,
                            sources = "/opt/jdk-corretto-8.442.06.1/src.zip",
                        },
                        {
                            name = "JavaSE-11",
                            path = "/home/vinicius/Workspace/jdk/jdk-11.0.2/",
                            default = false,
                            sources = "/home/vinicius/Workspace/jdk/jdk-11.0.2/lib/src.zip",
                        },
                        {
                            name = "JavaSE-21",
                            path = "/home/vinicius/Workspace/jdk/jdk-21.0.6/",
                            default = true,
                            sources = "/home/vinicius/Workspace/jdk/jdk-21.0.6/lib/src.zip",
                        },
                        {
                            name = "JavaSE-23",
                            path = "/home/vinicius/Workspace/jdk/jdk-23.0.2/",
                            default = false,
                            sources = "/home/vinicius/Workspace/jdk/jdk-23.0.2/lib/src.zip",
                        }
                    }
                },
                eclipse = { downloadSources = true },
                maven = { downloadSources = true },
                references = { includeDecompiledSources = true },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
            }
        },
    },
    config = function(_, opts)
        -- vim api auto-command to start_or_attach this only for java
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- prints and pcall are there only to give quick feedback if it works.
                local success, result = pcall(require('jdtls').start_or_attach, opts)
                if success then
                else
                    print("Error starting JDTLS: " .. tostring(result))
                end
            end
        })

        -- REMAP FOR JAVA

        vim.keymap.set("n", "<leader>oi", require("jdtls").organize_imports)
    end
}
