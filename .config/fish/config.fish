# Launch tmux on startup
if status is-interactive
and not set -q TMUX
    exec tmux new-session -t T \; if-shell "test '$(tmux list-windows | count)' -gt 0" "new-window"
end

# Ssh keychain
eval $(keychain -q)

# Abbreviations
abbr --add :q exit # Yayy vim
function :q! -d 'Kill the tmux session.' # Kill session and exit
    tmux kill-session
    exit
end
abbr --add pacman sudo pacman # Because I'm tired of typing 'sudo'
abbr --add oil Oil

# pnpm
set -gx PNPM_HOME "/home/elin/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Functions
function gitignore; curl -sL https://www.gitignore.io/api/$argv; end # Gitignore generator
function Oil; nvim +Oil $argv; end # Open oil in current dir
function cheat; curl cheat.sh/$argv | bat; end # Cheat sheet!
function mkcd; mkdir -p $argv[1] && cd $argv[1]; end # Make a directory and enter it
