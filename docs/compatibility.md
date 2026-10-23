# Compatibility

What NativeBoat 0.1.0-alpha.2 supports in an Electron application, in three
levels:

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
| Vue | Supported | |
| React | Not supported | JSX and React's CommonJS development build are not compiled yet |
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
| `process`, `assert`, `querystring`, `string_decoder` | Supported | |
| `timers`, `console`, `readline`, `stream` | Supported | |
| `child_process` | Partial | `spawn`, `exec`, `execFile` and their sync forms, `ChildProcess`; `fork` is not available, as there is no Node.js executable |
| `net` | Partial | `Server`, `Socket`, `connect`, `createConnection`, `createServer`, `isIP` functions |
| `http`, `https` | Partial | `request`, `get`, `createServer`, `Agent`, `Server` and the request and response classes |
| `crypto` | Partial | `createHash`, `createHmac`, `randomBytes`, `randomUUID` |
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
| `ResizeObserver`, `MutationObserver`, `IntersectionObserver` | Supported | |
| HTML drag and drop | Supported | drags inside the app, to and from other apps, and files dropped from Windows |
| Custom drag images (`setDragImage`) | Partial | drags show the platform's image |
| Canvas 2D | Supported | see the limits below |
| `fetch` | Partial | local files and HTTP(S); no CORS or caching |
| `XMLHttpRequest` | Partial | asynchronous requests only |
| `window.open` | Partial | opens a new native window or the default browser |
| Clipboard API | Partial | text only |
| Web notifications | Partial | shown in the notification area; clicks are not reported |
| `document.execCommand` | Partial | `copy`, `cut`, `paste`, `undo`, `redo`, `selectAll`, `insertText`, `insertParagraph`, `insertLineBreak`, `delete` and `forwardDelete` are supported; other commands are not available |
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
| Tables, including captions | Supported | |
| `details`, `summary` | Supported | |
| SVG | Partial | shapes, paths, text, markers, `use` and dashed strokes are drawn; gradients, patterns, clip paths, masks, filters, images, text on a path and SVG animations are not |
| `dialog` | Partial | `show()` and `close()` work; `showModal()` opens the dialog in place, without the top layer, a backdrop or making the rest of the page inert |
| `iframe`, `webview` | Not supported | |
| `video`, `audio` | Not supported | |
| `object`, `embed` | Not supported | |

## CSS

| Feature | Support | Notes |
| --- | --- | --- |
| Selectors, cascade, custom properties | Supported | including `:is()`, `:where()`, `:not()`, `:has()`, `:nth-*()`, state and form pseudo-classes, `::before`, `::after`, `::marker`, `::placeholder`, `::selection` |
| Flexbox, Grid, `position: sticky` | Supported | |
| Floats | Supported | |
| Tables (`display: table`) | Supported | |
| `@media`, `@supports`, `@import` | Supported | |
| `box-shadow` | Supported | |
| `filter` | Supported | native controls inside a filtered element are drawn unfiltered |
| `backdrop-filter` | Supported | |
| Transforms | Supported | |
| Transitions, `@keyframes` animations | Supported | |
| `clip-path` | Supported | shapes, boxes, `path()` and the document's SVG `<clipPath>` elements; see the limit below |
| Masks (`mask`, `mask-image` and the other `mask-*` properties, also with `-webkit-`) | Supported | images, SVG images and gradients; see the limit below |
| `font-variant-numeric`, `font-feature-settings` | Supported | |
| Scrollbar styling (`::-webkit-scrollbar` parts, `scrollbar-color`, `scrollbar-width`) | Supported | background images in scrollbar parts are not drawn |
| Linear gradients | Supported | one opaque layer with an angle or side and increasing percentage stops |
| Other gradients | Partial | corner directions, transparent stops, length or hard stops, repeating and radial gradients and multiple layers are approximate |
| Right-to-left text (`direction`, `unicode-bidi`, `dir`) | Partial | text, lines, carets and selections follow the direction; grid columns, block margins, list markers and scrollbars keep their left-to-right sides |
| `clip-path: url(...)` to another document | Partial | does not clip |
| `mask` referencing an SVG `<mask>` element | Partial | does not mask |
| `display: contents` | Partial | treated as a normal box |
| `@font-face` | Partial | installed system fonts are used |
| `@layer` | Partial | layers are flattened in source order |
| `text-shadow` | Partial | not drawn |
| `overflow-anchor` | Partial | scroll positions are not adjusted when content above changes |
| Unknown properties | Partial | ignored |
| Other pseudo-classes, such as `:lang()`, `:dir()`, `:visited`, `:target` | Not supported | they never match |
| `mix-blend-mode` other than `normal` | Not supported | |
| `filter: url(...)` | Not supported | |
| Multi-column layout | Not supported | |
| Container queries | Not supported | |

## Known differences

- Text uses ClearType, except in scrolling areas that Chromium draws as
  layers of their own. Electron may draw text in some other layers in
  grayscale.
- Box positions are rounded to whole CSS pixels, so a click within half a pixel
  of a line's edge can land on the next line.
