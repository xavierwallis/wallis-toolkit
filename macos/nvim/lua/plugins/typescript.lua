return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
          },
        },
        ts_ls = {
          init_options = {
            tsserver = {
              path = 'node_modules/typescript/lib/tsserver.js',
            },
          },
        },
      },
    },
  },
}
