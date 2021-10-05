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
