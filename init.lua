vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
local g = vim.g

opt.relativenumber = true
opt.number = true
opt.termguicolors = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.shell = "/bin/zsh"
opt.clipboard = "unnamedplus"

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.zig_fmt_autosave = 0

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

if os.getenv("WAYLAND_DISPLAY") then
  g.clipboard = {
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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- Lazy
require("lazy").setup({
  
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme moonfly")
    end,
  },

  { "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
  "luochen1990/rainbow",
  { "m4xshen/autoclose.nvim", config = true },
  "tommcdo/vim-lion",
  "ryanoasis/vim-devicons",

  "nvim-tree/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
		  options = { 
			theme = "moonfly" 
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'filename'},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {'filetype'},
			lualine_z = {'progress'},
		},
		options = {
			theme = 'moonfly'
		}
	  })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require('cmp')
      
      vim.diagnostic.config({
        signs = false,
        virtual_text = { spacing = 2, prefix = "●" },
        underline = true,
        update_in_insert = false,
      })

      local function filter_diagnostics(diagnostics)
        local filtered = {}
        for _, d in ipairs(diagnostics) do
          local msg = d.message:lower()
          if not (msg:find("unused") or msg:find("declared but not used") or msg:find("defined but not used")) then
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
        sources = { { name = 'nvim_lsp' } },
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
    "--clang-tidy",
    "--pch-storage=memory",
    "-j=4"
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.enable('clangd')
    end,
  }
})


local map = vim.keymap.set
map('n', '<leader>n', ':NvimTreeFocus<CR>', { silent = true, desc = "Focus NvimTree" })
map('n', '<C-n>', ':NvimTreeOpen<CR>', { silent = true, desc = "Open NvimTree" })
map('n', '<C-t>', ':NvimTreeToggle<CR>', { silent = true, desc = "Toggle NvimTree" })
map('n', '<C-f>', ':NvimTreeFindFile<CR>', { silent = true, desc = "Find file in NvimTree" })



require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "bash", "lua", "markdown"},
	highlight = {
		enable = true
	}
}
