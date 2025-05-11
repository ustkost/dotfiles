vim.g.mapleader = " "

-- Базовые настройки
vim.opt.number = true              -- показывать номера строк
vim.opt.relativenumber = true     -- относительная нумерация
vim.opt.mouse = "a"               -- включить мышь
vim.opt.clipboard = "unnamedplus" -- использовать системный буфер обмена
vim.opt.expandtab = true          -- заменять табы на пробелы
vim.opt.shiftwidth = 2            -- ширина таба при >> <<
vim.opt.tabstop = 2               -- ширина таба
vim.opt.smartindent = true        -- умный отступ
vim.opt.termguicolors = true      -- поддержка truecolor
vim.opt.splitright = true         -- вертикальные сплиты открываются справа
vim.opt.splitbelow = true         -- горизонтальные сплиты открываются снизу

-- Удобные бинды
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- файловый браузер

-- Плагины (если используешь Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-tree/nvim-tree.lua" },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  }
})

-- Цветовая схема
vim.cmd.colorscheme "catppuccin-mocha"

-- Nvim Tree (файловый браузер)
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>o", ":NvimTreeToggle<CR>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)

