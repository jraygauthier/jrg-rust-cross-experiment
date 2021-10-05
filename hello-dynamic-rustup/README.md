Readme
======

## Build targetting host platform via rustup / rustc

### Dynamically linked to libc

Required nix env:

```bash
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

