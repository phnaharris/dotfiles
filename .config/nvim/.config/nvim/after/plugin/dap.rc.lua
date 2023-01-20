local status_dap, dap = pcall(require, "dap")
if (not status_dap) then return end
local status_dapui, dapui = pcall(require, "dapui")
if (not status_dapui) then return end

local function dapui_setup()
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    })
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
    local opts = { noremap = true, silent = true }

    bind("n", "<F5>", "<cmd>DapContinue<CR>", opts)
    bind("n", "<F8>", "<cmd>DapToggleBreakpoint<CR>", opts)
    bind("n", "<F1>", function()
        if vim.bo.filetype == "rust" then
            vim.api.nvim_command("RustDebuggables")
        end

    end, opts)
    bind("n", "<F11>", "<cmd>DapStepInto<CR>", opts)
    bind("n", "<F10>", "<cmd>DapStepOver<CR>", opts)
    bind("n", "<leader>D", "<cmd>DapTerminate<CR>", opts)

    -- why it's not working??? It's just work for this file, but not other file.
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>n", "<cmd>DapContinue<CR>", opts)
end

dapui_setup()
dap_keymaps(0)

-- dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

local status_rt, rt = pcall(require, "rust-tools")
if not status_rt then return end

local extension_path = vim.env.HOME ..
    "/.local/share/nvim/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

dap.adapters.codelldb = rt.dap.get_codelldb_adapter(codelldb_path, liblldb_path)

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
    },
}
dap.configurations.c = dap.configurations.cpp

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
