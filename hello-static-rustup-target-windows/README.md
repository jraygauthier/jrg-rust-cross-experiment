Readme
======

## Build targetting windows platform via rustup / rustc

### Statically linked to libc

Required nix env:

```bash
$ nix-shell -I nixpkgs=../../nixpkgs_root/
# ..
```

```bash
$ rustup target add x86_64-pc-windows-gnu

$ rustc --target x86_64-pc-windows-gnu hello.rs

$ file ./hello.exe 
./hello.exe: PE32+ executable (console) x86-64, for MS Windows

# It appears not to dynamically linked to anything.
$ winedump -j export ./hello.exe
Contents of hello.exe: 4473666 bytes
Done dumping hello.exe

# Check that executable works in wine:
$ wine ./hello.exe
Hello World!
```

from `cmd.exe` on target windows device:

```bash
$ hello.exe
Hello World!
```


## References

 -  [Beginner’s guide to cross compilation in Nixpkgs](https://matthewbauer.us/blog/beginners-guide-to-cross.html)

 -  [Cross Compile Rust for Windows - Learn - NixOS Discourse](https://discourse.nixos.org/t/cross-compile-rust-for-windows/9582/4)

 -  [Demote Windows MinGW targets to lower tiers or re-enable their tests - tools and infrastructure - Rust Internals](https://internals.rust-lang.org/t/demote-windows-mingw-targets-to-lower-tiers-or-re-enable-their-tests/10536/13)


 -  [x86_64-pc-windows-gnu target failing · Issue #7 · nix-community/fenix](https://github.com/nix-community/fenix/issues/7)

