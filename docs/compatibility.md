# Compatibility

What NativeBoat supports in an Electron application, in three levels:

- **Supported**: works as in Electron.
- **Partial**: works with the limits given.
- **Not supported**: not available in a compiled application.

`nativeboat analyze` uses the same levels and shows where your project uses
each feature. If code that can run uses a feature that is not supported,
`nativeboat build` stops with an error that points to the source.

NativeBoat builds for Windows 10 version 1607 or later and Windows 11, on x64.
It does not build for macOS or Linux.

## Projects and tools

| Feature | Support | Notes |
| --- | --- | --- |
| Plain Electron, JavaScript and TypeScript (`tsc`) | Supported | |
| electron-vite, vite-plugin-electron, Vite | Supported | |
| Electron Forge with the Vite plugin | Supported | |
| electron-builder configuration | Supported | app metadata, `files`, `extraResources`, `extraFiles`, output folder |
| npm, pnpm, Yarn, Bun | Supported | |
| React, Vue | Supported | |
| Webpack | Partial | sources are compiled directly; custom loaders are not applied |
| Svelte, Preact, Solid | Partial | runs on the native DOM; not yet validated |
| jQuery | Partial | layout queries are approximate |
| Angular | Not supported | zone.js and the Angular compiler are not supported |
| Sass, Less, Stylus | Not supported | only plain CSS and CSS modules are compiled |

## Language

| Feature | Support | Notes |
| --- | --- | --- |
| Modern JavaScript and TypeScript | Supported | |
| TypeScript `experimentalDecorators` | Supported | |
| Dynamic `require` | Partial | only modules known at build time are included |
| Standard decorators | Not supported | only TypeScript's `experimentalDecorators` are compiled |
| Top-level `await` | Not supported | modules are evaluated synchronously |
| Remote scripts | Not supported | scripts must be part of the application |

## Electron APIs

| API | Support | Notes |
| --- | --- | --- |
| `app`, `BrowserWindow`, `webContents` | Supported | |
| `ipcMain`, `ipcRenderer`, `contextBridge` | Supported | |
| `dialog`, `Menu`, `MenuItem`, `Tray`, `Notification` | Supported | |
| `clipboard`, `shell`, `globalShortcut`, `nativeImage` | Supported | |
| `nativeTheme`, `screen`, `powerMonitor`, `powerSaveBlocker` | Supported | |
| `safeStorage`, `webUtils` | Supported | |
| `webFrame` | Partial | zoom only (`get`/`setZoomFactor`, `get`/`setZoomLevel`); spell checking and other methods are not available |
| `net` | Partial | `net.fetch` only |
| `session`, `protocol` | Partial | the common request APIs only |
| `systemPreferences` | Partial | a subset of the API |
| `crashReporter` | Partial | `start` writes local crash dumps; reports are not uploaded |
| `autoUpdater` | Partial | checking for updates is not supported |
| Any other module | Not supported | |

## Node.js modules

| Module | Support | Notes |
| --- | --- | --- |
| `fs`, `path`, `os`, `events`, `buffer`, `util`, `url` | Supported | |
| `crypto`, `process`, `assert`, `querystring`, `string_decoder` | Supported | |
| `timers`, `console`, `readline`, `stream` | Supported | |
| `child_process` | Partial | `spawn`, `exec`, `execFile` and their sync forms, `ChildProcess`; `fork` is not available, as there is no Node.js executable |
| `net` | Partial | `Server`, `Socket`, `connect`, `createConnection`, `createServer`, `isIP` functions |
| `http`, `https` | Partial | `request`, `get`, `createServer`, `Agent`, `Server` and the request and response classes |
| `dns` | Partial | `lookup` and `promises` |
| `module` | Partial | `createRequire`, `builtinModules`, `isBuiltin` |
| `perf_hooks` | Partial | a subset of the module |
| `zlib` | Partial | deflate and gzip; brotli is not available |
| `constants` | Partial | filesystem and Windows constants; OpenSSL constants are not available |
| `tty` | Partial | `isatty` only; terminal streams are not available |
| Any other module, such as `worker_threads`, `vm` or `cluster` | Not supported | |

### Native addons

Native Node.js addons (`.node` files) cannot be loaded. These packages are
implemented natively, so they work without their addon:

| Package | Support | Notes |
| --- | --- | --- |
| `keytar` | Supported | uses Windows Credential Manager, compatible with keytar's storage |
| `native-keymap` | Supported | |
| `ced` | Supported | |
| Other addon packages, such as `better-sqlite3`, `sqlite3`, `node-pty`, `serialport`, `sharp`, `canvas`, `bcrypt`, `argon2`, `leveldown`, `nodegit`, `realm`, `usb`, `node-hid`, `robotjs`, `ffi-napi` | Not supported | |

