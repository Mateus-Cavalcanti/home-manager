zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit


# Material 3 round zsh theme
# main: https://github.com/owl4ce/dotfiles

NEWLINE='
'

# User's left prompt symbol.
if [ "${EUID:-$(id -u)}" -eq 0 ]; then
   #user_symbol='%F{1}%Bλ%b%f' # lambda
    user_symbol='%F{1}%f'     # arrow
else
   #user_symbol='%F{5}%Bλ%b%f' # lambda
    user_symbol='%F{4}%f'     # arrow
fi


export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH:+${CPLUS_INCLUDE_PATH}:}/nix/store/65yqj7frfnpr7kzf835x57qrs0c7q8n4-nlohmann_json-3.10.2/include/"
