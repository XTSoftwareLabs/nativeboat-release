# How NativeBoat works

NativeBoat turns an Electron app into a native Windows program. The program
it builds has no JavaScript engine in it and doesn't use Chromium or
WebView2, but it runs the same code and shows the same pages. This page
explains the idea.

## Typical Electron app

An Electron app is a small program that travels with a very large runtime:

```
 your app (JavaScript, HTML, CSS)
 ─────────────────────────────────
 Node.js + V8 JavaScript engine      runs the code while the app runs
 Chromium (Blink, Skia, ...)         lays out and paints the pages while the app runs
```

Each time the app starts, V8 reads the JavaScript and runs it, and Chromium
reads the HTML and CSS, builds the page and paints it. WebView2 cuts the
download size by using the browser that comes with Windows, but the work is
the same. It still happens on the user's machine, every time, inside a
browser process.

## The NativeBoat way

NativeBoat does that work on your machine when you build the app, instead
of on your users' machines when they run it:

```
            nativeboat build                           on the user's PC
 ┌────────────────────────────────────────┐    ┌──────────────────────┐
 │ JavaScript / TypeScript ──► native code│    │                      │
 │ HTML / CSS             ──► native UI   │──► │  one Windows program │
 │ Node / Electron APIs   ──► Windows APIs│    │                      │
 └────────────────────────────────────────┘    └──────────────────────┘
```

Your users get a regular executable. There's no script left for an engine to
run and no web page left for a browser to render.

### 1. Compile JavaScript code

A JavaScript engine translates your code while it runs. NativeBoat does the
translating before the app ever runs, like a C++ or Rust compiler:

1. Collect the program. Starting from your main script, preloads and pages,
   follow every `import` and `require()` through your files and
   `node_modules`.
2. Read and resolve it. Parse each module and work out what every name refers
   to, once, instead of looking it up while the app runs.
3. Generate native code. Turn each JavaScript function into a native
   function that keeps JavaScript's behavior. In current version, Rust is used as the native code.
4. Build the executable. Compile and link that code with the toolchain that
   ships with NativeBoat, together with a small runtime for memory, the event
   loop and built-ins like `Array` and `Promise`.

In general terms, the JavaScript goes through the same path as code in a
compiled language:

```
 JavaScript ──► syntax tree ──► generated systems code ──► LLVM ──► machine code
```

The interesting part is step 3. JavaScript is dynamic: a variable can hold a
number now and a string later, and objects can gain properties at any time.
So the generated code doesn't assume fixed types. Every value carries its
type with it, and operations such as `+`, property reads or `==` call into
the runtime, which applies JavaScript's rules for whatever types it gets.
What the compiler can know ahead of time, it settles ahead of time: which
function a call refers to, where each variable lives, how modules connect.
That generated code is then handed to LLVM, the same optimizer behind
compilers like Clang and Rust, which turns it into machine code for Windows.

### 2. Node.js and Electron calls go straight to Windows

Your code keeps calling `fs`, `http`, `BrowserWindow`, `Menu`, `dialog` and
the rest. NativeBoat provides them directly on Windows: files, sockets,
windows, menus, dialogs, the clipboard and the notification area. Same calls,
same results, no browser runtime underneath.

### 3. NativeBoat draws the pages itself

At build time, the HTML of each window and its stylesheets (CSS files, Vue
component styles, Tailwind output) are processed and packaged with the app. In most parts, it leverages the Windows GDI+ to draw the UI.

When the app runs, page scripts use the normal browser APIs (`document`,
elements, events), and each change to the page goes through four steps:

1. Style: work out the final CSS for every element.
2. Layout: place every box and break text into lines.
3. Paint: draw backgrounds, borders, text, images and effects.
4. Update: repaint only what changed in the window.

Mouse, keyboard and IME input comes from Windows and reaches the page as the
usual DOM events.

## What users get

- A small program that stands on its own.
- Fast starts and lower memory use. There's no engine to boot and no browser
  processes running next to the app.
- No JavaScript to read. The app is machine code like any other native
  program.
- The same app. You keep your Electron project, your frameworks and your npm
  packages, and run `nativeboat build`.

- `nativeboat analyze` lists what an app uses and how well each part is
supported, before you build anything. Each release also comes with a
[compatibility list](compatibility.md).
