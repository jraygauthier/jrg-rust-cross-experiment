Readme
======

## Build targetting windows platform via rustup / rustc

### Statically linked to libc via cargo

This is similar to `hello-static-rustup-target-windows` but this time, we
experiment with a non trivial project that has dependencies (in this case
the `clap` cli parser lib).

Enable cross compilation to desired target:

```bash
$ rustup target add x86_64-pc-windows-gnu
```

Build and run:

```bash
$ cargo build
    Finished dev [unoptimized + debuginfo] target(s) in 0.01s

$ cargo run 
    Finished dev [unoptimized + debuginfo] target(s) in 0.01s
     Running `/nix/store/5nz0dnmfn70gjl15srmn8wyqqmhsynpw-wine-wow-6.0/bin/wine64 target/x86_64-pc-windows-gnu/debug/simple-static-rustup-target-windows.exe`
error: The following required arguments were not provided:
    <INPUT>

USAGE:
    simple-static-rustup-target-windows.exe [FLAGS] [OPTIONS] <INPUT> [SUBCOMMAND]

For more information try --help
```

Note how `cargo run` has configured by our nix env to use wine to run our program.

Validate that we're still free of dynamic dependencies:

```bash
$ winedump -j export ./target/x86_64-pc-windows-gnu/debug/simple-static-rustup-target-windows.exe 
Contents of ./target/x86_64-pc-windows-gnu/debug/simple-static-rustup-target-windows.exe: 14574056 bytes

Done dumping ./target/x86_64-pc-windows-gnu/debug/simple-static-rustup-target-windows.exe
```


## References

 -  [rust - How can I set default build target for Cargo? - Stack Overflow](https://stackoverflow.com/questions/49453571/how-can-i-set-default-build-target-for-cargo)

     >  you can create a .cargo/config and specify the target

 -  [Add option to configure a test/binary runner · Issue #1411 · rust-lang/cargo](https://github.com/rust-lang/cargo/issues/1411)

     -  `target.x86_64-pc-windows-gnu.run = "wine64"`

 -  [Environment Variables - The Cargo Book](https://doc.rust-lang.org/cargo/reference/environment-variables.html)

     >  CARGO_TARGET_<triple>_RUNNER — The executable runner, see
     >  target.<triple>.runner.

    Which means:

     -  `CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUNNER=wine64 `


     >  CARGO_BUILD_TARGET — The default target platform, see build.target.

     -  Avoiding having to mess with `.cargo/config.toml`.
