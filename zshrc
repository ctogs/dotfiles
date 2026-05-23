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

# Create a tmux dev session with a Cursor-style pane layout:
#   +----------------+--------+
#   | nvim (editor)  | claude |
#   +----------------+        |
#   | server         |        |
#   +----------------+--------+
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

  # Pane 0: nvim (left, full height initially)
  tmux new-session -d -s "$name" -n dev -c "$dir" "${env_args[@]}" "nvim"

  # Pane 1: claude on the right (~30% width)
  tmux split-window -h -t "=$name:dev" -p 30 -c "$dir" "${env_args[@]}"

  # Pane 2: server below the editor (~25% of left column height)
  tmux split-window -v -t "=$name:dev.0" -p 25 -c "$dir" "${env_args[@]}"

  # Focus the editor pane
  tmux select-pane -t "=$name:dev.0"
  tmux attach -t "=$name"
}

# Auto-activate venv if DEV_VENV is set by tmux session
if [[ -n "$DEV_VENV" && -f "$DEV_VENV" ]]; then
  source "$DEV_VENV"
fi

alias venv="source .venv/bin/activate"
