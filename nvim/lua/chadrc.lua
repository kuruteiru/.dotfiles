---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "rosepine",
    hl_override = {
        Normal = { bg = "#000000" },
        StatusLine = { bg = "#000000" }
    }
}

M.ui = {
    telescope = { style = "borderless" }, -- borderless / bordered

    statusline = {
        theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "block",
        order = nil,
        modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "buffers" },
        modules = nil,
    }, 

    nvdash = {
        load_on_startup = true,

        header = {
            "                            ",
            "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
            "   ▄▀███▄     ▄██ █████▀    ",
            "   ██▄▀███▄   ███           ",
            "   ███  ▀███▄ ███           ",
            "   ███    ▀██ ███           ",
            "   ███      ▀ ███           ",
            "   ▀██ █████▄▀█▀▄██████▄    ",
            "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
            "                            ",
            "     Powered By  eovim    ",
            "                            ",
        },

        buttons = {
            { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
            { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
            -- more... check nvconfig.lua file for full list of buttons
        },
    }
}

return M
