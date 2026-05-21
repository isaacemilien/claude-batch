{
  description = "Simple wrapper around Claude batch api call using python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.python3Packages.buildPythonApplication {
        pname = "claude-batch";
        version = "0.1.0";
        src = ./.;
        format = "other";

        installPhase = ''
          mkdir -p $out/bin
          cp pls.py $out/bin/pls
          chmod +x $out/bin/pls
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        shellHook = ''
          python -m venv .venv
          source .venv/bin/activate
          pip install -r requirements.txt
        '';

        buildInputs = with pkgs.python3Packages; [ python ];

        packages = with pkgs; [ cron ];
      };
    };
}
