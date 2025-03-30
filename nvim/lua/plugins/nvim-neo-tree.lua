return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
            }
        },
        default_component_configs = {
            file = {
                highlight = function(node)
                    local ext = node.ext or ""
                    local hl_map = {
                        lua = "NeoTreeExtLua",
                        py = "NeoTreeExtPy",
                        js = "NeoTreeExtJs",
                        ts = "NeoTreeExtJs",
                        txt = "NeoTreeExtTxt",
                    }
                    return hl_map[ext] or "NeoTreeFileName"
                end,
            },
        }
    },
    config = function()
        -- Apply highlight colors
        vim.api.nvim_set_hl(0, "NeoTreeExtLua", { fg = "#51A0CF" })
        vim.api.nvim_set_hl(0, "NeoTreeExtPy", { fg = "#FFD43B" })
        vim.api.nvim_set_hl(0, "NeoTreeExtJs", { fg = "#F7DF1E" })
        vim.api.nvim_set_hl(0, "NeoTreeExtTxt", { fg = "#A0A0A0" })
    end
}
