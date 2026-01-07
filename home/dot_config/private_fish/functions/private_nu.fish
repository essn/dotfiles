function nu -d "Run nushell with temporary XDG_DATA_HOME"
    env XDG_DATA_HOME=(mktemp -d) nu $argv
end
