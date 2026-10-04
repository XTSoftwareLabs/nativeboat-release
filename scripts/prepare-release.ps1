#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z]+(?:[.-][0-9A-Za-z]+)*)?$')]
    [string]$Version,

    [string]$BinaryDirectory = (Join-Path $PSScriptRoot '..\..\nativeui\target\release')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$binaryRoot = (Resolve-Path -LiteralPath $BinaryDirectory).Path
$compiler = Join-Path $binaryRoot 'nativeboat.exe'
$runtime = Join-Path $binaryRoot 'nativeboat-runtime.exe'

foreach ($file in @($compiler, $runtime)) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
        throw "Missing $file. Build both nativeboat-cli and nativeboat-runtime before packaging."
    }
}

$compilerVersion = & $compiler --version
if ($LASTEXITCODE -ne 0) {
    throw 'Could not read the compiler version.'
}
if (($compilerVersion | Out-String).Trim() -ne "nativeboat $Version") {
    throw "Compiler reports '$compilerVersion', but the requested release is $Version."
}

$releaseDirectory = Join-Path $repositoryRoot "artifacts\$Version"
if (Test-Path -LiteralPath $releaseDirectory) {
    throw "Release folder already exists: $releaseDirectory. Inspect it before packaging again."
}

$packageName = "nativeboat-$Version-windows-x64"
$packageDirectory = Join-Path $releaseDirectory $packageName
$archive = Join-Path $releaseDirectory "$packageName.zip"
New-Item -ItemType Directory -Path $packageDirectory | Out-Null

foreach ($file in @($compiler, $runtime)) {
    Copy-Item -LiteralPath $file -Destination $packageDirectory
}
foreach ($name in @('README.md', 'LICENSE.md')) {
    Copy-Item -LiteralPath (Join-Path $repositoryRoot $name) -Destination $packageDirectory
}

Compress-Archive -Path (Join-Path $packageDirectory '*') -DestinationPath $archive
$hash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
"$hash  $packageName.zip" | Set-Content -LiteralPath (Join-Path $releaseDirectory 'SHA256SUMS.txt') -Encoding ASCII

Write-Host "Prepared $archive"
Write-Host "Upload the ZIP and SHA256SUMS.txt from $releaseDirectory to GitHub Releases."
