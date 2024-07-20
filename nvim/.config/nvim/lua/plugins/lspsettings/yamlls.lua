return {
  yaml = {
    schemaStore = {
      enable = false, -- disable built-in schemas, use the schemasstore extension instead
    },
    schemas = require("schemastore").yaml.schemas(),
    format = {
      enable = true,
    },
    editor = {
      autoIndent = "advanced",
    },
  },
}
