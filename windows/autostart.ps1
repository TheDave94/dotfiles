# Run Scoop Updates
scoop list | foreach { scoop update $_.Name }

# Get tmp path
$TempPath = [System.IO.Path]::GetTempPath()

# Check if path exists
if (Test-Path $TempPath) {
    # Remove files and folders
    Get-ChildItem -Path $TempPath -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    Write-Host "Path cleaned: $TempPath"
} else {
    Write-Host "Path not found: $TempPath"
}

exit
