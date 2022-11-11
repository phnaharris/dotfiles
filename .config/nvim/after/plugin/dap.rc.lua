local status_dap, dap = pcall(require, "dap")
if (not status_dap) then return end
local status_dapui, dapui = pcall(require, "dapui")
if (not status_dapui) then return end

local function dap_keymaps(bufnr)
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<F8>", "<cmd>DapToggleBreakpoint<CR>", opts)
    vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>", opts)
    vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>", opts)
    vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>", opts)
    vim.keymap.set("n", "<leader>dq", "<cmd>DapTerminate<CR>", opts)

    -- why it's not working??? It's just work for this file, but not other file.
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>n", "<cmd>DapContinue<CR>", opts)
end

local function dapui_setup()
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        ---@diagnostic disable-next-line: missing-parameter
        dapui.close()
    end
end

dap_keymaps(0) -- 0 for current buffer
dapui_setup()

-- Adapter stuffs

-- /usr/bin/lldb-vscode-13
-- sudo apt install lldb-13
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-13', -- adjust as needed, must be absolute path
    name = 'lldb'
}

local dap_python = require "dap-python"
dap_python.setup("python", {
    -- So if configured correctly, this will open up new terminal.
    --    Could probably get this to target a particular terminal
    --    and/or add a tab to kitty or something like that as well.
    console = "externalTerminal",

    include_configs = true,
})

dap_python.test_runner = "pytest"


-- Client configurations stuffs

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = {},
        terminal = 'integrated',
    },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = dap.configurations.cpp

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Build api",
        program = "${file}",
        args = { "--target", "api" },
        console = "integratedTerminal",
    },
    -- {
    --     type = "python",
    --     request = "launch",
    --     name = "lsif",
    --     program = "src/lsif/__main__.py",
    --     args = {},
    --     console = "integratedTerminal",
    -- },
}
