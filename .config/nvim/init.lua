require("chungus.core")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("chungus.plugins.neotree"),
	require("chungus.plugins.colortheme"),
	require("chungus.plugins.autocompletion"),
	require("chungus.plugins.lsp"),
	require("chungus.plugins.telescope"),
	require("chungus.plugins.treesitter"),
	require("chungus.plugins.misc"),
	require("chungus.plugins.bufferline"),
	require("chungus.plugins.lualine"),
	require("chungus.plugins.autoformat"),
	require("chungus.plugins.gitsigns"),
	require("chungus.plugins.alpha"),
	require("chungus.plugins.indentlines"),
})
