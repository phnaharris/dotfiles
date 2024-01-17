return {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			imports = {
				group = {
					enable = true,
				},
			},
			completion = {
				postfix = {
					enable = false,
				},
			},
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}
