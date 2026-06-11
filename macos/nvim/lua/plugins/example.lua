-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
--  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
--      colorscheme = "gruvbox",
    },
  },
  -- using lazy.nvim
  {
  "lopi-py/luau-lsp.nvim",
  dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim"
    },
  opts = {
      platform = {
        type = "roblox",
      },
      sourcemap = {
        enabled = true,
        autogenerate = true
      },
      server = {
        path = vim.fn.stdpath("data") .. "/mason/bin/luau-lsp",
      },
      fflags = {
        override = {
          LuauSolverV2 = false,
        },
      },
  },
},

  { 'augmentcode/augment.vim' },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      background = {
        light = "latte",
        dark = "mocha",
      },
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
      },
      integrations = {
        snacks = {
          enabled = true,
          indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          },
        neotree = true, -- important for neo-tree highlight linking
      }
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- change trouble config

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },


  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  { "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
    },
    opts = {
      autoformat = false,
      servers = {
        pyright = {},
        tsserver = {},
        rust_analyzer = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },


  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "luau"
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },
    -- use mini.starter instead of alpha
--  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
      automatic_enable = {
        exclude = { "luau_lsp" },
      },
    },
  },
  {
  "gruvw/strudel.nvim",
  build = "npm install",
  config = function()
    require("strudel").setup()
  end,
}
}
