# --------------------------
# Always run relative to this script's directory
# --------------------------
Set-Location $PSScriptRoot

# --------------------------
# GitHub repository
# --------------------------
$repo = "comfyanonymous/ComfyUI"

# --------------------------
# Default version if no --latest flag
# --------------------------
$defaultVersion = "v0.3.56"

# --------------------------
# Parse arguments
# --------------------------
$useLatest = $false
if ($args -contains "--latest") {
    $useLatest = $true
}

# --------------------------
# Determine release info
# --------------------------
if ($useLatest) {
    Write-Host "Fetching latest release info..."
    $releaseJson = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest"
} else {
    Write-Host "Fetching release info for version $defaultVersion..."
    $releaseJson = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/tags/$defaultVersion"
}

# --------------------------
# Get zipball URL from API
# --------------------------
$downloadUrl = $releaseJson.zipball_url
$releaseName = $releaseJson.tag_name
$targetDir = "..\tools\ComfyUI"
$outputFile = "$env:TEMP\ComfyUI-$releaseName.zip"

if (-not $downloadUrl) {
    Write-Host "Failed to find source code zip URL."
    exit 1
}

# --------------------------
# Download the zip
# --------------------------
Write-Host "Downloading ComfyUI $releaseName from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile

# --------------------------
# Remove old folder if it exists
# --------------------------
if (Test-Path $targetDir) {
    Write-Host "Removing existing ComfyUI folder..."
    Remove-Item $targetDir -Recurse -Force
}
New-Item -ItemType Directory -Path $targetDir | Out-Null

# --------------------------
# Unzip to temporary folder first
# --------------------------
$tempExtract = "$env:TEMP\ComfyUI-extract"
if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force }
New-Item -ItemType Directory -Path $tempExtract | Out-Null

Write-Host "Unpacking ComfyUI..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($outputFile, $tempExtract)

# --------------------------
# Move nested GitHub folder contents directly into targetDir
# --------------------------
$nestedFolder = Get-ChildItem $tempExtract | Where-Object { $_.PSIsContainer } | Select-Object -First 1
if ($nestedFolder) {
    Get-ChildItem $nestedFolder.FullName -Recurse | ForEach-Object {
        $destPath = $_.FullName.Replace($nestedFolder.FullName, $targetDir)
        $destDir = Split-Path $destPath
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }
        Move-Item $_.FullName $destPath -Force
    }
    # Remove the empty nested folder
    Remove-Item $nestedFolder.FullName -Recurse -Force
}

# --------------------------
# Cleanup temporary zip
# --------------------------
Remove-Item $outputFile

Write-Host "ComfyUI is ready in $targetDir"
Write-Host "Temporary files removed. Done."
