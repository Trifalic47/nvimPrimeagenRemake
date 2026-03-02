vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
    local buffer = args.buf

    local wid = nil
    local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
    for _, win_id in ipairs(win_ids) do
        local win_bufnr = vim.api.nvim_win_get_buf(win_id)
        if win_bufnr == buffer then
            wid = win_id
        end
    end

    if wid == nil then
        return
    end

    vim.schedule(function()
        if vim.api.nvim_win_is_valid(wid) then
            vim.api.nvim_set_current_win(wid)
        end
    end)
end

local function create_nav_options(name)
    return {
        group = "DapGroup",
        pattern = string.format("*%s*", name),
        callback = navigate
    }
end

return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            local dap = require("dap")
            dap.set_log_level("DEBUG")

            local function compile_c()
                local file = vim.fn.expand("%:p")
                local out = vim.fn.expand("%:p:r")
                local cmd = string.format("gcc -g %s -o %s", vim.fn.shellescape(file), vim.fn.shellescape(out))
                print("Compiling: " .. cmd)
                local result = vim.fn.system(cmd)
                if vim.v.shell_error ~= 0 then
                    print("Compilation failed: " .. result)
                    return nil
                end
                return out
            end

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
            vim.keymap.set("n", "<leader>dC", dap.clear_breakpoints, { desc = "Debug: Clear All Breakpoints" })

            -- C specific "Quick Run"
            vim.keymap.set("n", "<leader>dcR", function()
                local exe = compile_c()
                if exe then
                    dap.run({
                        type = "cppdbg",
                        request = "launch",
                        name = "C Quick Debug",
                        program = exe,
                        cwd = "${workspaceFolder}",
                        stopAtEntry = false,
                    })
                end
            end, { desc = "Debug: Compile and Run C" })
        end
    },


    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        position = "left",
                        size = 40,
                    },
                    {
                        elements = {
                            { id = "console", size = 0.5 },
                            { id = "repl", size = 0.5 },
                        },
                        position = "bottom",
                        size = 10,
                    },
                },
            })

            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
            vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Debug: Eval" })

            vim.api.nvim_create_autocmd("BufEnter", {
                group = "DapGroup",
                pattern = "*dap-repl*",
                callback = function()
                    vim.wo.wrap = true
                end,
            })

            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))


            dap.listeners.after.event_initialized.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.listeners.after.event_output.dapui_config = function(_, body)
                if body.category == "console" then
                    dapui.eval(body.output) -- Sends stdout/stderr to Console
                end
            end
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local dap = require("dap")
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "delve",
                    "python",
                    "cpptools",
                },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    delve = function(config)
                        table.insert(config.configurations, 1, {
                            args = function() return vim.split(vim.fn.input("args> "), " ") end,
                            type = "delve",
                            name = "file",
                            request = "launch",
                            program = "${file}",
                            outputMode = "remote",
                        })
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    cppdbg = function(config)
                        local configurations = {
                            {
                                name = "Launch Current File (GDB)",
                                type = "cppdbg",
                                request = "launch",
                                program = function()
                                    return vim.fn.expand("%:p:r")
                                end,
                                cwd = "${workspaceFolder}",
                                stopAtEntry = true,
                                MIMode = "gdb",
                                miDebuggerPath = "/usr/bin/gdb",
                                setupCommands = {
                                    {
                                        text = "-enable-pretty-printing",
                                        description = "enable pretty printing",
                                        ignoreFailures = false,
                                    },
                                },
                            },
                        }
                        config.configurations = configurations
                        require("mason-nvim-dap").default_setup(config)
                        -- Also set it manually to be sure
                        dap.configurations.c = configurations
                        dap.configurations.cpp = configurations
                    end,
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
        config = function()
            local path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
            require("dap-python").setup(path)
        end,
    },
}
