# --------------------------
# Always run relative to this script's directory
# --------------------------
Set-Location $PSScriptRoot

# --------------------------
# Specify which compose file to use
# --------------------------
$composeFile = "../docker/comfy.docker-compose.yml"

# --------------------------
# Stop and remove containers and volumes
# --------------------------
Write-Host "Stopping and removing containers + volumes..."
docker compose -f $composeFile down -v

# --------------------------
# Rebuild and start containers in detached mode
# --------------------------
Write-Host "Rebuilding and starting containers..."
docker compose -f $composeFile up --build -d

# --------------------------
# Optional: clean up dangling images to save space
# --------------------------
Write-Host "Pruning dangling images..."
docker image prune -f

# --------------------------
# Script complete
# --------------------------
Write-Host "Done."

# --------------------------
# List running containers
# --------------------------
Write-Host "Currently running containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"