return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local function handler(virtText, lnum, endLnum, width, truncate)
				local suffix = ("  󰁂 %d lines "):format(endLnum - lnum)
				local suffix_width = vim.fn.strdisplaywidth(suffix)
				local target_width = width - suffix_width

				local newVirtText = vim.deepcopy(virtText)

				local lines = vim.api.nvim_buf_get_lines(0, lnum, math.min(endLnum, lnum + 40), false)

				local seen_paren = false
				local paren_depth = 0

				for _, line in ipairs(lines) do
					local trimmed = vim.trim(line)

					if trimmed ~= "" then
						table.insert(newVirtText, { " " .. trimmed, "Folded" })
					end

					for c in trimmed:gmatch(".") do
						if c == "(" then
							seen_paren = true
							paren_depth = paren_depth + 1
						elseif c == ")" then
							paren_depth = paren_depth - 1
						end
					end

					if seen_paren and paren_depth <= 0 then
						break
					end

					if trimmed:find("{", 1, true) or trimmed:find(";", 1, true) then
						break
					end
				end

				local cur_width = 0
				local final = {}

				for _, chunk in ipairs(newVirtText) do
					local text = chunk[1]
					local hl = chunk[2]
					local chunk_width = vim.fn.strdisplaywidth(text)

					if cur_width + chunk_width < target_width then
						table.insert(final, chunk)
						cur_width = cur_width + chunk_width
					else
						local remaining = target_width - cur_width
						if remaining > 0 then
							table.insert(final, { truncate(text, remaining), hl })
						end
						break
					end
				end

				table.insert(final, { suffix, "UfoFoldedEllipsis" })

				return final
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,

				fold_virt_text_handler = handler,
			})
		end,
	},
}
