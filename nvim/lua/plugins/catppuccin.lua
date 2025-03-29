-- lua/plugins/rose-pine.lua
return {
	"catppuccin/nvim",
    lazy = false, 
	name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "mocha" 
    }, 
	config = function(otps)
		vim.cmd("colorscheme catppuccin")
        require("catppuccin").setup(opts)
	end    
}