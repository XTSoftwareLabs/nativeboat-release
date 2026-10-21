# Third-party notices

NativeBoat includes third-party software. Each component remains under its own
license, which the NativeBoat license does not change.

## In the NativeBoat download

- **Rust toolchain.** The `toolchain` folder contains unmodified official Rust
  binaries and libraries that NativeBoat uses to build applications: the Rust
  compiler with its libraries (which include LLVM), the `rust-lld` linker and
  Rust's `core`, `alloc` and `compiler_builtins` libraries. They are licensed
  under the MIT license or the Apache License 2.0; LLVM under the Apache
  License 2.0 with LLVM Exceptions. Their copyright and license files are in
  `toolchain/share/doc/rust`.
  "Rust" is a trademark of the Rust Foundation. NativeBoat uses the Rust
  compiler and is not affiliated with or endorsed by the Rust Foundation.
- **Rust crates.** `nativeboat.exe` and the libraries in the `toolchain` folder
  contain open source Rust crates under permissive licenses (MIT, Apache-2.0,
  BSD, ISC, Zlib, Unicode and similar). `THIRD-PARTY-LICENSES.txt` lists each
  crate with its license texts.

## In applications built with NativeBoat

Applications built with NativeBoat contain third-party code: Rust's standard
libraries, math functions derived from musl and FreeBSD, Unicode data,
algorithms adapted from Node.js and V8, and libraries for layout, regular
expressions, URLs, text encodings, compression and Windows APIs. Their
copyright notices and licenses are embedded in every executable, and each
build writes them to `THIRD-PARTY-NOTICES.txt` next to the executable.

When you distribute an application, include that `THIRD-PARTY-NOTICES.txt`
file with it, for example in its installation folder.
