local M = {}

-- Utility to open a URL
local function open_url(url)
    if vim.ui.open then
        vim.ui.open(url)
    else
        local os_name = vim.loop.os_uname().sysname
        if os_name == "Linux" then
            vim.fn.jobstart({ "xdg-open", url })
        elseif os_name == "Darwin" then
            vim.fn.jobstart({ "open", url })
        end
    end
end

function M.smart_open()
    local line = vim.api.nvim_get_current_line()
    local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local ft = vim.bo.filetype

    -- 1. Check for URLs under cursor
    local url_pattern = "https?://[%w-_%.%?%.:/%+=&]+"
    local start_idx = 1
    while true do
        local s, e = line:find(url_pattern, start_idx)
        if not s then break end
        if cursor_col >= s and cursor_col <= e then
            local url = line:sub(s, e)
            open_url(url)
            return
        end
        start_idx = e + 1
    end

    -- 2. Check for C/C++ includes
    if ft == "c" or ft == "cpp" then
        local include_pattern = '#include%s+["<](%S+)%s*[">]'
        local s, e, match = line:find(include_pattern)
        if s and cursor_col >= s and cursor_col <= e then
            -- Try LSP definition first as it's more precise for includes
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients > 0 then
                vim.lsp.buf.definition()
            else
                vim.cmd("normal! gf")
            end
            return
        end
    end

    -- 3. Check for Python imports
    if ft == "python" then
        if line:find("import") or line:find("from") then
            vim.lsp.buf.definition()
            return
        end
    end

    -- 4. Fallback: Try 'gf' (Go to File) then 'gx' (Netrw Browse)
    local ok = pcall(vim.cmd, "normal! gf")
    if not ok then
        pcall(vim.cmd, "normal! gx")
    end
end

return M
