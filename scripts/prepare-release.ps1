#requires -Version 5.1
# Packages a built NativeBoat release: nativeboat.exe with its toolchain
# folder, and this repository's README, license, notices, changelog and docs.
# Writes the ZIP and SHA256SUMS.txt into <OutputDirectory>\<Version>, and keeps
# the unpacked package there for inspection. Nothing is built, tagged or
# uploaded.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z]+(?:[.-][0-9A-Za-z]+)*)?$')]
    [string]$Version,

    # The folder holding nativeboat.exe and its toolchain folder.
    [string]$BinaryDirectory = (Join-Path $PSScriptRoot '..\..\nativeui\target\release'),

    [string]$OutputDirectory = (Join-Path $PSScriptRoot '..\artifacts')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$binaryRoot = (Resolve-Path -LiteralPath $BinaryDirectory).Path
$compiler = Join-Path $binaryRoot 'nativeboat.exe'
$toolchain = Join-Path $binaryRoot 'toolchain'

if (-not (Test-Path -LiteralPath $compiler -PathType Leaf)) {
    throw "Missing $compiler. Build nativeboat-cli in release mode first."
}
foreach ($required in 'bin\rustc.exe', 'lib\rustlib\x86_64-pc-windows-msvc\bin\rust-lld.exe', 'renderer-libs', 'share\doc\rust\licenses') {
    if (-not (Test-Path -LiteralPath (Join-Path $toolchain $required))) {
        throw "The toolchain folder lacks $required. Package it with scripts\package-toolchain.ps1."
    }
}

$compilerVersion = (& $compiler --version | Out-String).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Could not read the compiler version.' }
if ($compilerVersion -ne "nativeboat $Version") {
    throw "Compiler reports '$compilerVersion', but the requested release is $Version."
}

$files = 'README.md', 'LICENSE.md', 'THIRD-PARTY-NOTICES.md', 'THIRD-PARTY-LICENSES.txt', 'CHANGELOG.md'
foreach ($name in $files) {
    if (-not (Test-Path -LiteralPath (Join-Path $repositoryRoot $name) -PathType Leaf)) {
        throw "Missing $name in $repositoryRoot."
    }
}
$changelog = Get-Content -Raw -LiteralPath (Join-Path $repositoryRoot 'CHANGELOG.md')
if ($changelog -notmatch "(?m)^## $([regex]::Escape($Version))\s*$") {
    throw "CHANGELOG.md has no section for $Version."
}

$releaseDirectory = Join-Path $OutputDirectory $Version
if (Test-Path -LiteralPath $releaseDirectory) {
    throw "Release folder already exists: $releaseDirectory. Inspect it before packaging again."
}

$packageName = "nativeboat-$Version-windows-x64"
$packageDirectory = Join-Path $releaseDirectory $packageName
$archive = Join-Path $releaseDirectory "$packageName.zip"
New-Item -ItemType Directory -Path $packageDirectory | Out-Null

Copy-Item -LiteralPath $compiler -Destination $packageDirectory
Copy-Item -LiteralPath $toolchain -Destination $packageDirectory -Recurse
foreach ($name in $files) {
    Copy-Item -LiteralPath (Join-Path $repositoryRoot $name) -Destination $packageDirectory
}
Copy-Item -LiteralPath (Join-Path $repositoryRoot 'docs') -Destination $packageDirectory -Recurse
# Maintainer instructions stay out of the download.
Remove-Item -LiteralPath (Join-Path $packageDirectory 'docs\releasing.md') -ErrorAction SilentlyContinue

Compress-Archive -Path (Join-Path $packageDirectory '*') -DestinationPath $archive
$hash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
"$hash  $packageName.zip" | Set-Content -LiteralPath (Join-Path $releaseDirectory 'SHA256SUMS.txt') -Encoding ASCII

$size = (Get-Item -LiteralPath $archive).Length / 1MB
Write-Host ('Prepared {0} ({1:N0} MB)' -f $archive, $size)
Write-Host "Upload the ZIP and SHA256SUMS.txt from $releaseDirectory to GitHub Releases."
