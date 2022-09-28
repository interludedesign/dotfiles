require("luautils.string")

local M = {}
local a = vim.api

P = function(v)
	print(vim.inspect(v))
	return v
end

R = function(name)
	require("plenary.reload").reload_module(name)
	return require(name)
end

M.toggle_blame = function()
	if vim.bo.filetype == "fugitiveblame" then
		vim.api.nvim_buf_delete(0, {})
	else
		vim.api.nvim_command('Git blame')
	end
end

local function escape(str)
	return string.gsub(str, "-", "")
end

-- Return true / false if current bufname contains the given string
M.buf_name_contains = function(str)
	local bufname = a.nvim_buf_get_name(0)

	if (escape(bufname)):find(escape(str)) then
			return true
	end

	return false
end

M.open_alternate_path = function(path, vim_command)
	path = path or vim.api.nvim_buf_get_name(0)
	local result = M.alternate_path(path)

	if string.is_empty(result) then
		return string.format("No alternate file for %s exists!", path)
	else
		vim.fn['execute'](vim_command .. " " .. result)
	end
end

M.alternate_path = function(path)
	path = path or vim.api.nvim_buf_get_name(0)
	local command = string.format("! alt %s", path)
	return vim.fn['system'](command)
end

M.run_spec_in_tmux = function()
	vim.api.nvim_command('write')
	local file = vim.api.nvim_buf_get_name(0)

	-- If the file is not a spec file, look for its alternate_path and use that instead
	local start_pos, _ = string.find(file, "_spec")
	if not start_pos then
		file = M.alternate_path()
	end

	local cmd = string.format("spec %s\n", file)
	require("harpoon.tmux").sendCommand("%0", "clear\n")
	require("harpoon.tmux").sendCommand("%0", cmd)
end

M.split = function(inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

-- " Empties all registers
-- " use :call EmptyRegisters()
-- fun! EmptyRegisters()
-- 	let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
-- 	for r in regs
-- 		call setreg(r, [])
-- 	endfor
-- endfun

return M
