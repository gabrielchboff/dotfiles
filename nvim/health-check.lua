-- =====================================================================
-- Neovim Configuration Health Check and Fix Script
-- =====================================================================
-- Usage: :luafile ~/.config/nvim/health-check.lua

local M = {}

-- Colors for output
local colors = {
	error = "\27[31m", -- Red
	warn = "\27[33m", -- Yellow
	info = "\27[36m", -- Cyan
	success = "\27[32m", -- Green
	reset = "\27[0m", -- Reset
}

-- Print with color
local function print_colored(message, color)
	print(colors[color] .. message .. colors.reset)
end

-- Check if a module can be loaded
local function check_module(module_name)
	local ok, result = pcall(require, module_name)
	return ok, result
end

-- Check if a command exists
local function check_command(cmd)
	return vim.fn.executable(cmd) == 1
end

-- Main health check function
function M.run_health_check()
	print_colored("🏥 Running Neovim Configuration Health Check", "info")
	print_colored("=" .. string.rep("=", 50), "info")

	local issues = {}
	local fixes = {}

	-- Check Lazy.nvim
	print_colored("\n📦 Checking Plugin Manager", "info")
	local lazy_ok, lazy = check_module("lazy")
	if lazy_ok then
		print_colored("✅ Lazy.nvim is working correctly", "success")
	else
		print_colored("❌ Lazy.nvim not found", "error")
		table.insert(issues, "Lazy.nvim not installed")
		table.insert(fixes, "Run: git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim")
	end

	-- Check core plugins
	print_colored("\n🔌 Checking Core Plugins", "info")
	local core_plugins = {
		"telescope",
		"nvim-treesitter",
		"nvim-lspconfig",
		"nvim-cmp",
		"catppuccin",
	}

	for _, plugin in ipairs(core_plugins) do
		local ok, _ = check_module(plugin)
		if ok then
			print_colored("✅ " .. plugin .. " is available", "success")
		else
			print_colored("❌ " .. plugin .. " not found", "error")
			table.insert(issues, plugin .. " not installed")
		end
	end

	-- Check LSP servers
	print_colored("\n🛠️  Checking LSP Configuration", "info")
	local lspconfig_ok, lspconfig = check_module("lspconfig")
	if lspconfig_ok then
		local servers = { "lua_ls", "pyright", "tsserver", "rust_analyzer", "gopls", "clangd" }
		for _, server in ipairs(servers) do
			if lspconfig[server] then
				print_colored("✅ " .. server .. " configuration available", "success")
			else
				print_colored("⚠️  " .. server .. " configuration not found", "warn")
				table.insert(issues, server .. " LSP not available")
			end
		end
	else
		print_colored("❌ nvim-lspconfig not available", "error")
	end

	-- Check Mason
	print_colored("\n🔨 Checking Mason", "info")
	local mason_ok, mason = check_module("mason")
	if mason_ok then
		print_colored("✅ Mason is available", "success")
		local mason_lspconfig_ok, _ = check_module("mason-lspconfig")
		if mason_lspconfig_ok then
			print_colored("✅ Mason-lspconfig is available", "success")
		else
			print_colored("❌ Mason-lspconfig not found", "error")
			table.insert(issues, "mason-lspconfig not installed")
		end
	else
		print_colored("❌ Mason not found", "error")
		table.insert(issues, "mason not installed")
	end

	-- Check external dependencies
	print_colored("\n🖥️  Checking External Dependencies", "info")
	local external_deps = {
		{ "git", "Git version control" },
		{ "curl", "HTTP client for downloads" },
		{ "unzip", "Archive extraction" },
		{ "gcc", "C compiler for native extensions" },
		{ "node", "Node.js for some LSP servers" },
		{ "python3", "Python for some tools" },
		{ "rg", "Ripgrep for telescope" },
		{ "fd", "fd for telescope" },
	}

	for _, dep in ipairs(external_deps) do
		if check_command(dep[1]) then
			print_colored("✅ " .. dep[1] .. " is available", "success")
		else
			print_colored("⚠️  " .. dep[1] .. " not found (" .. dep[2] .. ")", "warn")
			table.insert(issues, dep[1] .. " not installed")
		end
	end

	-- Check Nerd Font
	print_colored("\n🔤 Checking Font Configuration", "info")
	local font_families = { "JetBrainsMono", "FiraCode", "Hack", "Source Code Pro" }
	local font_found = false

	for _, font in ipairs(font_families) do
		local font_check = vim.fn.system("fc-list | grep -i '" .. font .. "'")
		if vim.v.shell_error == 0 and font_check ~= "" then
			print_colored("✅ Nerd Font found: " .. font, "success")
			font_found = true
			break
		end
	end

	if not font_found then
		print_colored("⚠️  No Nerd Font detected", "warn")
		table.insert(issues, "Nerd Font not installed")
		table.insert(fixes, "Install a Nerd Font: sudo pacman -S ttf-jetbrains-mono-nerd")
	end

	-- Check Neovim version
	print_colored("\n🚀 Checking Neovim Version", "info")
	local version = vim.version()
	local version_string = version.major .. "." .. version.minor .. "." .. version.patch
	print_colored("📍 Neovim version: " .. version_string, "info")

	if version.major >= 0 and version.minor >= 9 then
		print_colored("✅ Neovim version is compatible", "success")
	else
		print_colored("❌ Neovim version too old (need 0.9+)", "error")
		table.insert(issues, "Neovim version too old")
		table.insert(fixes, "Update Neovim to version 0.9 or higher")
	end

	-- Summary
	print_colored("\n📊 Health Check Summary", "info")
	print_colored("=" .. string.rep("=", 30), "info")

	if #issues == 0 then
		print_colored("🎉 All checks passed! Your configuration looks healthy.", "success")
	else
		print_colored("⚠️  Found " .. #issues .. " issue(s):", "warn")
		for i, issue in ipairs(issues) do
			print_colored("  " .. i .. ". " .. issue, "warn")
		end

		if #fixes > 0 then
			print_colored("\n🔧 Suggested fixes:", "info")
			for i, fix in ipairs(fixes) do
				print_colored("  " .. i .. ". " .. fix, "info")
			end
		end
	end

	return #issues == 0
end

-- Fix common issues
function M.fix_common_issues()
	print_colored("🔧 Attempting to fix common issues...", "info")

	-- Clear plugin cache
	local cache_dirs = {
		vim.fn.stdpath("data") .. "/lazy",
		vim.fn.stdpath("state"),
		vim.fn.stdpath("cache"),
	}

	print_colored("🧹 Clearing plugin cache...", "info")
	for _, dir in ipairs(cache_dirs) do
		if vim.fn.isdirectory(dir) == 1 then
			vim.fn.system("rm -rf " .. dir .. "/*")
			print_colored("✅ Cleared: " .. dir, "success")
		end
	end

	-- Reinstall plugins
	print_colored("📦 Reinstalling plugins...", "info")
	vim.cmd("Lazy sync")

	print_colored("✅ Fix attempt completed. Restart Neovim to see changes.", "success")
end

-- Install missing external dependencies (Arch Linux)
function M.install_dependencies()
	print_colored("📦 Installing missing dependencies (Arch Linux)...", "info")

	local packages = {
		"git",
		"curl",
		"unzip",
		"gcc",
		"nodejs",
		"npm",
		"python",
		"ripgrep",
		"fd",
		"ttf-jetbrains-mono-nerd",
	}

	local cmd = "sudo pacman -S --needed " .. table.concat(packages, " ")
	print_colored("Running: " .. cmd, "info")

	local result = vim.fn.system(cmd)
	if vim.v.shell_error == 0 then
		print_colored("✅ Dependencies installed successfully", "success")
	else
		print_colored("❌ Failed to install dependencies: " .. result, "error")
	end
end

-- Quick diagnostic
function M.quick_diagnostic()
	print_colored("🔍 Quick Diagnostic", "info")

	-- Check if init.lua loads without errors
	local config_path = vim.fn.stdpath("config") .. "/init.lua"
	if vim.fn.filereadable(config_path) == 1 then
		print_colored("✅ init.lua file exists", "success")

		-- Try to source it in a protected call
		local ok, err = pcall(vim.cmd, "source " .. config_path)
		if ok then
			print_colored("✅ init.lua loads without syntax errors", "success")
		else
			print_colored("❌ init.lua has errors: " .. tostring(err), "error")
		end
	else
		print_colored("❌ init.lua not found at " .. config_path, "error")
	end

	-- Check basic functionality
	local basic_commands = { "help", "version", "checkhealth" }
	for _, cmd in ipairs(basic_commands) do
		local ok, _ = pcall(vim.cmd, cmd)
		if ok then
			print_colored("✅ Command '" .. cmd .. "' works", "success")
		else
			print_colored("❌ Command '" .. cmd .. "' failed", "error")
		end
	end
end

-- Create user commands
vim.api.nvim_create_user_command("HealthCheck", M.run_health_check, {
	desc = "Run comprehensive health check",
})

vim.api.nvim_create_user_command("FixIssues", M.fix_common_issues, {
	desc = "Fix common configuration issues",
})

vim.api.nvim_create_user_command("InstallDeps", M.install_dependencies, {
	desc = "Install missing external dependencies",
})

vim.api.nvim_create_user_command("QuickDiag", M.quick_diagnostic, {
	desc = "Run quick diagnostic",
})

-- Auto-run on source
print_colored("🏥 Health Check Script Loaded", "info")
print_colored("Available commands:", "info")
print_colored("  :HealthCheck  - Run full health check", "info")
print_colored("  :FixIssues    - Fix common issues", "info")
print_colored("  :InstallDeps  - Install dependencies", "info")
print_colored("  :QuickDiag    - Quick diagnostic", "info")

-- Run quick diagnostic by default
M.quick_diagnostic()

return M
