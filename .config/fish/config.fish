# Launch tmux on startup
if status is-interactive
and set -q WSL_DISTRO_NAME # Only if running in WSL
and not set -q TMUX # No nesting tmux!
    exec tmux new-session -t T \; if-shell "test '$(tmux list-windows | count)' -gt 0" "new-window"
end

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
abbr --add '.' nvim "+Oil $argv"
abbr --add s kitten ssh
abbr --add !! 'clear && exec fish'

# Go
fish_add_path /usr/local/go/bin

# Functions
function gitignore; curl -sL https://www.gitignore.io/api/$argv; end # Gitignore generator
function wttr; curl "https://wttr.in/$argv?1F"; end # Weather
function cheat; curl cheat.sh/(string join + $argv) | bat; end # Cheat sheet!
which cht.sh &>/dev/null && function cheat; cht.sh $argv | bat; end
function mkcd; mkdir -p $argv[1] && cd $argv[1]; end # Make a directory and enter it

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
