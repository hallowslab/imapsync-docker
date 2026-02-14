<#
.SYNOPSIS
    Build imapsync Docker images for a specified OS, base image, and version.
    Supports multi-architecture builds, pushing to Docker Hub, and loading images locally.

.DESCRIPTION
    This script wraps Docker Buildx commands to build and optionally push or load multi-architecture imapsync images.
    It allows specifying the OS folder, base image version, imapsync version, Docker Hub username, platforms, and build behaviors.

.PARAMETER OsFolder
    The folder name containing the OS variants (e.g., alpine, ubuntu, debian).

.PARAMETER BaseImage
    The Docker base image tag (e.g., "3.18", "jammy"), maps to version folder with Dockerfile: OsFolder/BaseImage/Dockerfile.

.PARAMETER ImapsyncVersion
    The imapsync version to fetch and build (e.g., "2.229").

.PARAMETER DockerHubUser
    Your Docker Hub username (e.g., "yourdockerhubuser").

.PARAMETER Platform
    The target platforms for the build (default: "linux/amd64,linux/arm64"). 
    Only single-platform is allowed if using -Load.

.PARAMETER Push
    Switch indicating the built image should be pushed to Docker Hub.
    Cannot be used together with -Load.

.PARAMETER Load
    Switch indicating the built image should be loaded into the local Docker engine.
    Only works for single-platform builds and cannot be used together with -Push.

.EXAMPLE
    PS> .\build.ps1 -OsFolder alpine -BaseImage 3.18 -ImapsyncVersion 2.229 -DockerHubUser myuser

.EXAMPLE
    PS> .\build.ps1 -OsFolder debian -BaseImage bookworm -ImapsyncVersion 2.229 -DockerHubUser myuser -Platform linux/amd64 -Load

.EXAMPLE
    PS> .\build.ps1 -OsFolder ubuntu -BaseImage jammy -ImapsyncVersion 2.229 -DockerHubUser myuser -Push

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory)][string]$OsFolder,
    [Parameter(Mandatory)][string]$BaseImage,
    [Parameter(Mandatory)][string]$ImapsyncVersion,
    [Parameter(Mandatory)][string]$DockerHubUser,

    [string]$Platform = "linux/amd64,linux/arm64",

    [switch]$Push,
    [switch]$Load
)

try {
    $tagBase   = "${OsFolder}_${BaseImage}"
    $imageName = "${DockerHubUser}/imapsync:${tagBase}-${ImapsyncVersion}"

    Write-Host "Building image: $imageName" -ForegroundColor Cyan

    # Validate combinations
    if ($Push -and $Load) {
        throw "You cannot use -Push and -Load together."
    }

    if ($Load -and $Platform -like "*,*") {
        throw "-Load only supports single-platform builds. Use -Push for multi-arch."
    }

    # Determine output flag
    $outputFlag = ""
    if ($Push) {
        $outputFlag = "--push"
    }
    elseif ($Load) {
        $outputFlag = "--load"
    }

    $cmd = @(
        "docker buildx build",
        "--platform $Platform",
        $outputFlag,
        "--build-arg IMAPSYNC_VERSION=$ImapsyncVersion",
        "-f `"$OsFolder\$BaseImage\Dockerfile`"",
        "-t $imageName",
        "."
    ) -join " "

    Write-Host "Running: $cmd" -ForegroundColor DarkGray
    Invoke-Expression $cmd

    Write-Host "Successfully built $imageName" -ForegroundColor Green
}
catch {
    Write-Error "An error occurred: $_"
    exit 1
}

