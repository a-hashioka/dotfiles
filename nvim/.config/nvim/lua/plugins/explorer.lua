local explorer_root = function()
  Snacks.explorer({
    cwd = LazyVim.root(),
    hidden = true,
  })
end

local explorer_cwd = function()
  Snacks.explorer({
    hidden = true,
  })
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        hidden = true,
      },
    },
    keys = {
      {
        "<leader>e",
        explorer_root,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>fe",
        explorer_root,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>E",
        explorer_cwd,
        desc = "Explorer Snacks (cwd)",
      },
      {
        "<leader>fE",
        explorer_cwd,
        desc = "Explorer Snacks (cwd)",
      },
    },
  },
}
