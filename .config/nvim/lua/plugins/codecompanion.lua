return {
  -- CodeCompanion
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            name = "copilot",
            model = "gpt-4.1",
          },
          inline = {
            adapter = "copilot",
          },
        },
      })

      -- IMPORTANT: keep CodeCompanion buffers “plain” so renderers don't mess with input
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codecompanion",
        callback = function()
          vim.opt_local.conceallevel = 0
          vim.opt_local.concealcursor = ""
        end,
      })
    end,
  },

  -- ONE markdown renderer (keep this OR markview, not both)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }, -- do NOT include "codecompanion" here
    opts = {
      -- tune these to taste
      heading = { sign = false },
      checkbox = { enabled = true }, -- keeps - [ ] nice, but won't break editing
      bullet = { enabled = true },
      -- If you still find editing awkward in insert mode, don't conceal while typing:
      conceal = {
        level = 2, -- general conceal level when not typing
        cursor = { enabled = false }, -- reveal raw text under cursor while editing
      },
    },
  },

  -- REMOVE markview to avoid conflicts. If you prefer markview, disable render-markdown instead.
  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = { "markdown" },
  --   opts = {
  --     preview = {
  --       filetypes = { "markdown" },  -- not codecompanion
  --       ignore_buftypes = {},
  --     },
  --   },
  -- },

  -- mini.diff is fine
  {
    "nvim-mini/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({ source = diff.gen_source.none() })
    end,
  },

  -- img-clip (leave markdown + codecompanion if you actually paste images into chat)
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        markdown = {
          prompt_for_file_name = false,
          template = "![Image]($FILE_PATH)",
          use_absolute_path = false,
        },
        -- Keep this only if you really want to paste images into chat prompts.
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
