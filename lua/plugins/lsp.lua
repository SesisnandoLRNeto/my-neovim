return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").tsserver.setup({})
    require("lspconfig").eslint.setup({})
    require("lspconfig").html.setup({})
    require("lspconfig").cssls.setup({})
    require("lspconfig").tailwindcss.setup({})
    require("lspconfig").emmet_ls.setup({})
    require("lspconfig").angularls.setup({})
    require("lspconfig").volar.setup({})
  end,
}
