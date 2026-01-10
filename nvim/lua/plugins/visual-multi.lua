return {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false, 
    init = function()
        vim.g.VM_maps = {
            ["Find Under"] = "<C-d>",         -- Selects the word and moves to the next
            ["Find Subword Under"] = "<C-d>", -- Same for subwords
        }
    end,
}
