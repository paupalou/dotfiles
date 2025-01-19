local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>ca", function()
	vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr, desc = "[C]ode [A]ction" })

vim.keymap.set("n", "<leader>cf", function()
	vim.cmd.Format()
end, { silent = true, desc = "[C]ode [F]ormat" })

vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr, desc = "Hover" }
)

vim.keymap.set("n", "<leader>e", function()
	vim.cmd.RustLsp({ "renderDiagnostic", "current" })
end, { silent = true, buffer = bufnr, desc = "Show line diagnostics" })

vim.keymap.set("n", "[d", function()
	vim.cmd.Lspsaga("diagnostic_jump_prev")
end, { silent = true, buffer = bufnr, desc = "Jump to prev [D]iagnostic" })

vim.keymap.set("n", "]d", function()
	vim.cmd.Lspsaga("diagnostic_jump_next")
end, { silent = true, buffer = bufnr, desc = "Jump to next [D]iagnostic" })

vim.keymap.set("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, { silent = true, desc = "[R]e[n]ame" })

vim.keymap.set("n", "gd", function()
	vim.cmd.Lspsaga("goto_definition")
end, { silent = true, desc = "[G]oto [D]efinition" })

vim.keymap.set("n", "<leader>p", function()
	vim.cmd.Lspsaga("peek_definition")
end, { silent = true, desc = "[P]eek [D]efinition" })

-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
	require("conform").format({ bufnr = bufnr })
end, { desc = "Format current buffer with LSP" })

vim.keymap.set("n", "J", function()
	vim.cmd.RustLsp("joinLines")
end, { silent = true, desc = "[J]oin lines" })
