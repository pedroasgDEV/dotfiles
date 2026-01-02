return {
    "echasnovski/mini.nvim",
    version = "*", -- stable version, false for Main branch
    config = function()
        -- ==========================================================
        -- BASICS & SESSION
        -- ==========================================================
        require("mini.basics").setup()      -- Common settings (line numbers, mouse)
        require("mini.misc").setup()        -- Miscellaneous utils (Zoom, Terminal)

        -- ==========================================================
        -- EDITING & MOVEMENT
        -- ==========================================================
        require("mini.ai").setup()          -- Better text objects
        require("mini.align").setup()       -- Align text
        require("mini.comment").setup()     -- Comments (gc)
        require("mini.move").setup()        -- Move lines with Alt+hjkl
        require("mini.operators").setup()   -- Extra operators (replace, sort)
        require("mini.pairs").setup()       -- Auto-close pairs () [] {}
        require("mini.splitjoin").setup()   -- Toggle single/multi-line (gS)
        require("mini.bufremove").setup()   -- Close buffer keep window

        -- ==========================================================
        -- UI / VISUAL
        -- ==========================================================
        require("mini.icons").setup()       -- Icons
        require("mini.indentscope").setup() -- Indent line 
        require("mini.cursorword").setup()  -- Highlight word under cursor
        require("mini.hipatterns").setup()  -- Highlight patterns (hex colors, TODOs)
        require("mini.statusline").setup()  -- Statusline (bottom bar)
        require("mini.tabline").setup()     -- Tabline (top buffer bar)
        require("mini.animate").setup()     -- Animations (scroll, cursor)
        require("mini.map").setup()         -- Minimap (code overview)

        -- ==========================================================
        -- NAVIGATION & UTILS
        -- ==========================================================
        require("mini.pick").setup()        -- Fuzzy Finder
        require("mini.jump").setup()        -- Smart jump in line
        require("mini.jump2d").setup()      -- Jump on scre
        require("mini.visits").setup()      -- Track file visits
    end,
}
