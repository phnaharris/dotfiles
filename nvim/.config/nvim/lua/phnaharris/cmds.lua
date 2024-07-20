local template_folders = "/data/repos/phnaharris-machos/templates/"

vim.api.nvim_create_user_command("TemplateDocker", function()
  vim.cmd("0read " .. template_folders .. "Dockerfile")
end, { nargs = 0 })

vim.api.nvim_create_user_command("TemplateDockerCompose", function()
  vim.cmd("0read " .. template_folders .. "docker-compose.yml")
  vim.cmd "normal! 4jf#"
  vim.cmd "startinsert "
end, { nargs = 0 })
