return {
  {
    "filipjanevski/0x96f.nvim",
    priority = 1000,
    config = function()
      require("0x96f").setup()
      vim.cmd.colorscheme("0x96f")
    end,
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false, -- Load immediately on startup
    opts = {
      -- Add highlight groups to be made transparent
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "LazyNormal",
        "MasonNormal",
        "TelescopeNormal",
        "TelescopeBorder",
        "FloatBorder",
        -- Snacks.nvim specific groups
        "SnacksDashboardNormal",
        "SnacksDashboardHeader",
        "SnacksDashboardFooter",
        "SnacksDashboardDesc",
        "SnacksDashboardKey",
        "SnacksDashboardDir",
        "SnacksDashboardIcon",
      },
    },
    config = function(_, opts)
      require("transparent").setup(opts)
      -- Enable transparency on startup
      vim.cmd("TransparentEnable")
    end,
  },
}
