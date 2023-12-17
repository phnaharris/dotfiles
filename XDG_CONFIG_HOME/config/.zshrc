# zmodload zsh/zprof
scripts_dir="/data/repos/phnaharris-machos/scripts"

export PATH=$scripts_dir:$scripts_dir/arch-only:$HOME/bin:/usr/sbin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/gems/bin:$PATH"
# export PATH="$HOME/.cabal/bin:$PATH"
# fnm
export PATH=$HOME/.local/share/fnm:$PATH
eval "$(fnm env)"

export EDITOR='nvim'

# [ -f "/opt/asdf-vm/asdf.sh" ] && source "/opt/asdf-vm/asdf.sh"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
# [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f "$scripts_dir/ssh-agent-script" ] && source "$scripts_dir/ssh-agent-script" 

if [[ "$TERM" != "screen-256color" ]]
then
    tmux attach-session -t "$USER" || tmux new-session -s "$USER"
fi

# Clangd import
# export LD_LIBRARY_PATH="/usr/lib/llvm-11/lib/clang/11.0.0/lib"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

for f in "$HOME"/.config/zsh/*; do source $f; done

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
# [[ -f /home/phnaharris/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/phnaharris/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh

# ==============================================================================
# pnpm
export PNPM_HOME="/home/phnaharris/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
# ==============================================================================

# zprof
