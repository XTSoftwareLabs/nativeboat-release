# Getting started

## Install

Extract the release ZIP into a folder, for example `C:\Tools\nativeboat`, and
keep its contents together. Add the folder to your user `PATH` to run
`nativeboat` from any terminal, or run it by its full path.

```powershell
nativeboat --version
nativeboat --help
```

## Prepare your project

NativeBoat builds the Electron project in a folder. Install its dependencies
with its package manager as you would for an Electron build:

```powershell
cd C:\src\my-app
npm install          # or pnpm install, yarn
```

When dependencies are missing, `nativeboat build` installs them into a build
copy of the project with the project's package manager, leaving your folder
unchanged.

NativeBoat finds the main process, preload scripts and pages from
`package.json` and the project's build configuration. These layouts are
recognized:

| Layout | Main process | Preload | Pages |
| --- | --- | --- | --- |
| Plain Electron | `main` in `package.json` | `webPreferences.preload` paths | the HTML files the main process loads |
| [electron-vite](https://electron-vite.org) | the configured inputs, otherwise `src/main/index.*` | the configured inputs, otherwise `src/preload/index.*` | the configured HTML inputs |
| [vite-plugin-electron](https://github.com/electron-vite/vite-plugin-electron) | `electron/main.*` | `electron/preload.*` | HTML files in the project root |
| Electron Forge with the Vite plugin | `src/main.*` or `src/index.*` | `src/preload.*` | HTML files in the project root |

Projects that compile with `tsc` work from their TypeScript sources; NativeBoat
reads the project's `tsconfig` files to find them.

You can also run NativeBoat from a pnpm, npm or Yarn workspace root that
contains one Electron application.

## Commands

### `nativeboat analyze [PROJECT]`

Reports the Electron APIs, Node.js modules, web APIs, HTML and CSS features the
project uses, with a score and the source location of each finding.
`PROJECT` defaults to the current folder.

| Option | Meaning |
| --- | --- |
| `--json` | print the report as JSON |

### `nativeboat build [PROJECT]`

Compiles the project into a native executable. `PROJECT` defaults to the
current folder.

| Option | Meaning |
| --- | --- |
| `--out <DIR>` | output folder, relative to the project unless absolute. Default: electron-builder's `directories.output` when set, otherwise `dist` (or `release` when the project's TypeScript compiles into `dist`) |
| `--work-dir <DIR>` | where build copies of projects are kept. Default: `%LOCALAPPDATA%\nativeboat\projects` |
| `--sign <COMMAND>` | signs the executable before it is written to the output folder; see [Signing](#signing) |
| `--rustc <FILE>` | the compiler to build with instead of the one in the `toolchain` folder |

Exit status 0 means the executable was written. When a build fails, it prints
the errors with their source locations and keeps any executable from an
earlier build.

## What a build produces

The output folder contains `<productName>.exe`, named after `productName` in
`package.json` (or electron-builder's `productName`). It is the whole
application: run it like any Windows program.

The executable carries:

- version information from `package.json` (`productName`, `version`,
  `description`);
- the icon from electron-builder's `build.win.icon` or `build.icon` (an
  `.ico` file, or a PNG of at most 256×256 pixels);
- an application manifest for Windows 10 and 11 with per-monitor DPI
  awareness and long path support.

electron-builder's `extraResources` are copied into a `resources` folder next
to the executable, where `process.resourcesPath` points, and its `extraFiles`
next to the executable. Its configuration is read from the `build` field of
`package.json`, or from `electron-builder.yml`, `.yaml`, `.json` or `.json5`.

`THIRD-PARTY-NOTICES.txt` next to the executable holds the notices of the
third-party libraries NativeBoat compiles into it. The notices of your
project's own dependencies are yours to include, as with an Electron build.

### Build scripts

Before compiling, `nativeboat build` runs what the project's packaging script
runs before packaging. For example, with

```json
"package:win": "npm run build:helper && npm run build && electron-builder --win"
```

it runs `build:helper` and `build`, so a helper program the application starts
is built and copied the way electron-builder would package it. Commands that
only compile JavaScript, such as `tsc`, `vite` or `webpack`, are left to
NativeBoat. Commands run in `cmd.exe` from the project folder with
`node_modules\.bin` on the `PATH`, so the tools they use must be installed.

### Signing

`--sign` runs your signing tool on the executable before it is written to the
output folder. `{file}` in the command becomes the quoted path of the
executable, and is appended when the command does not contain it:

```powershell
nativeboat build --sign "signtool sign /a /fd SHA256 /tr http://timestamp.digicert.com /td SHA256 {file}"
```

The command runs in the Windows shell from the project folder. When it fails,
the build fails and the previous executable is kept.

## Run and debug

Compiled applications are Windows GUI programs. Their console output,
warnings and uncaught errors go to the console they are started from, so start
them from a terminal while debugging:

```powershell
Start-Process dist\MyApp.exe -NoNewWindow -Wait
```

In `cmd`, use `start /wait dist\MyApp.exe`.

## Distribute your application

Ship the contents of the output folder: the executable,
`THIRD-PARTY-NOTICES.txt` and, when your project has them, the `resources`
folder and extra files. Applications built with
NativeBoat need no runtime installer. See [LICENSE.md](../LICENSE.md) for the
terms of distributing applications built with NativeBoat.
