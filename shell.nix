{ pkgs ? import <nixpkgs> {}
, extraPkgs ? []
}:

let
  fhs = pkgs.mkShell {
    name = "openwrt-env";

    nativeBuildInputs = with pkgs; [
        git
        pkg-config
        ncurses
        unzip
        python3
        python3Packages.distutils-extra
        cdrtools
        perl
        pcre.dev
      ];

    hardeningDisable = [ "all" ];
  };
in fhs

