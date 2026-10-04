# Publishing a release

The compiler source is maintained in `C:\Workspace\nativeui`. The
`nativeboat-release` repository holds the download instructions, usage policy
and release packaging script.
There is no automated build or publishing workflow here.

## Build and check

In the source repository, set the release version in `Cargo.toml`, then run
the source repository's checks and build both programs from the same checkout:

```powershell
cd C:\Workspace\nativeui
cargo build --release -p nativeboat-cli -p nativeboat-runtime
.\target\release\nativeboat.exe --version
```

Before publishing, compile a representative Electron project with those
binaries and check the resulting application's behavior. Check whether the
release needs any additional third-party notices and include them with the
download.

## Package

From this repository:

```powershell
cd C:\Workspace\nativeuirelease
.\scripts\prepare-release.ps1 -Version 0.1.0
```

Replace `0.1.0` with the version being released. The script checks the compiler
version and packages these files:

- `nativeboat.exe`
- `nativeboat-runtime.exe`
- `README.md`
- `LICENSE.md`

It writes a ZIP and `SHA256SUMS.txt` into `artifacts\0.1.0`. The unpacked
package is also kept there for inspection. It refuses to overwrite an existing
release folder.

To package binaries from a different build directory:

```powershell
.\scripts\prepare-release.ps1 -Version 0.1.0 -BinaryDirectory C:\Builds\nativeboat
```

The script packages existing binaries. It does not build, tag or upload anything.

## Upload manually

1. Open [GitHub Releases](https://github.com/XTSoftwareLabs/nativeboat-release/releases)
   and choose **Draft a new release**.
2. Create a tag such as `v0.1.0` and use `NativeBoat 0.1.0` as the title.
3. Describe the changes, compatibility limits and any upgrade instructions.
4. Upload `nativeboat-0.1.0-windows-x64.zip` and `SHA256SUMS.txt` from
   `artifacts\0.1.0`.
5. Mark preview versions as prereleases. For a stable release, set it as the
   latest release, then publish it.

If you upload executables separately, upload both `nativeboat.exe` and
`nativeboat-runtime.exe` from the same build. The compiler alone cannot build
applications with its default settings.

## Verify the download

Download the published ZIP and checksum file. Compare the ZIP's SHA-256 with
the entry in `SHA256SUMS.txt`:

```powershell
Get-FileHash .\nativeboat-0.1.0-windows-x64.zip -Algorithm SHA256
Get-Content .\SHA256SUMS.txt
```

Extract the ZIP into a fresh folder, run `nativeboat.exe --version`, then use
that copy to analyze and build an application. Keep the compiler and runtime
together when checking the download.
