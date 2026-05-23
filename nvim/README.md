# Neovim (LazyVim) Cheatsheet

Leader key is `<Space>`. So `<leader>ac` means tap `Space`, then `a`, then `c`.

## Claude Code

Native diff buffers from `coder/claudecode.nvim` — Claude's edits appear as
nvim diff splits in the context of the real file.

| Keys | Mode | Action |
|------|------|--------|
| `<leader>ac` | n | Toggle Claude (open/close the right-side terminal split) |
| `<leader>af` | n | Focus the Claude pane (jump cursor into it) |
| `<leader>ab` | n | Add the **current buffer** to Claude as context |
| `<leader>as` | v | Send the **visual selection** to Claude |
| `<leader>aa` | n | **Accept** the proposed diff |
| `<leader>ad` | n | **Deny** the proposed diff |

Inside the Claude terminal:
- `/clear` — wipe conversation, stay in same session
- `/exit` (or `Ctrl-C` twice) — end session (saved to history)
- `claude --resume` — fuzzy-pick any past session in this directory
- `claude --continue` — resume the most recent session

## Editor terminal

Bottom split, scoped to the editor column (does **not** push neo-tree).

| Keys | Mode | Action |
|------|------|--------|
| `<C-\>` | n / t | Toggle terminal |
| `<leader>tt` | n | Toggle terminal (alternative) |
| `<C-x>` | t | Exit terminal mode (back to normal-mode in the terminal) |

## File tree / pickers

| Keys | Action |
|------|--------|
| `<leader>e` | Toggle neo-tree sidebar |
| `<leader><Space>` | Fuzzy find file in project |
| `<leader>/` | Live grep across project |
| `<leader>sw` | Grep word under cursor |
| `<leader>ss` | Symbols in current buffer (functions/classes) |
| `<leader>sS` | Symbols across workspace |
| `<leader>fp` | Switch project (via `util.project` extra) |
| `<leader>fr` | Recent files |

## LSP (the "IDE features")

| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gr` | Find references (opens picker) |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover docs |
| `<leader>cr` | Rename symbol (all references in project) |
| `<leader>ca` | Code action |
| `<leader>cf` | Format buffer |
| `]d` / `[d` | Next / previous diagnostic |

## Navigation

| Keys | Action |
|------|--------|
| `<C-h/j/k/l>` | Move across nvim splits **and** tmux panes |
| `<leader>1..9` | Jump to harpoon pin #N |
| `<leader>H` | Add current file to harpoon |
| `<leader>h` | Open harpoon picker |
| `]h` / `[h` | Next / previous git hunk |
| `<leader>gB` | Git blame for current line |

## Sticky function header

`treesitter-context` pins the enclosing function/class to the top of the
window while scrolling.

| Keys | Action |
|------|--------|
| `<leader>ut` | Toggle treesitter-context |

## Theme

Set in `lua/plugins/colorscheme.lua`. Currently `gruvbox-material` (hard, warm).

- Preview/switch live: `<leader>uC` (fuzzy picker)
- Make permanent: edit the `colorscheme = "..."` line in `colorscheme.lua`

## Sessions

LazyVim's persistence.nvim auto-saves a session per directory.

| Keys | Action |
|------|--------|
| `<leader>qs` | Restore session for current directory |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session on exit |

## Boot layout (from `dev` / `devw`)

`<leader>e` to open the sidebar, `<C-\>` to open the terminal. (The
auto-open hook was removed — open manually each time.)
