<#
.SYNOPSIS
    Build imapsync Docker images for specified OS and version on Windows using PowerShell.

.DESCRIPTION
    This script wraps Docker Buildx commands to build and push multi-architecture imapsync images.

.PARAMETER OsFolder
    The folder name containing the OSs (e.g., alpine, ubuntu, debian).

.PARAMETER BaseImage
    The Docker base image tag (e.g., "3.18", "jammy"), maps to version folder with Dockerfile: OsFolder/BaseImage/Dockerfile.

.PARAMETER ImapsyncVersion
    The imapsync version to fetch and build (e.g., "2.229").

.PARAMETER DockerHubUser
    Your Docker Hub username (e.g., "yourdockerhubuser").

.EXAMPLE
    PS> .\build.ps1 -OsFolder alpine -BaseImage 3.18 -ImapsyncVersion 2.229 -DockerHubUser myuser
    PS> .\build.ps1 -OsFolder debian -BaseImage bookworm -ImapsyncVersion 2.229 -DockerHubUser myuser
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$OsFolder,
    [Parameter(Mandatory)][string]$BaseImage,
    [Parameter(Mandatory)][string]$ImapsyncVersion,
    [Parameter(Mandatory)][string]$DockerHubUser,
    [string]$Platform = "linux/amd64,linux/arm64"
)

try {
    # Construct image tag
    $tagBase = "${OsFolder}_${BaseImage}"
    $imageName = "${DockerHubUser}/imapsync:${tagBase}-${ImapsyncVersion}"

    Write-Host "Building image: $imageName" -ForegroundColor Cyan

    # docker buildx build `
    #     --platform $Platform `
    #     --push `
    #     --build-arg IMAPSYNC_VERSION=$ImapsyncVersion `
    #     -f "$OsFolder\Dockerfile" `
    #     -t $imageName `
    #     .
    docker buildx build `
        --platform $Platform `
        --build-arg IMAPSYNC_VERSION=$ImapsyncVersion `
        -f "$OsFolder\$BaseImage\Dockerfile" `
        -t $imageName `
        .

    Write-Host "Successfully built $imageName" -ForegroundColor Green
}
catch {
    Write-Error "An error occurred: $_"
    exit 1
}
