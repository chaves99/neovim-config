return {
    'mfussenegger/nvim-dap',
    opts = {},
    config = function()
        local dap = require("dap")
        dap.configurations.java = { {
            type = 'java',
            request = 'attach',
            name = "Debug (5005) - Remote",
            hostName = "127.0.0.1",
            port = 5005,
        } }
    end,
}
