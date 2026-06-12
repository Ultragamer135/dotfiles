test -e /usr/share/cachyos-fish-config/cachyos-config.fish && source /usr/share/cachyos-fish-config/cachyos-config.fish
# Binds
function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

# Vars
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'

# Abbreviations
abbr --add :q exit # Yayy vim
function :q! # Kill session and exit
    tmux kill-session; exit
end
abbr --add pacman sudo pacman # Because I'm tired of typing 'sudo'
function '.'; nvim "+Oil $argv"; end
abbr --add s kitten ssh
abbr --add !! 'clear && exec fish'
which paru &>/dev/null && abbr yay paru

# Functions
function gitignore; curl -sL https://www.gitignore.io/api/$argv; end # Gitignore generator
function wttr; curl "https://wttr.in/$argv?1F"; end # Weather
function cheat; curl cheat.sh/(string join + $argv) | bat; end # Cheat sheet!
which cht.sh &>/dev/null && function cheat; cht.sh $argv | bat; end
function mkcd; mkdir -p $argv[1] && cd $argv[1]; end # Make a directory and enter it

# Go
fish_add_path /usr/local/go/bin
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