## Web APIs

| API | Support | Notes |
| --- | --- | --- |
| DOM, events, `localStorage`, `sessionStorage` | Supported | |
| `WebSocket` | Supported | |
| `ResizeObserver`, `MutationObserver` | Supported | |
| Canvas 2D | Supported | see the limits below |
| `fetch` | Partial | local files and HTTP(S); no CORS or caching |
| `XMLHttpRequest` | Partial | asynchronous requests only |
| `IntersectionObserver` | Partial | visibility is reported at layout time |
| HTML drag and drop | Partial | drags inside the app and files dropped from Windows; dragging out to other apps, virtual files and custom drag images are not available |
| `window.open` | Partial | opens a new native window or the default browser |
| Clipboard API | Partial | text only |
| Web notifications | Partial | shown in the notification area; clicks are not reported |
| `document.execCommand` | Partial | `copy`, `cut`, `paste`, `undo`, `redo`, `selectAll`, `insertText`, `insertParagraph`, `insertLineBreak`, `delete`, `forwardDelete` only |
| WebGL | Not supported | |
| Web Workers, Service Workers | Not supported | scripts run on the UI thread only |
| IndexedDB | Not supported | use `localStorage` or the file system |
| Web Audio, media devices (camera, microphone) | Not supported | |
| Shadow DOM, custom elements | Not supported | |

Canvas 2D limits: shadows and filters are not drawn, patterns are not drawn,
compositing modes other than `source-over` and `copy` draw as `source-over`,
conic gradients draw as linear gradients, and `isPointInPath` and
`isPointInStroke` report no hit.

## HTML

| Feature | Support | Notes |
| --- | --- | --- |
| Ordinary elements | Supported | |
| Form controls | Supported | |
| `canvas` | Supported | |
| SVG | Partial | shapes, paths, text, markers and `use` are drawn; gradients, patterns, clip paths, masks, filters, images, text on a path and SVG animations are not |
| Tables | Partial | laid out with a grid approximation |
| `dialog`, `details`, `summary` | Partial | basic behavior only |
| `iframe`, `webview` | Not supported | |
| `video`, `audio` | Not supported | |
| `object`, `embed` | Not supported | |

## CSS

| Feature | Support | Notes |
| --- | --- | --- |
| Selectors, cascade, custom properties | Supported | including `:is()`, `:where()`, `:not()`, `:has()`, `:nth-*()`, state and form pseudo-classes, `::before`, `::after`, `::placeholder`, `::selection` || Flexbox, Grid, `position: sticky` | Supported | |
| `@media`, `@supports`, `@import` | Supported | |
| `box-shadow` | Supported | |
| `filter` | Supported | native controls inside a filtered element are drawn unfiltered |
| Scrollbar styling (`::-webkit-scrollbar` parts, `scrollbar-color`, `scrollbar-width`) | Supported | background images in scrollbar parts are not drawn |
| Linear gradients | Supported | one opaque layer with an angle or side and increasing percentage stops |
| Other gradients | Partial | corner directions, transparent stops, length or hard stops, repeating and radial gradients and multiple layers are approximate |
| Transforms | Partial | native controls and scroll areas do not rotate or scale |
| Transitions | Partial | `::before` and `::after` change at once |
| Floats | Partial | text beside a float does not widen below its end |
| `display: table` | Partial | laid out with a grid approximation |
| `display: contents` | Partial | treated as a normal box |
| `backdrop-filter` | Partial | only content in the same scrolling area is filtered |
| `@font-face` | Partial | installed system fonts are used |
| `@layer` | Partial | layers are flattened in source order |
| `text-shadow` | Partial | not drawn |
| `overflow-anchor` | Partial | scroll positions are not adjusted when content above changes |
| Unknown properties | Partial | ignored |
| `@keyframes` animations | Partial | parsed, but animations do not run |
| Other pseudo-classes, such as `:lang()`, `:dir()`, `:visited`, `:target` | Not supported | they never match |
| `clip-path`, masks | Not supported | |
| `mix-blend-mode` other than `normal` | Not supported | |
| `filter: url(...)` | Not supported | |
| Multi-column layout | Not supported | |
| Container queries | Not supported | |

## Known differences

- Text uses ClearType everywhere. Electron may draw some text in grayscale.
- Box positions are rounded to whole CSS pixels, so a click within half a pixel
  of a line's edge can land on the next line.
