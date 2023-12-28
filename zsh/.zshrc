############################################################
#               Powerlevel10k Instant Prompt               #
############################################################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


############################################################
#                      Antigen Setup                       #
############################################################

ADOTDIR="$HOME/.config/antigen_bundles"
ANTIGEN_LOG="$ADOTDIR/error.log"

ANTIGEN_DIR="$HOME/.config/antigen_src"
[[ ! -d "$ANTIGEN_DIR" ]] && git clone https://github.com/zsh-users/antigen.git "$ANTIGEN_DIR"

source "$ANTIGEN_DIR/antigen.zsh"


############################################################
#                         Plugins                          #
############################################################

#antigen bundle zsh-users/zsh-completions
#antigen bundle belak/zsh-utils@main completion
antigen bundle belak/zsh-utils@main history
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Aloxaf/fzf-tab
antigen bundle agkozak/zsh-z 

antigen theme romkatv/powerlevel10k

antigen apply


############################################################
#                       Zsh settings                       #
############################################################

source "$HOME/.dotfiles/zsh/.aliasesrc"

# Hide ugly '%' at end of printed file output
export PROMPT_EOL_MARK=''

# Setting default LS_COLORS
dircolors --print-database > ~/.dircolors
eval "$(dircolors -b ~/.dircolors)"

# Disable windows folder highlighting
LS_COLORS=$LS_COLORS:'ow=1;34:' ; export LS_COLORS

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Optionally, ignore case when completing paths
zstyle ':completion:*:paths' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Setting default man to bat
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"


############################################################
#                     Plugin settings                      #
############################################################

# Autocomplete bindings
function zvm_after_init() {
	bindkey -M viins "^k" autosuggest-accept
	bindkey -M viins "^j" autosuggest-execute

	bindkey -M vicmd "H" vi-first-non-blank
	bindkey -M viopp "H" vi-first-non-blank
	bindkey -M visual "H" vi-first-non-blank

	bindkey -M vicmd "L" vi-end-of-line
	bindkey -M viopp "L" vi-end-of-line
	bindkey -M visual "L" vi-end-of-line
}

export ZSHZ_DATA="$HOME/.local/share/zsh/z"

ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_VI_HIGHLIGHT_FOREGROUND=white
ZVM_VI_HIGHLIGHT_BACKGROUND=blue

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.dotfiles/p10k/.p10k.zsh ]] || source ~/.dotfiles/p10k/.p10k.zsh
