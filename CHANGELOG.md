# Changelog

## 0.1.0-alpha.3

- `assert` has Node's whole API: `equal`, `notEqual`, the deep and strict
  comparisons, `throws`, `rejects`, `doesNotThrow`, `match`, `ifError`,
  `fail`, `AssertionError` and `assert.strict`. Deep equality is Node's own.
- `process.binding('uv')` gives libuv's error codes, `errname` and
  `getErrorMessage`, as execa expects.
- `ipcMain` is a full event emitter: `once`, `off`, `removeListener`,
  `removeAllListeners`, `prependListener`, `listenerCount` and the rest,
  plus `handleOnce` and `removeHandler`.
- `clipboard.readImage()` returns the clipboard's picture, from its PNG form
  or its bitmap. `nativeImage` gains `toPNG`, `toDataURL`, `createEmpty`,
  `createFromDataURL` and `createFromBitmap`, and windows gain
  `setPosition` and `getPosition`.
- The `clip-filepaths` package works without its native addon: file lists
  are read from and written to the Windows clipboard as Explorer copies
  them, with the package's results and error messages.
- The Fetch API works in the main process and preloads as in Node: the
  `fetch`, `Headers`, `Request`, `Response` and `FormData` globals, with
  response bodies as streams, gzip and deflate decoding, redirects,
  `data:` URLs and aborting. Classes that extend `Request` or `Response`,
  as Hono's Node adapter does, work too.
- Web streams work: `stream/web` and the `ReadableStream`,
  `WritableStream`, `TransformStream`, `TextDecoderStream`,
  `CompressionStream` and other globals, `Readable.toWeb` and
  `Readable.fromWeb`. `Blob`, `File` and `DOMException` are globals too,
  also when read as `globalThis.X`.
- Errors thrown by Node's library code carry Node's codes, classes and
  messages for every code, where some codes were missing before.
- `net` sockets and servers work: TCP connections and listening servers
  with Node's stream events, timeouts, keep-alive, `ref`/`unref` and
  errors (`ECONNREFUSED`, `EADDRINUSE`, ...). Named pipes are not
  available yet.
- `http` servers and clients work as in Node: `createServer` with
  keep-alive, pipelining, chunked bodies, `Expect: 100-continue`,
  `upgrade` and `connect` events, and `request`/`get` with agents, socket
  reuse, timeouts and `CONNECT`. `https` requests go through the system's
  HTTPS client and proxy; their response bodies arrive whole. HTTPS
  servers are not available. `nativeboat analyze` reports `http` as
  supported.
- `zlib` has Node's `constants`, `codes` and legacy constant names, the
  `Deflate`, `Gzip`, `Unzip` and other classes as transform streams (they
  write their output when the input ends), and `crc32`. Decompression reads concatenated gzip members, finishes input
  that ends early when `finishFlush` asks for it, as HTTP clients do, and
  fails with zlib's messages, codes and numbers.
- `app.setLoginItemSettings` and `app.getLoginItemSettings` work as in
  Electron on Windows: the item is a `Run` entry named after the
  AppUserModelId that `app.setAppUserModelId` now sets, disabled items are
  marked as the Task Manager marks them, and `launchItems` lists the
  application's entries.
- `process.binding()` gives the bindings Node still serves to old
  packages, such as `constants`, `fs`, `os` and `zlib`.
- Tailwind CSS 4 stylesheets build as `@tailwindcss/vite` builds them: with
  the project's own `tailwindcss` compiler and the plugins and
  configurations their `@plugin` and `@config` rules name, from the class
  names in the renderer's sources and `@source` folders.
- Main-process and preload sources that electron-vite, vite-plugin-electron
  or Forge's Vite plugin bundle into CommonJS can call `require()`, also
  inside functions, and their `__dirname` and `__filename` are the bundle's
  in the application, as when the bundle runs.
