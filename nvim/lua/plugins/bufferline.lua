return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup {
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead
                themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
                close_command = "bd! %d", -- can be a string | function, | false see "Mouse actions"
                indicator = {
                    -- this should be omitted if indicator style is not 'icon'
                    style = 'none', -- underline | icon  | none
                },
                modified_icon = '●',
                left_trunc_marker = '',
                right_trunc_marker = '',
                ----- name_formatter can be used to change the buffer's label in the bufferline.
                ----- Please note some names can/will break the
                ----- bufferline so use this at your discretion knowing that it has
                ----- some limitations that will *NOT* be fixed.
                name_formatter = function(buf)
                    return "(" .. buf.bufnr .. ")" .. buf.name
                    -- buf contains:
                    -- name                | str        | the basename of the active file
                    -- path                | str        | the full path of the active file
                    -- bufnr               | int        | the number of the active buffer
                    -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
                    -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
                end,
                max_name_length = 20,
                --  max_prefix_length =,, -- prefix used when a buffer is de-duplicated
                truncate_names = true, -- whether or not tab names should be truncated
                offsets = {
                    {
                        filetype = "NvimTree",
                        text_align = "right", --  "center" | "right",
                        separator = true
                    }
                },
                color_icons = true, -- whether or not to add the filetype icon highlights
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                always_show_bufferline = true,
                separator_style = {'|', '|'},
                --maximum_padding = 10,
                --minimum_padding = 5,
                -- auto_toggle_bufferline = true | false,
                --sort_by = 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                --    -- add custom logic
                --    local modified_a = vim.fn.getftime(buffer_a.path)
                --    local modified_b = vim.fn.getftime(buffer_b.path)
                --    return modified_a > modified_b
                --end,
                --pick = {
                --    alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
                --}

            },
            highlights = {
                separator = {
                    fg = "#f5e0dc"
                },

                buffer_selected = {
                    bold = true,
                    italic = false,
                    fg = "#f5e0dc"
                },
            }
        }
    end
}