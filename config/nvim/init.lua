local utils = require('utils')
local map, opt = utils.map, utils.opt
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g

-- PLUGINS ---------------------------------------------------------------------
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'vim-scripts/vim-auto-save'
    use 'ntpeters/vim-better-whitespace'
    use 'tpope/vim-endwise'
    use 'tpope/vim-commentary'
    use 'prettier/vim-prettier'
    use 'airblade/vim-gitgutter'
    use 'srstevenson/vim-picker'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'MattesGroeger/vim-bookmarks'

    -- use 'SirVer/ultisnip'
    -- use 'nvim-lua/completion-nvim'
    -- use 'honza/vim-snippets'
    -- use 'kyazdani42/nvim-web-devicons'
    -- use 'hoob3rt/lualine.nvim'
    -- use 'nvim-lua/plenary.nvim'
    -- use 'nvim-lua/popup.nvim'
    -- use 'nvim-telescope/telescope.nvim'
    -- use 'nvim-telescope/telescope-fzy-native.nvim'

  end
)

-- COLORSCHEME -----------------------------------------------------------------
g.gruvbox_contrast_dark = 'hard'
g.background = 'dark'
cmd 'colorscheme gruvbox'

-- OPTIONS ---------------------------------------------------------------------
local indent, width = 2, 80

g.mapleader = ' '

opt('b', 'expandtab', true)                 -- Use spaces instead of tabs
opt('o', 'hidden', true)                    -- Enable background buffers
opt('b', 'shiftwidth', indent)              -- Size of an indent
opt('b', 'tabstop', indent)                 -- Number of spaces tabs count for
opt('b', 'softtabstop', indent)             -- Tab count while in edit
-- opt('b', 'textwidth', width)                -- Maximum width of text
opt('b', 'smartindent', true)               -- Insert indents automatically
opt('o', 'mouse', 'a')                      -- Enable mouse support
opt('o', 'ignorecase', true)                -- Ignore case in search patterns
opt('o', 'smartcase', true)                 -- Override ignorecase uppercase
opt('o', 'scrolloff', 10)                   -- Lines of context
opt('o', 'termguicolors', true)             -- True color support
opt('o', 'swapfile', false)                 -- Disable swap files
opt('w', 'colorcolumn', (width + 1)..',100')-- Line length marker
opt('w', 'cursorline', true)                -- Highlight cursor line
opt('w', 'signcolumn', 'yes')               -- Show sign column
-- opt('w', 'wrap', false)                     -- Disable line wrap
opt('b', 'undofile', true)                  -- Enable undo files
opt('o', 'clipboard', 'unnamedplus')        -- Share system clipboard
opt('o', 'updatetime', 100)                 -- Faster buffer updates

-- TREE-SITTER -----------------------------------------------------------------
require 'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {enable = true},
  indent = {enable = true}
}

-- LSP -------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local elixirls = fn.expand("~/Projects/forks/elixir-ls/release/language_server.sh")

lspconfig.elixirls.setup({
  cmd = {elixirls},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
})


-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
-- require "cmp".setup {
--   enabled = true,
--   autocomplete = true,
--   debug = false,
--   min_length = 1,
--   preselect = "disabled",
--   throttle_time = 80,
--   source_timeout = 200,
--   incomplete_delay = 400,
--   max_abbr_width = 100,
--   max_kind_width = 100,
--   max_menu_width = 100,
--   documentation = true,
--   source = {
--     path = true,
--     buffer = true,
--     calc = true,
--     vsnip = true,
--     nvim_lsp = true,
--     nvim_lua = true,
--     spell = true,
--     tags = true,
--     treesitter = true
--   }
-- }
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })


-- MAPPINGS --------------------------------------------------------------------
-- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<C-h>', '<cmd>lua vim.lsp.buf.hover()<CR>')