- electron-builder configurations written as JavaScript or TypeScript
  modules (`electron-builder.config.ts` and the like) supply the
  application's identity, resources and output folder.
- Cascade layers order the cascade as in browsers: later layers win over
  earlier ones in the order `@layer` statements and blocks declare them, a
  layer's own rules over its sublayers', rules outside any layer over
  layered ones, and the other way round for `!important` declarations.
  `@property` registers custom properties: elements start from their
  initial values, and from their parents' only when they inherit.
  `nativeboat analyze` reports both as supported.
- Stylesheets' `@import` rules work, in stylesheets imported from scripts
  and in Vue components' styles: the imported sheets, relative or from
  packages by their `style` export condition or field, are inlined with
  their `layer()`, `supports()` and media conditions, and their files,
  such as fonts, travel with them. Imports after other rules are ignored,
  as in browsers.
- `require()` calls whose module is computed when the application runs,
  such as plugin loaders, no longer stop the build: `nativeboat build`
  warns about each one, and when it runs it loads a module the build
  compiled by that name, or throws Node's `MODULE_NOT_FOUND` error.
- `Tray` shows icons in the notification area with their tooltips, images
  and balloons; clicks, right clicks, double clicks and balloon clicks reach
  the `Tray`'s listeners, and the menu given to `setContextMenu` or
  `popUpContextMenu` opens beside the icon, drawn as windows' menus are.
  `Notification` shows notifications as notification area balloons, which
  Windows shows as banners, with `show`, `click` and `close` events.
  `globalShortcut` registers system-wide shortcuts, and
  `protocol.registerSchemesAsPrivileged` accepts the application's schemes.
  `nativeImage.createFromPath` reads PNG files.
- `AsyncLocalStorage` from `node:async_hooks` keeps its store across
  `await`s, promise callbacks, `process.nextTick`, timers, immediates and
  I/O callbacks, as in Node, and `AsyncResource` runs callbacks in the
  context it was created in.
