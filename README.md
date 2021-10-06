Readme
======

A personal experiment to evaluate the extent of [rust]'s cross compilation
capabilities in the context of the [nix] package manager reproducible
environment.

[rust]: https://www.rust-lang.org/
[nix]: https://nixos.org/guides/how-nix-works.html


## Build targetting host platform via rustup / rustc

### Dynamically linked to libc

See [hello-dynamic-rustup/README.md](./hello-dynamic-rustup/README.md).


### Statically linked to libc

See [hello-static-rustup/README.md](./hello-static-rustup/README.md)


## Build targetting windows platform via rustup / rustc

### Statically linked to libc

See [hello-static-rustup-target-windows/README.md](./hello-static-rustup-target-windows/README.md)


## References

 -  [Rust - NixOS Wiki](https://nixos.wiki/wiki/Rust)

 -  [Linkage - The Rust Reference](https://doc.rust-lang.org/reference/linkage.html)

     -  [Static and dynamic C runtimes](https://doc.rust-lang.org/reference/linkage.html#static-and-dynamic-c-runtimes)

         >  rustc -C target-feature=+crt-static foo.rs

         >  To use this feature locally, you typically will use the RUSTFLAGS
         >  environment variable to specify flags to the compiler through Cargo
         >  For example to compile a statically linked binary on MSVC you would
         >  execute:

         >  `RUSTFLAGS='-C target-feature=+crt-static' cargo build --target x86_64-pc-windows-msvc`

 -  [Using RUSTFLAGS - Rust SIMD Performance Guide](https://rust-lang.github.io/packed_simd/perf-guide/target-feature/rustflags.html)

 -  [The rustup book](https://rust-lang.github.io/rustup/)

     -  [Toolchains](https://rust-lang.github.io/rustup/concepts/toolchains.html)

     -  [Components](https://rust-lang.github.io/rustup/concepts/components.html)

         >  Each toolchain has several "components", some of which are required
         >  (like rustc) and some that are optional 

         >  `rust-mingw` — This contains a linker and platform libraries for
         >  building on the x86_64-pc-windows-gnu platform.

     -  [Overrides](https://rust-lang.github.io/rustup/overrides.html)

         >  rustup automatically determines which toolchain to use when one of the
         >  installed commands like rustc is executed

         >  There are several ways to control and override which toolchain is
         >  used:

         >  The `RUSTUP_TOOLCHAIN` environment variable.

         >  The `rust-toolchain.toml` file.

         -  [The toolchain file](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file)

             >   toolchain can be named in the project's directory in a file
             >   called `rust-toolchain.toml` or `rust-toolchain`. If both files are
             >   present in a directory, the latter is used for backwards
             >   compatibility

             >  For backwards compatibility, `rust-toolchain` files also support
             >  a legacy format that only contains a toolchain name without any
             >  TOML encoding


     -  [Environment variables](https://rust-lang.github.io/rustup/environment-variables.html)

         >  `RUSTUP_HOME` (default: ~/.rustup or %USERPROFILE%/.rustup) Sets the
         >  root rustup folder, used for storing installed toolchains and
         >  configuration options.

         >  `RUSTUP_TOOLCHAIN` (default: none) If set, will override the toolchain
         >  used for all rust tool invocations. A toolchain with this name
         >  should be installed, or invocations will fail.


 -  [Index and list all available toolchains · Issue #215 · rust-lang/rustup](https://github.com/rust-lang/rustup/issues/215)

     -  [Rustup packages availability on x86_64-unknown-linux-gnu](https://rust-lang.github.io/rustup-components-history/)

