return {
    "echasnovski/mini.nvim",
    version = "*", -- stable version, false for Main branch
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

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
        require("mini.surround").setup()    -- Surround actions (add/delete/replace)
        require("mini.comment").setup()     -- Comments (gc)
        vim.keymap.set("n", "<C-S-A>", "gcc", { remap = true, desc = "Toggle Comment Line" })
        vim.keymap.set("x", "<C-S-A>", "gc",  { remap = true, desc = "Toggle Comment Selection" })
        require("mini.move").setup({        -- move a line
            mappings = {
                -- Visual mode (Move selected block)
                left = '<C-M-left>', right = '<C-M-right>', down = '<C-M-down>', up = '<C-M-up>',

                -- Normal mode (Move current line)
                line_left = '<C-M-left>', line_right = '<C-M-right>', line_down = '<C-M-down>', line_up = '<C-M-up>',
            },
        })
        require("mini.operators").setup()   -- Extra operators (replace, sort)
        require("mini.pairs").setup()       -- Auto-close pairs () [] {}
        require("mini.bufremove").setup()   -- Close buffer keep window

        -- ==========================================================
        -- UI / VISUAL
        -- ==========================================================
        require("mini.icons").setup()       -- Icons
        require("mini.indentscope").setup() -- Indent line 
        require("mini.cursorword").setup()  -- Highlight word under cursor
        require("mini.hipatterns").setup()  -- Highlight patterns (hex colors, TODOs)
        require("mini.animate").setup()     -- Animations (scroll, cursor)
        require("mini.map").setup()         -- Minimap (code overview)

        -- ==========================================================
        -- NAVIGATION & UTILS
        -- ==========================================================
        require("mini.jump").setup()        -- Smart jump in line
        require("mini.jump2d").setup()      -- Jump on scre
        require("mini.visits").setup()      -- Track file visits
        require("mini.git").setup()
        

        -- ==========================================================
        -- STARTER
        -- ==========================================================
        require("mini.sessions").setup({
            autowrite = true,
        })
        require("mini.visits").setup()

        local starter = require("mini.starter")
        starter.setup({
            evaluate_single = true,
            sections = {
                starter.sections.recent_files(5, false), -- Recent files in current folder
                starter.sections.recent_files(5, true),  -- Recent files globally
                starter.sections.sessions(5, true),      -- Your saved sessions
                starter.sections.builtin_actions(),      -- New file, Quit, etc.
            },
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.indexing('all', { 'Builtin actions' }),
                starter.gen_hook.aligning('center', 'center'),
            },
        })

        -- ==========================================================
        -- MINI CLUE CONFIGURATION 
        -- ==========================================================
        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in Vim completion
                { mode = "n", keys = "<C-w>" }, -- Windos Actions
                { mode = "n", keys = "g" },     -- 'g' commands (goto, etc)
                { mode = "x", keys = "g" },

                -- Marks and Registers
                { mode = "n", keys = "'" }, 
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" }, -- Paste register in insert mode
                { mode = "c", keys = "<C-r>" }, -- Paste register in command mode

                -- Z commands (folds, spell)
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            -- CLUES: Descriptions for the keys
            clues = {
                -- Enhance standard Vim descriptions
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.z(),
                miniclue.gen_clues.windows(),
                                       
                -- CUSTOM GROUPS (These create the "folders" in the menu)
                -- The individual keys are picked up from your keymaps.lua automatically!
                { mode = "n", keys = "<Leader>f", desc = "+Fzf Search"},
                { mode = "n", keys = "<Leader>e", desc = "+Explorer" }, -- For Oil
                { mode = "n", keys = "<Leader>g", desc = "+Git" }, -- Added to group Git actions
                { mode = "n", keys = "<Leader>c", desc = "+Code" },
                { mode = "n", keys = "<Leader>s", desc = "+Session" },
                { mode = "n", keys = "<Leader>l", desc = "+LaTeX" },
            },

            -- WINDOW CONFIGURATION
            window = {
                delay = 300, -- 300ms wait time (same as you had before)
                config = { width = "auto", border = "single" },
            },
        })
    end,
}
