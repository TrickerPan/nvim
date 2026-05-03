local validate = vim.validate
local uname = vim.loop.os_uname()
local nvim_eleven = vim.fn.has 'nvim-0.11' == 1

local function escape_wildcards(path)
    return path:gsub('([%[%]%?%*])', '\\%1')
end

local M = {}
local H = {}

M.is_win = uname.version:match('Windows')
M.is_mac = uname.version:match('Darwin')
M.is_linux = uname.version:match('Linux')

--- Returns a function which matches a filepath against the given glob/wildcard patterns.
---
--- Also works with zipfile:/tarfile: buffers (via `strip_archive_subpath`).
M.root_pattern = function(...)
    local patterns = H.tbl_flatten { ... }
    return function(startpath)
        startpath = H.strip_archive_subpath(startpath)
        for _, pattern in ipairs(patterns) do
            local match = H.search_ancestors(startpath, function(path)
                for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
                    if vim.uv.fs_stat(p) then
                        return path
                    end
                end
            end)

            if match ~= nil then
                return match
            end
        end
    end
end

H.tbl_flatten = function(t)
    return nvim_eleven and vim.iter(t):flatten(math.huge):totable() or vim.tbl_flatten(t)
end

H.strip_archive_subpath = function(path)
    -- Matches regex from zip.vim / tar.vim
    path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
    path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
    return path
end

H.search_ancestors = function(startpath, func)
    if nvim_eleven then
        validate('func', func, 'function')
    end
    if func(startpath) then
        return startpath
    end
    local guard = 100
    for path in vim.fs.parents(startpath) do
        -- Prevent infinite recursion if our algorithm breaks
        guard = guard - 1
        if guard == 0 then
            return
        end

        if func(path) then
            return path
        end
    end
end

M.keymap_set = function(modes, lhs, rhs, opts)
    -- NOTE: Use `<C-H>`, `<C-Up>`, `<M-h>` casing (instead of `<C-h>`, `<C-up>`,
    -- `<M-H>`) to match the `lhs` of keymap info. Otherwise it will say that
    -- mapping doesn't exist when in fact it does.
    if type(modes) == 'string' then modes = { modes } end

    for _, mode in ipairs(modes) do
        -- Don't map if mapping is already set **globally**
        local map_info = H.get_map_info(mode, lhs)
        if not H.is_default_keymap(mode, lhs, map_info) then return end

        -- Map
        H.map(mode, lhs, rhs, opts)
    end
end

H.is_default_keymap = function(mode, lhs, map_info)
    if map_info == nil then return true end
    local rhs, desc = map_info.rhs or '', map_info.desc or ''

    -- Some mappings are set by default in Neovim
    if mode == 'n' and lhs == '<C-L>' then return rhs:find('nohl') ~= nil end
    if mode == 'n' and lhs == 'gO' and vim.fn.has('nvim-0.11') == 1 then return desc:find('vim%.lsp') ~= nil end
    if mode == 'i' and lhs == '<C-S>' then return desc:find('signature') ~= nil end
    if mode == 'x' and lhs == '*' then return rhs == [[y/\V<C-R>"<CR>]] end
    if mode == 'x' and lhs == '#' then return rhs == [[y?\V<C-R>"<CR>]] end
end

H.get_map_info = function(mode, lhs)
    local keymaps = vim.api.nvim_get_keymap(mode)
    for _, info in ipairs(keymaps) do
        if info.lhs == lhs then return info end
    end
end

H.map = function(mode, lhs, rhs, opts)
    if lhs == '' then return end
    opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
