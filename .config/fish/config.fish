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
abbr --add oil Oil

# pnpm
set -gx PNPM_HOME "/home/elin/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Go
fish_add_path /usr/local/go/bin

# Functions
function gitignore; curl -sL https://www.gitignore.io/api/$argv; end # Gitignore generator
function wttr; curl "https://wttr.in/$argv?1F"; end # Weather
function Oil; nvim +Oil $argv; end # Open oil in current dir
function cheat; curl cheat.sh/$argv | bat; end # Cheat sheet!
function mkcd; mkdir -p $argv[1] && cd $argv[1]; end # Make a directory and enter it
