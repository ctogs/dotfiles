return {
  {
    "carlos-rodrigo/claude-code.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeFocus" },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
    },
    opts = {
      -- Optional: if claude is installed in a custom directory
      -- terminal_cmd = "claude", 
    },
  }
}
