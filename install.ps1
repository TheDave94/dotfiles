# Ensure Scoop is installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    Write-Host "Scoop installed! Please run Script again."
    exit
}

# Update scoop
scoop update

# Adding Buckets
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts

# Define an array of software to install
$softwareList = @(
# ------------------------------------------
            'gh', 
            'lazygit', 
            'alacritty', 
            'vscode', 
            'rustup'
            'swift', 
            'go',
            'temurin-jdk',
            'webstorm', 
            'rustrover',
            'idea',
            'Maple-Mono-NF',
            "autohotkey",
# ------------------------------------------
            'bitwarden', 
            '7zip', 
            'inkscape',  
            'onlyoffice-desktopeditors', 
            'megasync', 
            'vesktop', 
            'paint.net', 
            'gimp', 
            "spotify",
            "fastfetch",
            "vlc"
            )

# Loop through each software in the array and install it
foreach ($software in $softwareList) {
    Write-Host "Installing $software..."
    scoop install $software

    # Check if the installation was successful
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$software installed successfully."
    } else {
        Write-Host "Failed to install $software. Please check the error above."
    }
}
