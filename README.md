Readme
======

A personal experiment to evaluate the extent of [rust]'s cross compilation
capabilities in the context of the [nix] package manager reproducible
environment.

[rust]: https://www.rust-lang.org/
[nix]: https://nixos.org/guides/how-nix-works.html


## Build targetting host platform via rustup / rustc

### Dynamically linked to libc

Required nix env:

```bash
cd hello-dynamic-rustup/
$ nix-shell -I nixpkgs=../../nixpkgs_root/
# ..
```

Build and launch:

```bash
$ rustc hello.rs
# ..

[nix-shell:~/dev/jrg-rust-cross-experiment]$ ./hello
Hello World!
```

See however, not statically linked:

```bash
$ ldd ./hello
        linux-vdso.so.1 (0x00007fffbb129000)
        libgcc_s.so.1 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/libgcc_s.so.1 (0x00007f8f2bcff000)
        libpthread.so.0 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/libpthread.so.0 (0x00007f8f2bcde000)
        libm.so.6 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/libm.so.6 (0x00007f8f2bb9b000)
        libdl.so.2 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/libdl.so.2 (0x00007f8f2bb96000)
        libc.so.6 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/libc.so.6 (0x00007f8f2b9d5000)
        /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib/ld-linux-x86-64.so.2 => /nix/store/gk42f59363p82rg2wv2mfy71jn5w4q4c-glibc-2.32-48/lib64/ld-linux-x86-64.so.2 (0x00007f8f2bd68000)
```


### Statically linked to libc

Required nix env:

```bash
cd hello-static-rustup/
$ nix-shell -I nixpkgs=../../nixpkgs_root/
# ..
```

Failed initial attempt:

```bash
$ rustc -C target-feature=+crt-static hello.rs
error: linking with `cc` failed: exit status: 1
  |
  = note: "cc" "-m64" # ..
  # ..
```

This is because glibc does not support / allow this.


Trying with musl intead:

```bash
$ rustup target add x86_64-unknown-linux-musl
info: downloading component 'rust-std' for 'x86_64-unknown-linux-musl'
info: installing component 'rust-std' for 'x86_64-unknown-linux-musl'
 33.2 MiB /  33.2 MiB (100 %)  10.7 MiB/s in  3s ETA:  0s

$ rustc --target x86_64-unknown-linux-musl -C target-feature=+crt-static hello.rs

$ ./hello 
Hello World!

$ ldd hello
        statically linked
```

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
