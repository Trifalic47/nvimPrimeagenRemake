return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        ""
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua  = { "string" },
                rust = { "string" },
                c    = { "string" },
            },
            disable_filetype = { "TelescopePrompt", "vim" },
            fast_wrap = {
                map            = "<M-e>",
                chars          = { "{", "[", "(", '"', "'" },
                pattern        = [=[[%'%"%>%]%)%}%,]]=],
                end_key        = "$",
                before_key     = "p",
                after_key      = "n",
                cursor_pos_before = true,
                keys           = "qwertyuiopzxcvbnmasdfghjkl",
                manual_position = true,
                highlight      = "Search",
                highlight_grey = "Comment",
            },
        })

        -- integrate with cmp if you have it
        local ok, cmp = pcall(require, "cmp")
        if ok then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end

        -- Extra rules
        -- Add spaces inside curly braces
        autopairs.add_rules({
            Rule(" ", " ")
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
                end),
            Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts)
                return opts.char == ">"
            end),
        })
    end,
}
