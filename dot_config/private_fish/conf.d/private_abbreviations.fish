# Quick shortcuts
abbr -a f y
abbr -a e '$EDITOR'
abbr -a j z

# Git abbreviations
abbr -a g git
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gp 'git push'
abbr -a gpl 'git pull'
abbr -a gs 'git status'
abbr -a gb 'git branch'

# Directory navigation
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

# Common commands (using modern replacements)
abbr -a l 'eza -l --icons'
abbr -a la 'eza -la --icons'
abbr -a ll 'eza -l --icons'
abbr -a lt 'eza -l --icons --tree'
abbr -a cat bat
abbr -a find fd
abbr -a cm chezmoi

# Safety nets
abbr -a rm 'rimraf -i'
abbr -a cp 'cp -i'
abbr -a mv 'mv -i'
