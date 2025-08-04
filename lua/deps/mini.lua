local helpers = require('helpers.basic')
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function() require('mini.extra').setup() end)
now(function() require('mini.icons').setup() end)
now(function() require('mini.starter').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)

now(function()
    local MiniBasics = require('mini.basics')
    MiniBasics.setup({
        options = {
            extra_ui = true,
        },
        mappings = {
            basic = not helpers.is_mac,
            windows = not helpers.is_mac,
            move_with_alt = true,
        },
        autocommands = {
            relnum_in_visual_mode = true,
        },
    })

    if helpers.is_mac then
        local map = helpers.keymap_set

        -- Move by visible lines. Notes:
        -- - Don't map in Operator-pending mode because it severely changes behavior:
        --   like `dj` on non-wrapped line will not delete it.
        -- - Condition on `v:count == 0` to allow easier use of relative line numbers.
        map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
        map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

        -- Add empty lines before and after cursor line supporting dot-repeat
        MiniBasics.put_empty_line = function(put_above)
            -- This has a typical workflow for enabling dot-repeat:
            -- - On first call it sets `operatorfunc`, caches data, and calls
            --   `operatorfunc` on current cursor position.
            -- - On second call it performs task: puts `v:count1` empty lines
            --   above/below current line.
            if type(put_above) == 'boolean' then
                vim.o.operatorfunc = 'v:lua.MiniBasics.put_empty_line'
                MiniBasics.cache_empty_line = { put_above = put_above }
                return 'g@l'
            end

            local target_line = vim.fn.line('.') - (MiniBasics.cache_empty_line.put_above and 1 or 0)
            vim.fn.append(target_line, vim.fn['repeat']({ '' }, vim.v.count1))
        end

        -- NOTE: if you don't want to support dot-repeat, use this snippet:
        -- ```
        -- map('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
        -- map('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")
        -- ```
        map('n', 'gO', 'v:lua.MiniBasics.put_empty_line(v:true)', { expr = true, desc = 'Put empty line above' })
        map('n', 'go', 'v:lua.MiniBasics.put_empty_line(v:false)', { expr = true, desc = 'Put empty line below' })

        -- Copy/paste with system clipboard
        map({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
        map('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
        -- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
        map('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

        -- Reselect latest changed, put, or yanked text
        map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"',
            { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })

        -- Search inside visually highlighted text. Use `silent = false` for it to
        -- make effect immediately.
        map('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

        -- Search visually selected text (slightly better than builtins in
        -- Neovim<0.10 but slightly worse than builtins in Neovim>=0.10)
        -- TODO: Remove this after compatibility with Neovim=0.9 is dropped
        if vim.fn.has('nvim-0.10') == 0 then
            map('x', '*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = 'Search forward' })
            map('x', '#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = 'Search backward' })
        end

        -- Alternative way to save and exit in Normal mode.
        -- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified

        map('n', '<D-s>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' })
        map({ 'i', 'x' }, '<D-s>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

        -- Window navigation
        map('n', '<D-h>', '<C-w>h', { desc = 'Focus on left window' })
        map('n', '<D-j>', '<C-w>j', { desc = 'Focus on below window' })
        map('n', '<D-k>', '<C-w>k', { desc = 'Focus on above window' })
        map('n', '<D-l>', '<C-w>l', { desc = 'Focus on right window' })

        -- Window resize (respecting `v:count`)
        map('n', '<D-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
            { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
        map('n', '<D-Down>', '"<Cmd>resize -" . v:count1 . "<CR>"',
            { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
        map('n', '<D-Up>', '"<Cmd>resize +" . v:count1 . "<CR>"',
            { expr = true, replace_keycodes = false, desc = 'Increase window height' })
        map('n', '<D-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
            { expr = true, replace_keycodes = false, desc = 'Increase window width' })
    end
end)

now(function()
    local MiniFiles = require('mini.files')
    local find_root = require('mini.misc').find_root
    local map = helpers.keymap_set
    MiniFiles.setup()

    local root_files = {
        -- Common projects
        '.git',
        'Makefile',
        -- Java projects
        'build.xml',           -- Ant
        'pom.xml',             -- Maven
        'build.gradle',        -- Gradle
        'build.gradle.kts',    -- Gradle
        'settings.gradle',     -- Gradle
        'settings.gradle.kts', -- Gradle
        -- Python projects
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        -- JavaScript/TypeScript projects
        'package.json',   -- npm
        'pnpm-lock.yaml', -- pnpm
        'yarn.lock',      -- Yarn
        'bun.lockb',      -- Bun
        'tsconfig.json',  -- TypeScript
        'jsconfig.json',  -- JavaScript
    }

    local toggle = function()
        local current_buf = vim.api.nvim_get_current_buf()
        local root_dir = find_root(current_buf, root_files)
        if not MiniFiles.close() then
            MiniFiles.open(root_dir)
        end
    end
    local command = helpers.is_mac and '<D-E>' or '<C-E>'
    map({ 'n', 'v' }, command, toggle, { desc = 'Toggle file explorer' })
end)

now(function()
    local MiniIcons = require('mini.icons')
    MiniIcons.setup()
    MiniIcons.mock_nvim_web_devicons()
end)

now(function()
    local MiniNotify = require('mini.notify')
    MiniNotify.setup()
    vim.notify = MiniNotify.make_notify()
end)

later(function() require('mini.align').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.move').setup() end)
later(function() require('mini.operators').setup() end)
later(function() require('mini.pairs').setup() end)
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.jump2d').setup() end)
later(function() require('mini.sessions').setup() end)
later(function() require('mini.visits').setup() end)
later(function() require('mini.animate').setup() end)
later(function() require('mini.cursorword').setup() end)
later(function() require('mini.indentscope').setup() end)
later(function() require('mini.trailspace').setup() end)

later(function()
    local ai = require('mini.ai')
    local gen_ai_spec = require('mini.extra').gen_ai_spec
    ai.setup({
        custom_textobjects = {
            B = gen_ai_spec.buffer(),
            D = gen_ai_spec.diagnostic(),
            I = gen_ai_spec.indent(),
            L = gen_ai_spec.line(),
            N = gen_ai_spec.number(),
        },
    })
end)

later(function()
    local buf = require('mini.bufremove')
    local map = helpers.keymap_set
    map({ 'n', 'v' }, '<leader>bd', buf.delete, { desc = 'Delete Buffer' })
    map({ 'n', 'v' }, '<leader>bw', buf.wipeout, { desc = 'Wipeout Buffer' })
end)

later(function()
    local MiniClue = require('mini.clue')
    MiniClue.setup({
        triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            MiniClue.gen_clues.builtin_completion(),
            MiniClue.gen_clues.g(),
            MiniClue.gen_clues.marks(),
            MiniClue.gen_clues.registers(),
            MiniClue.gen_clues.windows(),
            MiniClue.gen_clues.z(),
        },
    })
end)

later(function()
    local mappings = {}
    if helpers.is_mac then
        mappings = {
            force_twostep = '<D-Space>',
            force_fallback = '<A-Space>',
            scroll_down = '<D-f>',
            scroll_up = '<D-b>',
        }
    else
        mappings = {
            force_twostep = '<C-Space>',
            force_fallback = '<A-Space>',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        }
    end
    require('mini.completion').setup({
        mappings = mappings,
    })
end)

later(function()
    local MiniPick = require('mini.pick')
    local pickers = require('mini.extra').pickers

    local mappings = {}
    if helpers.is_mac then
        mappings = {
            mark         = '<D-x>',
            mark_all     = '<D-a>',

            move_down    = '<D-j>',
            move_up      = '<D-k>',
            move_start   = '<D-g>',

            paste        = '<D-r>',

            refine       = '<D-Space>',

            scroll_down  = '<D-f>',
            scroll_left  = '<D-h>',
            scroll_right = '<D-l>',
            scroll_up    = '<D-b>',
        }
    else
        mappings = {
            move_down = '<C-j>',
            move_up   = '<C-k>',
        }
    end
    MiniPick.setup({
        mappings = mappings,
    })

    vim.ui.select = MiniPick.ui_select
    vim.keymap.set({ 'n', 'v' }, '<leader>pf', pickers.explorer, { desc = 'Open Pick files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>pc', pickers.commands, { desc = 'Open Pick commands' })
end)

later(function()
    local MiniHipatterns = require('mini.hipatterns')
    local words = require('mini.extra').gen_highlighter.words
    MiniHipatterns.setup({
        highlighters = {
            fixme = words({ 'FIXME' }, 'MiniHipatternsFixme'),
            hack = words({ 'HACK' }, 'MiniHipatternsHack'),
            todo = words({ 'TODO' }, 'MiniHipatternsTodo'),
            note = words({ 'NOTE' }, 'MiniHipatternsNote'),

            hex_color = MiniHipatterns.gen_highlighter.hex_color(),
        },
    })
end)


later(function()
    local MiniSnippets = require('mini.snippets')
    local gen_loader = MiniSnippets.gen_loader
    MiniSnippets.setup({
        snippets = {
            -- Load custom file with global snippets first (adjust for Windows)
            gen_loader.from_file('~/.config/nvim/snippets/global.json'),

            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
    })
end)
