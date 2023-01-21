# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/sbin
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="$HOME/Repos/dotfiles/scripts/bin:$PATH"
export PATH="$HOME/Repos/dotfiles/scripts/scripts:$PATH"

# fnm
export PATH=$HOME/.local/share/fnm:$PATH
eval "$(fnm env)"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"

export EDITOR='nvim'

[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f "$HOME/Repos/dotfiles/scripts/bin/ssh-agent-script" ] && source "$HOME/Repos/dotfiles/scripts/bin/ssh-agent-script" 

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


