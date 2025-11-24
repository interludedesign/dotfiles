local M = {}


-- Toggle checkbox on current line
function M.toggle_checkbox()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if line:match("^%s*- %[ %]") then
		-- Uncheck to checked
		local new_line = line:gsub("^(%s*- )%[ %]", "%1[x]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	elseif line:match("^%s*- %[x%]") or line:match("^%s*- %[X%]") then
		-- Checked to unchecked
		local new_line = line:gsub("^(%s*- )%[[xX]%]", "%1[ ]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	else
		-- No checkbox, create one
		local indent = line:match("^(%s*)")
		if line:match("^%s*$") then
			-- Empty line
			vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent .. "- [ ] " })
			vim.api.nvim_win_set_cursor(0, { row, #indent + 6 })
		elseif line:match("^%s*- ") then
			-- Already a list item, add checkbox
			local new_line = line:gsub("^(%s*- )", "%1[ ] ")
			vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
		else
			-- Regular text, convert to checkbox
			local text = line:gsub("^%s*", "")
			vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent .. "- [ ] " .. text })
		end
	end
end

-- Create a new checkbox on current line
function M.create_checkbox()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if line:match("^%s*- %[[ xX]%]") then
		-- Already has a checkbox, do nothing
		return
	end

	local indent = line:match("^(%s*)")
	if line:match("^%s*$") then
		-- Empty line
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent .. "- [ ] " })
		vim.api.nvim_win_set_cursor(0, { row, #indent + 6 })
	elseif line:match("^%s*- ") then
		-- Already a list item, add checkbox
		local new_line = line:gsub("^(%s*- )", "%1[ ] ")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	else
		-- Regular text, convert to checkbox
		local text = line:gsub("^%s*", "")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { indent .. "- [ ] " .. text })
	end
end

-- Mark checkbox as checked
function M.check_checkbox()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if line:match("^%s*- %[ %]") then
		local new_line = line:gsub("^(%s*- )%[ %]", "%1[x]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	end
end

-- Mark checkbox as unchecked
function M.uncheck_checkbox()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if line:match("^%s*- %[x%]") or line:match("^%s*- %[X%]") then
		local new_line = line:gsub("^(%s*- )%[[xX]%]", "%1[ ]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	end
end

return M
