# Getting started

## Install

Extract the release ZIP into a folder, for example `C:\Tools\nativeboat`, and
add the folder to your user `PATH`. Then check it in a new terminal:

```powershell
nativeboat --version
```

## Prepare your project

Install the project's dependencies as you would for an Electron build:

```powershell
cd C:\src\my-app
npm install          # or pnpm install, yarn
```

## Check your project

```powershell
nativeboat analyze
```

Reports which Electron, Node.js and web features the project uses and how
well each is supported, with where each is used. Add `--json` for a JSON
report.

## Build

```powershell
nativeboat build
```

Writes `<productName>.exe` into the project's output folder (`dist` unless
the project's electron-builder configuration names another). Run it like any
Windows program.

| Option | Meaning |
| --- | --- |
| `--out <DIR>` | the output folder |
| `--sign <COMMAND>` | signs the executable; see [Signing](#signing) |
| `--work-dir <DIR>` | where build copies of projects are kept |

Both commands take the project folder as an argument and default to the
current folder:

```powershell
nativeboat build C:\src\my-app --out C:\builds\my-app
```

If the project's packaging script builds something before packaging, such as
a helper program, `nativeboat build` runs those steps too, so install the
tools they need.

### Signing

`{file}` in the command stands for the executable:

```powershell
nativeboat build --sign "signtool sign /a /fd SHA256 /tr http://timestamp.digicert.com /td SHA256 {file}"
```

## Debug

Start the application from a terminal to see its console output and errors:

```powershell
Start-Process dist\MyApp.exe -NoNewWindow -Wait
```

## Distribute your application

Ship the contents of the output folder. No runtime installer is needed. See
[LICENSE.md](../LICENSE.md) for the terms.
