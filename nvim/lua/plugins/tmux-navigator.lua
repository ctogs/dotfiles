return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left (tmux/nvim)" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down (tmux/nvim)" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up (tmux/nvim)" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right (tmux/nvim)" },
    },
  },
}
