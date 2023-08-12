local status_dap, dap = pcall(require, "dap")
if (not status_dap) then return end
local status_dapui, dapui = pcall(require, "dapui")
if (not status_dapui) then return end

local status_dap_go, dap_go = pcall(require, "dap-go")
if (status_dap_go) then dap_go.setup() end

local function dapui_setup()
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

local function dap_keymaps(bufnr)
    bind("n", "<F5>", function() dap.continue() end)
    bind("n", "<F8>", function() dap.toggle_breakpoint() end)
    bind("n", "<S-F8>", function() dap.clear_breakpoints() end)
    bind("n", "<F11>", function() dap.step_into() end)
    bind("n", "<S-F11>", function() dap.step_out() end)
    bind("n", "<F10>", function() dap.step_over() end)
    bind("n", "<S-F10>", function() dap.step_back() end)
    bind("n", "<leader>D", function() dap.terminate() end)

    local api = vim.api
    local keymap_restore = {}
    dap.listeners.after["event_initialized"]["me"] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
            local keymaps = api.nvim_buf_get_keymap(buf, "n")
            for _, keymap in pairs(keymaps) do
                if keymap.lhs == "K" then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, "n", "K")
                end
            end
        end
        api.nvim_set_keymap(
            "n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
            { silent = true })
    end

    dap.listeners.after["event_terminated"]["me"] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        end
        keymap_restore = {}
    end
end

dapui_setup()
dap_keymaps(0)

local status_rt, rt = pcall(require, "rust-tools")
if not status_rt then return end

local extension_path = "/usr/lib/codelldb/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

dap.adapters.codelldb = rt.dap.get_codelldb_adapter(codelldb_path, liblldb_path)

dap.adapters.mix_task = {
    type = "executable",
    command = vim.env.HOME ..
        "/.local/share/nvim/mason/packages/elixir-ls/debugger.sh", -- debugger.bat for windows
    args = {}
}

-- dap.adapters.node2 = {
--     type = "executable",
--     command = "node",
--     args = { os.getenv("HOME") ..
--         "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
-- }

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/",
                "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never" -- avoid to stop in assembly code
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.elixir = {
    {
        type = "mix_task",
        name = "mix test",
        task = "test",
        taskArgs = { "--trace" },
        request = "launch",
        startApps = true, -- for Phoenix projects
        projectDir = "${workspaceFolder}",
        requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs"
        }
    },
}

-- dap.configurations.javascript = {
--     {
--         name = "Launch",
--         type = "node2",
--         request = "launch",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         console = "integratedTerminal",
--     },
--     {
--         -- For this to work you need to make sure the node process is
--         -- started with the `--inspect` flag.
--         name = "Attach to process",
--         type = "node2",
--         request = "attach",
--         processId = require "dap.utils".pick_process,
--     },
-- }

-- require("dap-vscode-js").setup({
--     -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--     -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
--     -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
--     adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal",
--         "pwa-extensionHost" }, -- which adapters to register in nvim-dap
--     -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
--     -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
--     -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
-- })

-- for _, language in ipairs({ "typescript", "javascript" }) do
--     dap.configurations[language] = {
--         {
--             {
--                 type = "pwa-node",
--                 request = "launch",
--                 name = "Launch file",
--                 program = "${file}",
--                 cwd = "${workspaceFolder}",
--             },
--             -- {
--             --     type = "pwa-node",
--             --     request = "attach",
--             --     name = "Attach",
--             --     processId = require "dap.utils".pick_process,
--             --     cwd = "${workspaceFolder}",
--             -- }
--         }
--     }
-- end
