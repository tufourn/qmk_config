{
  description = "QMK dev flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.qmk
      ];
      shellHook = ''
        export QMK_HOME="$(pwd)/qmk_firmware"

        if [ ! -d "$QMK_HOME" ]; then
          qmk setup -H $QMK_HOME
        fi

        qmk config user.overlay_dir="$(pwd)"
      '';
    };
  };
}