- `require()` calls in CommonJS `try` blocks that name a module the build
  cannot find, such as optional dependencies and other platforms' native
  packages, throw Node's `MODULE_NOT_FOUND` error when they run instead of
  stopping the build. Requests in branches that build-time defines rule out,
  such as React's development build under `process.env.NODE_ENV ===
  'production'`, are not compiled. `Object.defineProperty(module, 'exports',
  ...)` sets a module's exports.
- `process.ppid`, `process.umask()`, `process.report.getReport()` and
  `process.stdin` work in the main process; `columns` and `rows` of
  `process.stdout` and `process.stderr` read as `undefined`, as a windowed
  application's are.
- Node's `readline` and `readline/promises` modules work. `http2`, `net` and
  `tls` load, with Node's constants, settings and address checks; their
  sessions, sockets and servers report that they are not available.
  `nativeboat analyze` reports the Electron APIs and Node modules compiled
  applications provide: `Tray`, `Notification`, `globalShortcut`,
  `protocol`, `powerMonitor`, `safeStorage` and the `webContents` module, and
  Node's `dns` and `perf_hooks`, as not supported.
- JSX in `.jsx` and `.tsx` modules compiles, to React's automatic runtime
  or to the factory the TypeScript configuration's `jsx`, `jsxImportSource`,
  `jsxFactory` and `jsxFragmentFactory` name.
- Imports in TypeScript modules that no value uses are dropped, as
  TypeScript and Vite drop them, unless `verbatimModuleSyntax` is on: types
  imported without `import type`, and modules that only declare types, no
  longer stop the build. `declare module` blocks are ignored.

## 0.1.0-alpha.2

- Lines of text within a box sit on the device pixel rows Chromium puts
  them on when they fall half way between rows: their positions are kept in
  64ths of a CSS pixel before scaling, as Chromium's are.
- `clip-path` clips to polygons, ellipses, `path()` shapes and the
  document's SVG `<clipPath>` elements exactly, for painting and for the
  pointer; they clipped to their bounds or a rounded rectangle before.
- CSS masks: `mask-image`, `mask-size`, `mask-position`, `mask-repeat` and
  the `mask` shorthand, also with the `-webkit-` prefix, keep what the
  mask image's alpha covers, for images, SVG images and gradients.
  `nativeboat analyze` reports masks as supported, except references to
  SVG `<mask>` elements.
- Compiled applications are smaller: identical functions are folded, and
  module setup code no longer grows with the number of modules times their
  dependencies (MarkText: 299 MB to 287 MB).
- Boxes with a negative `z-index` inside positioned boxes that make no
  stacking context paint, and take the pointer, beneath the content of the
  enclosing stacking context, as in browsers. MarkText's hidden source of a
  diagram no longer covers the block after it, so a `<summary>` there
  opens on a click.
- Mouse moves that Windows repeats at the same place while windows change
  under a still pointer no longer reach pages as `mousemove` events, as in
  Chromium. Hover menus, such as MarkText's paragraph button, no longer jump
  to whatever scrolls under a resting pointer.
- Content that scrolls under a still pointer updates the hover with
  `mouseover`, `mouseout`, `mouseenter` and `mouseleave` events (and their
  pointer events), but no `mousemove`, as in Chromium. MarkText's paragraph
  menu button no longer jumps to the block that scrolls under the pointer.
- `getComputedStyle` reports line heights in pixels, and the width, height,
  margins and paddings of laid-out boxes as layout used them (`auto` widths,
  percentages and auto margins in pixels), as in Chromium. It also reports
  the `margin`, `padding`, `inset`, `border-*`, `overflow`, `gap` and
  `flex` shorthands.
- `IntersectionObserver` reports when observed elements come into view,
  leave it or move, as pages scroll and their layout changes, with root
  margins and thresholds. Buttons and toolbars that follow an element, such
  as MarkText's paragraph menu button, move with it when the content above
  shifts. `nativeboat analyze` reports `IntersectionObserver` as supported.
- A word that may not start a line, such as a comma after inline code or
  a link, no longer overflows the line or breaks off alone: the line
  breaks at its last earlier opportunity and the text from there moves
  down with the word, as in Chromium.
- `::marker` rules style list item and summary markers: their color and
  font, as MarkText's dark themes color list numbers and bullets.
- SVG strokes can be dashed with `stroke-dasharray` and
  `stroke-dashoffset`, and `marker-start`, `marker-mid`, `marker-end` and
  the `marker` shorthand work as CSS properties, set in `style`, style
  sheets or attributes, and inherited. Sequence diagrams show their dashed
  replies and arrowheads, and Mermaid its dotted edges.
- Moving the caret with the arrow keys, Home and End, or typing, in
  editable content scrolls the caret into view, as in Chromium: each
  scroller around it scrolls the least that shows it. Selections that
  scripts set leave scrolling alone.
- Text in scroll containers that Chromium draws as layers of their own, those
  holding boxes with a negative `z-index` beneath their content, is smoothed
  in grayscale as in Chromium, where nothing opaque lies beneath it; it
  showed ClearType's colored fringes.
- Lines of text stack as in Chromium when their line height is fractional,
  as `line-height: 1.6` often makes it: at some display scales some lines'
  text sat a device pixel lower than the others.
- Table captions sit above their tables, or below them with
  `caption-side: bottom`, outside the table's border, and the table's
  margins go around them, as in browsers. `nativeboat analyze` reports
  captions as supported.
- Form controls inside rotated or skewed boxes can be used while the
  transform lasts: they show turned with the box, and clicks, typing and
  selection reach them; a date picker's calendar drops down below the
  turned field. `nativeboat analyze` reports CSS transforms as supported.
- Scroll containers inside scaled or rotated boxes can be used while the
  transform lasts: the wheel scrolls them, and their scrollbars, drawn as
  Chromium draws them or as author CSS styles them, follow the transform
  and can be pressed and dragged.
- Backdrop filters filter the frames of native text fields and the native
  scroll bars of scroll containers behind them too; they stayed sharp.
  `nativeboat analyze` reports backdrop filters as supported.
- Tables size their columns as browsers do: cells fill their columns,
  widths cells give in lengths or percentages size the columns, room to
  spare goes to automatic columns first, and `table-layout: fixed` takes
  the first row's widths. `nativeboat analyze` reports tables as supported.
- Pages without scripts show their content in compiled applications; they
  were blank.
- Fixed flickering in application windows: scrolling areas and controls
  flashed white whenever the content around them changed, for example while
  the mouse moved over an editor.
- `nativeboat analyze` reports Node's `crypto` module by the functions used
  (hashes, HMACs, random bytes and UUIDs are available), and no longer
  reports `appearance: none` as unsupported. It reports `<details>` and
  `<summary>` as supported, and `<dialog>` by what `showModal()` lacks.
- CSS transitions and keyframe animations run in compiled applications,
  including on `::before` and `::after`, and transitions of inherited
  properties such as `color` reach the elements that inherit them.
  `z-index` animates too, so animations can change which element is on
  top, as do background sizes and positions, transform origins, clip paths,
  grid templates and the other properties Chromium interpolates; background
  images cross-fade.
- `font-variant-numeric` and `font-feature-settings` select OpenType
  features such as tabular numbers.
- Text areas, and scroll containers whose `resize` allows it, show a resize
  grip in their corner; dragging it resizes them.
- Text wraps around floats: lines beside a float are shortened, and lines
  below it take the full width again.
- Scroll containers and form controls inside scaled or rotated boxes scale
  and rotate with them, as dropdowns and dialogs do while they zoom in;
  scaled form controls can still be typed in and clicked.
- Files dragged from Explorer onto a compiled application's window reach
  its pages, as when dropping a document or an image onto MarkText; GIF,
  WebP, SVG, BMP and AVIF images arrive with their image types.
- Text, links and HTML dragged from other applications reach pages with
  their drags and drops, and editable content takes dropped text where it
  is dropped, as in Chromium.
- Copying, cutting and pasting reach the system clipboard in compiled
  applications' pages, and scripts that select text in text fields select
  it there. Edit menu roles and `webContents` edit commands (copy, paste,
  undo, redo, select all...) run in the focused page, so MarkText's Copy and
  Paste, and their shortcuts, work.
- Selects that pages style and draw open their options below them in
  compiled applications, and the option chosen becomes the select's value.
- Canvases draw in compiled applications' pages: 2D drawing, images,
  reading and writing pixels, `toDataURL()` and text measurement work as in
  the development renderer.
- `localStorage` persists across runs of compiled applications, in the
  application's user data, as MarkText's sidebar width and export settings
  do in Electron.
- Drags that leave the window continue in other applications: dragged
  text, links and HTML drop into editors, browsers and Explorer, and text
  moved out of editable content leaves it. `nativeboat analyze` reports drag
  and drop as supported, and custom drag images separately.
- Selected text can be dragged: dropped in editable content it moves there,
  or with Ctrl held is copied, and a press on the selection that does not
  drag it puts the caret there.
- Right-to-left text: `direction`, `unicode-bidi`, `dir` and `<bdi>` order,
  align and mirror text; long lines overflow and clip on the left; carets and
  selections follow the text.
- Every 2D transform function applies in the order written, and transitions
  between transforms interpolate as browsers do.
- `clip-path` clips elements to insets, circles and boxes;
  `backface-visibility: hidden` hides elements turned away from the viewer.
- Absolutely positioned marks inside lines of text, such as an editor's
  hard-break marks, sit beside the text they belong to.
- Bars and popups drawn over a scrolling area, such as a search bar over an
  editor, stay visible while the area scrolls.

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
