local snippy = {
	"dcampos/nvim-snippy",
	opts = {
		mappings = {
			v = {
				["<C-Space>"] = "cut_text",
			},
		},
	},
}

local nvim_cmp = {
	"hrsh7th/nvim-cmp",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"dcampos/cmp-snippy",
		"onsails/lspkind-nvim",
		{ "xzbdmw/colorful-menu.nvim", opts = {
			max_width = 40,
		} },
	},
	config = function()
		local cmp = require("cmp")
		local cmdline_formatting = { fields = { "abbr" } }
		local winhighlight = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		})
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				formatting = cmdline_formatting,
				window = {
					completion = winhighlight,
				},
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			}),
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				formatting = cmdline_formatting,
				window = {
					completion = winhighlight,
				},
				sources = {
					{ name = "buffer" },
				},
			}),
			snippet = {
				expand = function(args)
					require("snippy").expand_snippet(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping(function(fallback)
					if require("snippy").can_expand_or_advance() then
						require("snippy").expand_or_advance()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),
			-- formatting = {
			-- 	fields = { "kind", "abbr", "menu" },
			-- 	format = function(entry, vim_item)
			-- 		local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			-- 		local strings = vim.split(kind.kind, "%s", { trimempty = true })
			-- 		kind.kind = " " .. strings[1] .. " "
			-- 		kind.menu = "    (" .. strings[2] .. ")"
			--
			-- 		return kind
			-- 	end,
			format = function(entry, vim_item)
				local completion_item = entry:get_completion_item()
				local highlights_info = require("colorful-menu").highlights(completion_item, vim.bo.filetype)

				-- error, such as missing parser, fallback to use raw label.
				if highlights_info == nil then
					vim_item.abbr = completion_item.label
				else
					vim_item.abbr_hl_group = highlights_info.highlights
					vim_item.abbr = highlights_info.text
				end

				local kind = require("lspkind").cmp_format({
					mode = "symbol_text",
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				vim_item.kind = " " .. (strings[1] or "") .. " "
				vim_item.menu = ""

				return vim_item
			end,
			-- },
			--
			window = {
				documentation = winhighlight,
				completion = winhighlight,
			},
			sources = {
				{ name = "snippy" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
			},
		})
	end,
}

return {
	snippy,
	nvim_cmp,
}
