local cmp = require "cmp"

local plugins = {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = {
        "rust-analyzer",
      },
    },
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers {
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function (server_name) -- default handler (optional)
              require("lspconfig")[server_name].setup {}
          end,
          -- Next, you can provide a dedicated handler for specific servers.
          -- For example, a handler override for the `rust_analyzer`:
          ["rust_analyzer"] = function ()
            local opts = require "custom.configs.rust-tools"
            require('rust-tools').setup(opts)
          end
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, _)
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = function ()
      return require "custom.configs.copilot"
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end
  },
  -- {
  --   "andweeb/presence.nvim",
  --   lazy = false,
  --   opts = function ()
  --     return require "custom.configs.presence"
  --   end,
  --   config = function(_, opts)
  --     require('presence').setup(opts)
  --   end
  -- },
  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('devcontainer').setup{}
    end
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  }
}
return plugins
