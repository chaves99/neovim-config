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
        init_options = {
            bundles = {
                "/opt/jdtls/lombok.jar",
                "/opt/vscode-java-test/server/com.microsoft.java.test.plugin-0.43.1.jar",
                "/opt/vscode-java-test/server/com.microsoft.java.test.runner-jar-with-dependencies.jar",
                "/opt/vscode-java-test/server/jacocoagent.jar",
                "/opt/vscode-java-test/server/junit-jupiter-api_5.11.0.jar",
                "/opt/vscode-java-test/server/junit-jupiter-engine_5.11.0.jar",
                "/opt/vscode-java-test/server/junit-jupiter-migrationsupport_5.11.0.jar",
                "/opt/vscode-java-test/server/junit-jupiter-params_5.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-commons_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-engine_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-launcher_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-runner_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-suite-api_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-suite-commons_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-platform-suite-engine_1.11.0.jar",
                "/opt/vscode-java-test/server/junit-vintage-engine_5.11.0.jar",
                "/opt/vscode-java-test/server/org.apiguardian.api_1.1.2.jar",
                "/opt/vscode-java-test/server/org.eclipse.jdt.junit4.runtime_1.3.100.v20231214-1952.jar",
                "/opt/vscode-java-test/server/org.eclipse.jdt.junit5.runtime_1.1.300.v20231214-1952.jar",
                "/opt/vscode-java-test/server/org.jacoco.core_0.8.13.202504020838.jar",
                "/opt/vscode-java-test/server/org.opentest4j_1.3.0.jar",
                vim.fn.glob(
                    "/opt/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
            },
        },

        settings = {
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
        local jdtls = require("jdtls")
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                local success, result = pcall(jdtls.start_or_attach, opts)
                if success then
                else
                    print("Error starting JDTLS: " .. tostring(result))
                end
            end
        })
        -- REMAP FOR JAVA
        vim.keymap.set("n", "<leader>oi", jdtls.organize_imports)
        vim.keymap.set("n", "<leader>vv", jdtls.extract_variable)
        vim.keymap.set("n", "<leader>rm", require("jdtls.dap").setup_dap_main_class_configs)
    end
}
