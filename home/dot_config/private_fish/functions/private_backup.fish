function backup -d "Create a timestamped backup of a file or directory"
    if test (count $argv) -eq 0
        echo "Usage: backup <file|directory>"
        return 1
    end

    set -l timestamp (date +%Y%m%d_%H%M%S)
    set -l backup_name "$argv[1].backup_$timestamp"

    cp -r $argv[1] $backup_name
    and echo "Backup created: $backup_name"
end
