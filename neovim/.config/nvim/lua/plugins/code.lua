local Utils = require("utils")

local lsp = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
	},
	opts = {
		inlay_hints = { enabled = true },
		setup = {
			rust_analyzer = function()
				return true
			end,
		},
	},
	config = function()
		require("neodev").setup({})

		local on_attach = function(client, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
			nmap("<leader>e", vim.diagnostic.open_float, "Show Line Diagnostic")
			nmap("gd", "<cmd>Lspsaga goto_definition<CR>", "[G]oto [D]efinition")
			nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "[P]eek Definition")
			nmap(
				"gr",
				"<cmd>lua require('fzf-lua').lsp_references({ ignore_current_line = true })<CR>",
				"[G]oto [R]eferences"
			)
			nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to prev [D]iagnostic")
			nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next [D]iagnostic")

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
				require("conform").format({ bufnr = bufnr })
			end, { desc = "Format current buffer with LSP" })

			nmap("<leader>cf", "<cmd>Format<CR>", "[C]ode [F]ormat")

			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		local servers = {
			-- rust_analyzer = {},
			ts_ls = {
				single_file_support = false,
				root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
			},
			tailwindcss = {},
			pyright = {},
			bashls = {},
			lua_ls = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
					},
					hint = {
						enable = true,
					},
				},
			},
			denols = {},
		}

		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		--
		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		require("mason").setup()
		-- Ensure the servers above are installed
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})
		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					handlers = {
						["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" }),
						["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded " }),
					},
				})
			end,
			denols = function()
				require("lspconfig").denols.setup({
					cmd = { "deno", "lsp", "--unstable" },
					root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
				})
			end,
			ts_ls = function()
				require("lspconfig").ts_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					single_file_support = false,
					root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
				})
			end,
			rust_analyzer = function() end,
		})

		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black", stop_after_first = false },
				javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
				typescript = { "deno_fmt", "eslint_d", "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "deno_fmt", "eslint_d", "prettierd", "prettier", stop_after_first = true },
				rust = { "rustfmt" },
			},

			formatters = {
				eslint_d = {
					cwd = require("conform.util").root_file({
						".eslintrc.js",
						".eslint.js",
						".eslintrc.json",
						".eslint.json",
						"eslint.config.js",
					}),
					require_cwd = true,
					condition = function(_, ctx)
						return vim.fs.find({ "tsconfig.json", "package.json" }, { path = ctx.filename, upward = true })[1]
					end,
				},
				deno_fmt = {
					condition = function(_, ctx)
						return vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
					end,
				},
			},
		})

		require("lint").linters_by_ft = {
			typescript = { "eslint_d" },
		}

		local lint = function()
			local buffer_filetype = vim.bo.filetype
			if
				Utils.tableContains(
					{ "typescript", "typescriptreact", "javascript", "javascriptreact" },
					buffer_filetype
				)
			then
				local eslint_config_found = vim.fs.find(
					{ ".eslintrc.js", ".eslint.js", ".eslintrc.json", ".eslint.json", "eslint.config.js" },
					{ path = vim.bo.path, upward = true }
				)
				if vim.fn.executable("rg") == 1 and #eslint_config_found > 0 then
					require("lint").try_lint()
				end
			end
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
			callback = function()
				lint()
			end,
		})
	end,
}

local treesitter = {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local opts = {
			ensure_installed = {
				"lua",
				"python",
				"rust",
				"vim",
				"vimdoc",
				"fish",
				"html",
				"json",
				"markdown",
				"markdown_inline",
				"python",
				"typescript",
				"tsx",
				"javascript",
				"bash",
			},
			highlight = { enable = true },
			indent = { enable = false },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					node_decremental = "<c-backspace>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		}

		require("nvim-treesitter.install").update({ with_sync = true })
		require("nvim-treesitter.configs").setup(opts)
	end,
}

local aerial = {
	"stevearc/aerial.nvim",
	cmd = "AerialToggle",
	keys = {
		{ "]a", "<cmd>:AerialToggle<CR>", desc = "Aerial Toggle" },
	},
	opts = {},
}

local gitsigns = {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	init = function()
		local gitsigns = require("gitsigns")
		vim.keymap.set("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return "<Ignore>"
		end, { desc = "GitSigns - Next hunk", silent = true })
		vim.keymap.set("n", "[c", function()
			if vim.wo.diff then
				return "[gc"
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return "<Ignore>"
		end, { desc = "GitSigns - Prev hunk", silent = true })
		vim.keymap.set("n", "]p", gitsigns.preview_hunk, { desc = "GitSigns - Preview hunk", silent = true })
		vim.keymap.set(
			"n",
			"]t",
			gitsigns.toggle_current_line_blame,
			{ desc = "GitSigns - Toggle line blame", silent = true }
		)
		vim.keymap.set("n", "]h", gitsigns.diffthis, { desc = "GitSigns - Diff this", silent = true })
		vim.keymap.set("n", "]H", function()
			require("gitsigns").diffthis("~")
		end, { desc = "GitSigns - Diff this ~", silent = true })
	end,
	config = true,
}

local comment = {
	"echasnovski/mini.comment",
	version = false,
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("ts_context_commentstring").setup({
					enable_autocmd = false,
				})
			end,
		},
	},
	config = function()
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})
	end,
}

local colorizer = {
	"NvChad/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		filetypes = { "css", "scss", "typescript", "typescriptreact", "javascript", "!lazy" },
		buftype = { "*", "!prompt", "!nofile" },
		user_default_options = {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = false, -- "Name" codes like Blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = false, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes: foreground, background
			-- Available modes for `mode`: foreground, background,  virtualtext
			mode = "background", -- Set the display mode.
			virtualtext = "■",
			tailwind = true,
		},
	},
}

local rustaceanvim = {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
}

return {
	lsp,
	treesitter,
	aerial,
	gitsigns,
	comment,
	colorizer,
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	rustaceanvim,
}
