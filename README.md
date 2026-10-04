# NativeBoat

NativeBoat compiles Electron applications into native Windows executables. It
uses your existing JavaScript, TypeScript, HTML and CSS, including React, and
replaces Electron's browser and Node.js runtime with native implementations.
The compiled application runs without Chromium, WebView2 or Node.js.

The `nativeboat-release` repository provides prebuilt compiler releases for
Windows x64.

## Why use NativeBoat?

Electron lets you build desktop applications with web tools, but shipping a
browser engine adds download size and memory use. NativeBoat gives you a native
Windows build from the same project, without rewriting the application in C++
or maintaining generated native code. You can keep building the Electron
version too.

NativeBoat uses Win32 windows and controls, with native layout and painting for
the rest of the page. It bundles the application's code and assets into an
executable. Projects with external resources or sidecar programs may also
produce files alongside it.

## Download and install

1. Open the [latest release](https://github.com/XTSoftwareLabs/nativeboat-release/releases/latest)
   and download the Windows x64 ZIP.
2. Extract it into a folder such as `C:\Tools\nativeboat`.
3. Keep `nativeboat.exe` and `nativeboat-runtime.exe` in the same folder.
4. Add that folder to your user `PATH`, then open a new terminal.

Check the installation:

```powershell
nativeboat --version
nativeboat --help
```

You can also run the compiler by its full path instead of adding it to `PATH`.
If a release provides the two executables separately, download both from the
same release. The runtime is required to build applications.

### Requirements

- Windows 10 version 1607 or later, or Windows 11, x64. Compiled applications
  have the same Windows requirement.
- Your Electron project's dependencies in `node_modules`. Use its package
  manager to install them.
- Any tools needed by your project's own build scripts, such as tools that
  build a sidecar program.

You do not need Rust or Visual Studio to use the prebuilt compiler. NativeBoat
compiles TypeScript and JSX itself; it does not need Electron or Vite to run
the compiled application.

## Compile an application

From your Electron project's directory:

```powershell
cd C:\Projects\my-electron-app
npm ci --omit=dev
nativeboat analyze
nativeboat build --out native-dist
```

Use the package manager and installation command appropriate for your project.
If its build scripts need development dependencies, install those too.

`nativeboat analyze` reports supported, partially supported and unsupported
features, with file and line references. `nativeboat build` writes the executable
into `native-dist`, using the application's product name. It also runs the
project's packaging preparation commands when needed, such as building sidecar
programs.

Run the resulting executable to check the application's behavior. The
compiler and `nativeboat-runtime.exe` are build tools; users of your compiled
application do not need to install them separately.

### Commands

| Command | Purpose |
| --- | --- |
| `nativeboat analyze [PROJECT]` | Check compatibility; defaults to the current directory. |
| `nativeboat analyze [PROJECT] --json` | Print the compatibility report as JSON. |
| `nativeboat build [PROJECT]` | Compile the application using its configured output directory. |
| `nativeboat build [PROJECT] --out <DIR>` | Choose an output directory, relative to the project. |
| `nativeboat build [PROJECT] --runtime <FILE>` | Use a runtime executable from another location. |
| `nativeboat build [PROJECT] --no-scripts` | Skip the project's packaging preparation commands. |

## Compatibility

NativeBoat implements Electron and Node.js APIs, DOM behavior and CSS on Windows.
It supports React, TypeScript, JSX, flexbox and grid, but it does not implement
every browser or Electron feature.

Some features have limits or are unavailable, including native Node.js addons,
WebGL, embedded web views, media elements and some CSS effects. Run
`nativeboat analyze` on your project before building. Builds stop on unsupported
features by default. `--allow-unsupported` bypasses that check; it does not
make those features work.

## Licensing

- **Open source projects are free**, whether commercial or non-commercial.
- **Hobby projects are free**, including closed-source hobby projects.
- For **closed-source commercial use**, contact
  [nativeboat@xtsoftwarelabs.com](mailto:nativeboat@xtsoftwarelabs.com) to get a license.

See [LICENSE.md](LICENSE.md) for the usage policy.

## Report a problem

Open an [issue](https://github.com/XTSoftwareLabs/nativeboat-release/issues) with
the NativeBoat version, your Windows version, the command you ran, and the
error or compatibility report. A small project that reproduces the problem
helps us investigate it.

## Publishing releases

Releases are uploaded manually. See [the release guide](docs/releasing.md)
for building and packaging the compiler and runtime.
