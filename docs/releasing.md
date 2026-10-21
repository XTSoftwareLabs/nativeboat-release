# Publishing a release

The compiler source is in the `nativeui` repository; its `release` folder holds
the files of this repository.

## Build and package

In the source repository, set the version in `Cargo.toml` (`[workspace.package]`)
and add its section to `release/CHANGELOG.md`. Then:

```powershell
cd C:\Workspace\nativeui
.\scripts\build-release.ps1
```

This builds `nativeboat.exe`, packages its toolchain, refreshes
`release\THIRD-PARTY-LICENSES.txt` and `release\LICENSE.md`, and writes
`nativeboat-<version>-windows-x64.zip` with `SHA256SUMS.txt` into
`target\release-package\<version>`. It fails if a dependency's license needs
review.

Copy the `release` folder's files into this repository and commit them.

Before publishing, extract the ZIP into a fresh folder, run
`nativeboat --version`, and build and run a representative Electron project
with it.

To package binaries built elsewhere from this repository:

```powershell
.\scripts\prepare-release.ps1 -Version 0.1.0-alpha.1 -BinaryDirectory C:\Builds\nativeboat
```

The binary folder holds `nativeboat.exe` and its `toolchain` folder.

## Upload

1. Open [GitHub Releases](https://github.com/XTSoftwareLabs/nativeboat-release/releases)
   and choose **Draft a new release**.
2. Create a tag such as `v0.1.0-alpha.1` and use `NativeBoat 0.1.0-alpha.1` as
   the title.
3. Use the version's section of `CHANGELOG.md` as the description.
4. Upload `nativeboat-<version>-windows-x64.zip` and `SHA256SUMS.txt`.
5. Mark alpha, beta and preview versions as prereleases. For a stable
   release, set it as the latest release. Then publish it.

## Verify the download

Download the published ZIP and `SHA256SUMS.txt` and compare the hash:

```powershell
Get-FileHash .\nativeboat-0.1.0-alpha.1-windows-x64.zip -Algorithm SHA256
Get-Content .\SHA256SUMS.txt
```

Extract it into a fresh folder, run `nativeboat.exe --version`, then build an
application with that copy.
