if [[ "$(uname -s)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node 1password azure github brew docker dotnet gh helm history kubectl kubectx macos alias-tips)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
alias copilot="gh copilot"
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az


export PATH=$HOME/.dotnet/tools:$PATH
# nvm
source ~/.nvm/nvm.sh

kexec() {
  local namespace=""
  local pod_name=""

  while [[ $# -gt 0 ]]; do
    case $1 in
      -n|--namespace)
        namespace="$2"
        shift # past argument
        shift # past value
        ;;
      *)
        pod_name="$1"
        shift # past argument
        ;;
    esac
  done

  if [ -z "$pod_name" ]; then
    echo "Usage: kexec [-n namespace] <pod-name>"
    return 1
  fi

  if [ -n "$namespace" ]; then
    kubectl exec --stdin --tty "$pod_name" -n "$namespace" -- /bin/bash
  else
    kubectl exec --stdin --tty "$pod_name" -- /bin/bash
  fi
}

gconfig_ssh() {
  if [ -z "$1" ]; then
    echo "Usage: gconfig_ssh <path_to_ssh_key>"
    return 1
  fi

  git config --add --local core.sshCommand "ssh -i $1"
}
screenlayout() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: screenlayout <home|work>"
        return 1
    fi

    case $1 in
        home)
            displayplacer "id:6EBF5F0B-FC9C-427D-B97D-D9656B659F67 res:2560x1440 hz:60 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0" "id:52AC177D-CA6B-449C-A1C6-971A1DCD16B4 res:2560x1440 hz:144 color_depth:8 enabled:true scaling:off origin:(2560,0) degree:0"
            ;;
        work)
            echo "work"
            ;;
        *)
            echo "Invalid argument. Use 'home' or 'work'."
            return 1
            ;;
    esac
}

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory comp
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=Dracula

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# --- Env vars
FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1
alias cls="clear"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- cursor --- If it is installed on Linux, needed due to being an AppImage, expects to use my install script
if [[ "$(uname -s)" == "Linux" ]]; then
  cursor() {
    local INSTALL_DIR="$HOME/.local/bin"
    local cursor_app="$INSTALL_DIR/Cursor.AppImage"
    
    if [ -f "$cursor_app" ]; then
      "$cursor_app" --no-sandbox "$@" &> ~/.cursor.log &
    else
      echo "Cursor not found at $cursor_app"
      return 1
    fi
  }
fi

# End of Docker CLI completions
alias gemini-docker='docker run --rm -it \
  -v "${HOME}/.gemini:/home/appuser/.gemini" \
  -e HOST_USER_ID="$(id -u)" \
  -e HOST_GROUP_ID="$(id -g)" \
  -e GEMINI_API_KEY="$(op read "op://Private/ipx7cvrwnk4juhkleksbyycnwa/credential")" \
  -v "$(pwd)":/home/appuser/workspace \
  gemini-cli'
. "$HOME/.local/bin/env"

git_force_remote_truth() {
  emulate -L zsh
  set -euo pipefail

  usage() {
    cat <<'USAGE'
Usage: git-remote-truth [--no-clean] [--push-backup] [--remote <name>] [--no-backup] [--force-upstream] [--yes] [--help]
USAGE
  }

  # Defaults
  local remote="origin"
  local do_clean=1
  local do_backup=1
  local push_backup=0
  local force_upstream=0
  local assume_yes=0

  # Parse args
  while (( $# )); do
    case "$1" in
      --no-clean) do_clean=0; shift ;;
      --push-backup) push_backup=1; shift ;;
      --remote)
        if (( $# < 2 )) || [[ -z "${2:-}" ]] || [[ "$2" == --* ]]; then
          echo "--remote requires a value (e.g., --remote origin)"; return 2
        fi
        remote="$2"; shift 2 ;;
      --no-backup) do_backup=0; shift ;;
      --force-upstream) force_upstream=1; shift ;;
      --yes) assume_yes=1; shift ;;
      --help|-h) usage; return 0 ;;
      *) echo "Unknown option: $1"; usage; return 2 ;;
    esac
  done

  # Ensure we are in a git repo
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a git repository."
    return 1
  fi

  # Determine current branch
  local current_branch
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  if [[ "$current_branch" == "HEAD" || -z "${current_branch:-}" ]]; then
    echo "Detached HEAD; checkout a branch first."
    return 1
  fi

  # Verify remote exists
  if ! git remote get-url "$remote" >/dev/null 2>&1; then
    echo "Remote '$remote' not found."
    return 1
  fi

  # Ensure upstream exists or set if asked/possible
  if git rev-parse --abbrev-ref "@{upstream}" >/dev/null 2>&1; then
    :
  else
    if (( force_upstream )); then
      if git ls-remote --exit-code --heads "$remote" "$current_branch" >/dev/null 2>&1; then
        echo "Setting upstream to $remote/$current_branch"
        git branch --set-upstream-to "$remote/$current_branch" "$current_branch"
      else
        echo "Remote branch $remote/$current_branch does not exist."
        return 1
      fi
    else
      echo "No upstream for '$current_branch'. Use --force-upstream or set it manually."
      return 1
    fi
  fi

  local ts backup_branch ans
  ts="$(date +%Y%m%d-%H%M%S)"
  backup_branch="backup/${current_branch}-${ts}"

  # Confirmation
  if (( ! assume_yes )); then
    echo "About to force-sync '$current_branch' to '$remote/$current_branch'."
    echo "Actions:"
    if (( do_backup )); then
      echo "  - Create backup branch: $backup_branch"
    else
      echo "  - NO BACKUP (dangerous)"
    fi
    echo "  - git fetch $remote"
    echo "  - git reset --hard $remote/$current_branch"
    if (( do_clean )); then
      echo "  - git clean -fdx"
    else
      echo "  - Skip clean"
    fi
    if [ -t 0 ]; then
      printf "Proceed? [y/N]: "
      ans=""
      read -r ans || true
      case "${ans:-}" in
        y|Y|yes|YES) ;;
        *) echo "Aborted."; return 1 ;;
      esac
    else
      echo "Non-interactive shell detected; use --yes to proceed."
      return 1
    fi
  fi

  if (( do_backup )); then
    echo "Creating backup branch: $backup_branch"
    git switch -c "$backup_branch"

    echo "Staging all changes (including untracked)"
    git add -A
    if ! git diff --cached --quiet || ! git diff --quiet; then
      git commit -m "Backup before remote-truth reset from $current_branch @ $ts"
    else
      echo "No local changes to commit; backup branch still created."
    fi

    if (( push_backup )); then
      echo "Pushing backup branch to $remote"
      git push -u "$remote" "$backup_branch"
    fi

    echo "Switching back to $current_branch"
    git switch "$current_branch"
  else
    echo "WARNING: --no-backup specified. Proceeding without backup."
  fi

  echo "Fetching from $remote"
  git fetch "$remote"

  echo "Hard resetting $current_branch to $remote/$current_branch"
  git reset --hard "$remote/$current_branch"

  if (( do_clean )); then
    echo "Cleaning untracked files and directories"
    git clean -fdx
  else
    echo "Skipping clean due to --no-clean"
  fi

  echo "Done. '$current_branch' now matches $remote/$current_branch"
}

alias git-remote-truth='git_force_remote_truth'


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
if [ -d "$HOME/.docker/completions" ]; then
  fpath=($HOME/.docker/completions $fpath)
fi
autoload -Uz compinit
compinit