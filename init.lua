if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
else 
  vim.cmd("set expandtab")
  vim.cmd("set tabstop=2")
  vim.cmd("set softtabstop=2")
  vim.cmd("set shiftwidth=2")
  vim.g.mapleader= " "
  -- Lazy package manager
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
      })
    end
  vim.opt.rtp:prepend(lazypath)

  local opts = {}
  local plugins = {
    -- get theme
    { 
      "catppuccin/nvim", name = "catppuccin", priority = 1000 
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 
      "nvim-treesitter/nvim-treesitter", 
      build= ":TSUpdate"
    }
  }

  require("lazy").setup(plugins, opts) 
  
  --catppuccin theme
  require("catppuccin").setup()
  vim.cmd.colorscheme "catppuccin"

  --telescope
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<C-p>", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  
  --treesitter
  local config = require("nvim-treesitter.configs")
  config.setup({
    ensure_installed = { "lua", "javascript" },
    highlight = { enable = true },
    indent = { enable = true }
  })
end
