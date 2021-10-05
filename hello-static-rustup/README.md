Readme
======

## Build targetting host platform via rustup / rustc

### Statically linked to libc

Required nix env:

```bash
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
