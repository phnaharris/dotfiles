# zmodload zsh/zprof

scripts_dir="/DATA/WORK/Personal/scripts"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/sbin
# export PATH="$HOME/gems/bin:$PATH"
# export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$scripts_dir:$PATH"
export PATH="$scripts_dir/arch-only:$PATH"
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


# autoload -Uz compinit
# compinit

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"

for f in "$HOME"/.config/zsh/*; do source $f; done

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# zprof

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/phnaharris/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/phnaharris/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh
