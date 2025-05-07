abbr --add :q exit
# pnpm
set -gx PNPM_HOME "/home/elin/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function gitignore; curl -sL https://www.gitignore.io/api/; end
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end
