local status_util, util = pcall(require, "lspconfig/util")
if not status_util then return end
print("clangd ok")

return {
    cmd = { "clangd", "--background-index", "--query-driver=/usr/bin/x86_64-linux-gnu-g++-10" };
    filetypes = { "c", "cpp", "objc", "objcpp" };
    root_dir = util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    )
}
