# --------------------------
# Always run relative to this script's directory
# --------------------------
Set-Location $PSScriptRoot

# --------------------------
# Configuration
# --------------------------
$toolName = "ComfyUI-VideoHelperSuite"
$localPath = "../tools/overrides/custom_nodes/$toolName"
$remoteBranch = "main"   # adjust if your fork uses a different branch
$forkUrl = "https://github.com/pfrancug/ComfyUI-VideoHelperSuite.git"

# --------------------------
# Check if the folder exists
# --------------------------
if (-Not (Test-Path $localPath)) {
    Write-Host "$toolName folder not found. Cloning forked repo..."
    git clone $forkUrl $localPath
} else {
    Write-Host "$toolName folder exists. Pulling latest changes from fork..."
    Set-Location $localPath
    git fetch origin
    git reset --hard origin/$remoteBranch
}

# --------------------------
# Done
# --------------------------
Write-Host "$toolName is up to date."
