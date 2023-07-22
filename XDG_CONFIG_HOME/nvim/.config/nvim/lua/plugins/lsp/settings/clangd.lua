local status_util, util = pcall(require, "lspconfig/util")
if not status_util then return end

return {
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    init_options = {
        clangdFileStatus = true,
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = util.root_pattern(
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git"
    )
}
