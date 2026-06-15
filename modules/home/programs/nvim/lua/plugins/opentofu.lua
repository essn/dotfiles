return {
  -- Configure terraform-ls to use the OpenTofu binary
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          settings = {
            ["terraform-ls"] = {
              terraformExecPath = vim.fn.exepath("tofu"), -- resolves 'tofu' from $PATH
            },
          },
        },
      },
    },
  },

  -- Use 'tofu fmt' instead of 'terraform fmt'
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "tofu_fmt" },
        ["terraform-vars"] = { "tofu_fmt" },
      },
      formatters = {
        tofu_fmt = {
          command = "tofu",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
}
