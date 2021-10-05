{ pkgs ? import <nixpkgs> {} }:
let
  pkgs-cross-mingw = import pkgs.path {
    crossSystem = {
        config = "x86_64-w64-mingw32";
      };
  };
in

pkgs.mkShell rec {
  buildInputs = with pkgs; [
    llvmPackages_latest.llvm
    llvmPackages_latest.bintools
    zlib.out
    rustup
    xorriso
    grub2
    qemu
    llvmPackages_latest.lld
    python3

    pkgs-cross-mingw.stdenv.cc
    pkgs-cross-mingw.windows.mingw_w64
    (pkgs-cross-mingw.windows.mingw_w64_pthreads.overrideAttrs (oldAttrs: {
      # TODO: Remove once / if changed successfully upstreamed.
      configureFlags = (oldAttrs.configureFlags or []) ++ [
        # Rustc require 'libpthread.a' when targeting 'x86_64-pc-windows-gnu'.
        # Enabling this makes it work out of the box instead of failing.
        "--enable-static"
      ];
    }))

    # Testing produced executables and for `winedump`.
    # wineWowPackages.full
    wineWowPackages.stable
  ];
  # Avoid polluting home dir with local project stuff.
  RUSTUP_HOME = toString ./.rustup;
  CARGO_HOME = toString ./.cargo;
  WINEPREFIX = toString ./.wine;

  RUSTC_VERSION = pkgs.lib.readFile ./rust-toolchain;
  # https://github.com/rust-lang/rust-bindgen#environment-variables
  LIBCLANG_PATH= pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  HISTFILE=toString ./.history;
  shellHook = ''
    export PATH=$PATH:${CARGO_HOME}/bin
    export PATH=$PATH:${RUSTUP_HOME}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
    '';
  # Add libvmi precompiled library to rustc search path
  RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
    pkgs.libvmi
  ]);
  # Add libvmi, glibc, clang, glib headers to bindgen search path
  BINDGEN_EXTRA_CLANG_ARGS =
  # Includes with normal include path
  (builtins.map (a: ''-I"${a}/include"'') [
    pkgs.libvmi
    pkgs.glibc.dev
  ])
  # Includes with special directory paths
  ++ [
    ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
    ''-I"${pkgs.glib.dev}/include/glib-2.0"''
    ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
  ];

}
