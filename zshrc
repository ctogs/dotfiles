# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/collintogher/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/collintogher/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/collintogher/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/collintogher/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/opt/homebrew/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/opt/go/bin:$PATH"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
ZSH_THEME="powerlevel10k/powerlevel10k" 
plugins=(git python virtualenv)
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Create a tmux dev session
dev() {
  local dir="${1:-.}"
  dir="$(cd "$dir" && pwd)"
  local name="$(basename "$dir")"

  # Attach if session already exists
  if tmux has-session -t "$name" 2>/dev/null; then
    tmux attach -t "$name"
    return
  fi

  # Detect venv location
  local venv_path=""
  if [[ -f "$dir/.venv/bin/activate" ]]; then
    venv_path="$dir/.venv/bin/activate"
  elif [[ -f "$dir/backend/.venv/bin/activate" ]]; then
    venv_path="$dir/backend/.venv/bin/activate"
  fi

  local env_args=()
  [[ -n "$venv_path" ]] && env_args=(-e "DEV_VENV=$venv_path")

  tmux new-session -d -s "$name" -n editor -c "$dir" "${env_args[@]}" "nvim"
  tmux new-window -d -t "=$name" -n shell -c "$dir" "${env_args[@]}"
  tmux attach -t "=$name"
}

# Add a worktree as a new window in the current tmux session.
# Usage: devw <name>          # creates .worktrees/<name> on a new branch <name>
#        devw <name> <ref>    # creates worktree from existing branch/ref
#        devw <path>          # opens an existing path as a window
devw() {
  local arg="${1:?usage: devw <name|path> [ref]}"
  local ref="$2"

  if [[ -z "$TMUX" ]]; then
    echo "devw must be run inside a tmux session"
    return 1
  fi

  local repo_root dir name
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [[ -z "$repo_root" ]]; then
    echo "devw: not inside a git repo"
    return 1
  fi

  # If arg is an existing directory, treat it as a path; otherwise treat as a worktree name.
  if [[ -d "$arg" ]]; then
    dir="$(cd "$arg" && pwd)"
    name="$(basename "$dir")"
  else
    name="$arg"
    dir="$repo_root/.worktrees/$name"
    if [[ ! -d "$dir" ]]; then
      mkdir -p "$repo_root/.worktrees"
      if [[ -n "$ref" ]]; then
        git -C "$repo_root" worktree add "$dir" "$ref" || return 1
      elif git -C "$repo_root" show-ref --verify --quiet "refs/heads/$name"; then
        git -C "$repo_root" worktree add "$dir" "$name" || return 1
      else
        git -C "$repo_root" worktree add -b "$name" "$dir" || return 1
      fi
    fi
  fi

  local session
  session="$(tmux display-message -p '#S')"

  if tmux list-windows -t "=$session" -F '#W' | grep -qx "$name"; then
    tmux select-window -t "=$session:$name"
    return
  fi

  local venv_path=""
  [[ -f "$dir/.venv/bin/activate" ]] && venv_path="$dir/.venv/bin/activate"
  [[ -z "$venv_path" && -f "$dir/backend/.venv/bin/activate" ]] && venv_path="$dir/backend/.venv/bin/activate"

  local env_args=()
  [[ -n "$venv_path" ]] && env_args=(-e "DEV_VENV=$venv_path")

  tmux new-window -t "=$session" -n "$name" -c "$dir" "${env_args[@]}" "nvim"
}

# Auto-activate venv if DEV_VENV is set by tmux session
if [[ -n "$DEV_VENV" && -f "$DEV_VENV" ]]; then
  source "$DEV_VENV"
fi

alias venv="source .venv/bin/activate"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
