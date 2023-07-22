require("plugins.lsp.handlers").setup()
require("plugins.lsp.mason")
require("plugins.lsp.null-ls")

local init = {}

init.server_capabilities = function()
    local active_clients = vim.lsp.get_clients()
    local active_client_map = {}

    for index, value in ipairs(active_clients) do
        active_client_map[value.name] = index
    end

    vim.ui.select(vim.tbl_keys(active_client_map), {
        prompt = "Select client: ",
        format_item = function(item)
            return "capabilities for: " .. item
        end
    }, function(choice)
        print(vim.inspect(vim.lsp
            .get_clients()[active_client_map[choice]]
            .server_capabilities
            .executeCommandProvider))
        vim.pretty_print(vim.lsp.get_clients()[active_client_map[choice]]
            .server_capabilities)
    end)
end

return init
