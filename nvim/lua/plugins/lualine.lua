return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        cust_horizon = require'lualine.themes.horizon'
        -- To make the background transparent, set it to nil
        cust_horizon.insert.c.bg = nil
        cust_horizon.normal.c.bg = nil
        cust_horizon.command.c.bg = nil
        cust_horizon.inactive = nil
        cust_horizon.replace.c.bg = nil
        cust_horizon.visual.c.bg = nil

        vim.opt.laststatus = 3 -- Enables global statusline at the bottom

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = cust_horizon,
                section_separators = { left = '', right = '' },
                component_separators = { left = '|', right = '|' },
                disabled_filetypes = {
                    statusline = { "neo-tree" },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true, -- Ensures the statusline is at the bottom
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                -- Display only the first letter of each mode
                lualine_a = {
                    {
                        'mode',
                        fmt = function(str) return str:sub(1,1) end
                    }
                },
                lualine_b = {
                    {
                        'branch',
                        color = { gui = "bold" } -- Make branch bold
                    },
                    'diff',
                    'diagnostics'
                },
                lualine_c = {},
                lualine_x = {'encoding','filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a =  {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}