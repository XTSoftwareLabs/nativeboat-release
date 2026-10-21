# Changelog

## 0.1.0-alpha.1

First preview release.

- `nativeboat build` compiles an Electron project into a native Windows
  executable that runs without Chromium, WebView2, Node.js or a JavaScript
  engine.
- `nativeboat analyze` reports how well the native target supports a project.
- Works with plain Electron, electron-vite, vite-plugin-electron and Electron
  Forge (Vite) projects, TypeScript projects, and pnpm, npm and Yarn
  workspaces.
- Nothing else to install: no Rust, Visual Studio or Windows SDK.
- Executables carry the application's name, version and icon, and can be
  signed with `--sign`.
