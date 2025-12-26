set relativenumber
set termguicolors
set number
	set tabstop=4
	set shiftwidth=4
let g:clipboard="xclip"


call plug#begin('~/.local/share/nvim/plugged')

Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'm4xshen/autoclose.nvim'

Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'tommcdo/vim-lion'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-scripts/a.vim'
Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'https://codeberg.org/ziglang/zig.vim'

call plug#end()

nmap <leader>n :NERDTreeFocus<CR>
nmap <C-n> :NERDTree<CR>
nmap <C-t> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

set shell=/bin/zsh

colorscheme moonfly

lua require'colorizer'.setup()
lua require("autoclose").setup()

filetype plugin on

let g:zig_fmt_autosave = 0

lua << EOF
local cmp = require('cmp')

vim.diagnostic.config({
  signs = false,
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  underline = true,
  update_in_insert = false,
})

local function filter_diagnostics(diagnostics)
  local filtered = {}
  for _, d in ipairs(diagnostics) do
    local msg = d.message:lower()
    if not (
      msg:find("unused") or
      msg:find("declared but not used") or
      msg:find("defined but not used")
    ) then
      table.insert(filtered, d)
    end
  end
  return filtered
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
  result.diagnostics = filter_diagnostics(result.diagnostics)
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  local bufmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  bufmap("n", "K", vim.lsp.buf.hover, "LSP Hover")
end

vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never", 
    "--clang-tidy"             
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.enable('clangd')


if os.getenv("WAYLAND_DISPLAY") then
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
      ['+'] = 'wl-copy',
      ['*'] = 'wl-copy',
    },
    paste = {
      ['+'] = 'wl-paste --no-newline',
      ['*'] = 'wl-paste --no-newline',
    },
    cache_enabled = 1,
  }
end

vim.opt.clipboard = "unnamedplus"

-- Configuración para Python (Pyright)
vim.lsp.config('pyright', {
  cmd = { "pyright-langserver", "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      }
    }
  }
})

vim.lsp.enable('pyright')

-- Zig (ZLS) Configuration
vim.lsp.config('zls', {
  cmd = { "zls" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    zls = {
      -- Hint: Set this to true if you want parameter names shown in your code
      enable_inlay_hints = true,
      warn_style = true,
    }
  }
})

vim.lsp.enable('zls')

EOF
