return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "lua", 
				"cpp", 
				"c", 
				"python", 
				"go", 
				"bash", 
				"json", 
				"html", 
				"css", 
				"java", 
				"haskell",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    }
  end
}
