function ff -d "Find files by name in current directory"
    if test (count $argv) -eq 0
        echo "Usage: ff <pattern>"
        return 1
    end

    if command -q fd
        fd --type f $argv[1]
    else
        find . -type f -iname "*$argv[1]*"
    end
end
