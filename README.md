# NativeBoat

NativeBoat compiles an Electron application into a native Windows executable.
It uses your project as it is: its JavaScript or TypeScript, HTML, CSS and
installed dependencies. The executable it builds runs without Chromium,
WebView2, Node.js or a JavaScript engine.

Your project does not change. You can keep building the Electron version from
the same repository.

## Download and install

1. Download `nativeboat-<version>-windows-x64.zip` from the
   [releases page](https://github.com/XTSoftwareLabs/nativeboat-release/releases).
2. Extract it into a folder such as `C:\Tools\nativeboat`.
3. Add that folder to your user `PATH` and open a new terminal.

Check the installation:

```powershell
nativeboat --version
```

### Requirements

- Windows 10 version 1607 or later, or Windows 11, on x64. Compiled
  applications have the same requirement.
- Node.js and your project's package manager, to install the project's
  dependencies.
- Any tools your project's own build scripts use.

## Compile an application

From your Electron project's folder:

```powershell
nativeboat analyze      # report on the project
nativeboat build        # writes dist\<productName>.exe
dist\<productName>.exe
```

See [Getting started](docs/getting-started.md) for more, and
[Compatibility](docs/compatibility.md) for what is supported.
[How NativeBoat works](docs/how-it-works.md) explains how it builds an
application.

## License

NativeBoat is free for open source projects, commercial or not, and for
non-commercial projects, including closed-source ones. Closed-source
commercial use needs a license: contact
[nativeboat@xtsoftwarelabs.com](mailto:nativeboat@xtsoftwarelabs.com). See
[LICENSE.md](LICENSE.md) for the terms.

Third-party software notices: [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).
