# Changelog

## 0.1.0-alpha.1

First preview release.

- `nativeboat build` compiles an Electron project into a native Windows
  executable that runs without Chromium, WebView2, Node.js or a JavaScript
  engine.
- `nativeboat analyze` reports the Electron APIs, Node.js modules, web APIs,
  HTML and CSS features a project uses.
- Recognizes plain Electron, electron-vite, vite-plugin-electron and Electron
  Forge (Vite) projects, TypeScript projects built with `tsc`, and pnpm, npm
  and Yarn workspace roots.
- Builds with the toolchain included in the download: no Rust, Visual Studio
  or Windows SDK installation is needed.
- Executables carry the application's version information, icon and a Windows
  10/11 manifest, can be signed with `--sign`, and come with
  electron-builder's `extraResources` and `extraFiles`.
- Runs the steps of the project's packaging script before compiling, such as
  building helper programs.
- Writes the notices of the third-party libraries compiled into each
  application to `THIRD-PARTY-NOTICES.txt` next to its executable.
