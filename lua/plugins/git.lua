return {
  -- Merge conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
      default_mappings = true, -- co (ours), ct (theirs), cb (both), c0 (none), ]x/[x (nav)
      disable_diagnostics = true,
    },
  },
  -- Git signs in gutter (already in LazyVim, just ensure config)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },
}
