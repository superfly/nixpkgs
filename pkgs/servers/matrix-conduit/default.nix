{ stdenv, lib, fetchFromGitLab, rustPlatform, pkgs }:

rustPlatform.buildRustPackage rec {
  pname = "matrix-conduit";
  version = "0.3.0";

  src = fetchFromGitLab {
    owner = "famedly";
    repo = "conduit";
    rev = "v${version}";
    sha256 = "sha256-jCBvenwXPgYms5Tbu16q/F8UNpvaw0Shao9kLEZLbHM=";
  };

  cargoSha256 = "sha256-fpjzc2HiWP6nV8YZOwxsIOhy4ht/tQqcvCkcLMIFUaQ=";

  nativeBuildInputs = with pkgs; [
    clang
    llvmPackages.libclang
  ];

  buildInputs = with pkgs; [
    pkg-config
    clangStdenv
    llvmPackages.libclang.lib
    rocksdb
  ];

  preBuild = with pkgs; ''
    export LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib";
  '';

  cargoBuildFlags = "--bin conduit";

  meta = with lib; {
    description = "A Matrix homeserver written in Rust";
    homepage = "https://conduit.rs/";
    license = licenses.asl20;
    maintainers = with maintainers; [ pstn piegames pimeys ];
  };
}
