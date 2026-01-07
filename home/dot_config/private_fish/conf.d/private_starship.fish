# Starship prompt initialization

# Initialize Starship if it's installed
if command -q starship
    starship init fish | source
end
