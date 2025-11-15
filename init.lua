-- Basic options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
-- Auto-install vim-plug
local data_dir = vim.fn.stdpath('data')
local plug_autoload = data_dir .. '/site/autoload/plug.vim'
local plug_dir = data_dir .. '/plugged'
if vim.fn.empty(vim.fn.glob(plug_autoload)) == 1 then
  vim.fn.system({
    'sh', '-c',
    'curl -fLo ' ..
    vim.fn.shellescape(plug_autoload) ..
    ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.cmd('silent! PlugInstall --sync | source $MYVIMRC')
    end,
  })
end

local Plug = vim.fn['plug#']
vim.call('plug#begin', plug_dir)

-- UI
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
Plug('junegunn/fzf.vim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')

-- Git
Plug('lewis6991/gitsigns.nvim')

-- Coding
Plug('MagicDuck/grug-far.nvim')
Plug('neovim/nvim-lspconfig')
Plug('numToStr/Comment.nvim')
Plug('preservim/tagbar')
Plug('windwp/nvim-autopairs')

vim.call('plug#end')

-- Auto-install missing plugins on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local plugs = vim.g.plugs or {}
    local missing = {}
    for name, plugin in pairs(plugs) do
      if vim.fn.isdirectory(plugin.dir) == 0 then
        table.insert(missing, name)
      end
    end
    if #missing > 0 then
      vim.cmd('silent! PlugInstall --sync | source $MYVIMRC')
    end
  end
})

-- UI
vim.cmd.colorscheme "catppuccin-mocha"
require("ibl").setup()
require("nvim-tree").setup()
require('lualine').setup()

-- Git
require('gitsigns').setup({ current_line_blame = true })

-- Coding
require('Comment').setup()
require('nvim-autopairs').setup()

--------------------------------------------------------------------------------
-- Key mappings
--------------------------------------------------------------------------------
-- UI
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

-- FZF
vim.keymap.set('n', '<leader>fc', ':Rg<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', ':GFiles<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fr', ':GrugFar<CR>', { noremap = true, silent = true })

-- Diagnostic navigation
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Next diagnostic' })

-- Coding
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ timeout_ms = 2000 }) end,
  { desc = 'Format current buffer' })

--------------------------------------------------------------------------------
-- Diagnostics & LSP
--------------------------------------------------------------------------------
vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = true,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {
    '*.bash',
    '*.command',
    '*.inc',
    '*.lua',
    '*.py',
    '*.sh',
    'PKGBUILD'
  },
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})

-- Bash
vim.lsp.enable('bashls')
vim.lsp.config('bashls', {
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|PKGBUILD)"
    }
  },
})

-- Lua
vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config') and
          (vim.fn.filereadable(path .. '/.luarc.json') == 1 or
            vim.fn.filereadable(path .. '/.luarc.jsonc') == 1)
      then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force',
      client.config.settings.Lua, {
        format = {
          enable = true,
        },
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
  end,
  settings = {
    Lua = {
      format = {
        enable = true,
      }
    }
  }
})

-- Python
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

