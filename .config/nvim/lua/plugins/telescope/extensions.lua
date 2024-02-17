#!/usr/bin/lua

return {
	lsp_handlers = {
		disable = {},
		location = {
			telescope = {},
			no_results_message = "No references found",
		},
		symbol = {
			telescope = {},
			no_results_message = "No symbols found",
		},
		call_hierarchy = {
			telescope = {},
			no_results_message = "No calls found",
		},
		code_action = {
			telescope = {
				require("telescope.themes").get_dropdown({}),
			},
			no_results_message = "No code actions available",
			prefix = "",
		},
	},
	dap = {},
	fzf = {},
	noice = {},
	cheat = {},
	refactoring = {},

}
