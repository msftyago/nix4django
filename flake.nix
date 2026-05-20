{
  description = "Monthy python's favorite django flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (
      system: let
    p = import nixpkgs { inherit system; };

    pythonPackages = p.python3Packages;

    venvDir = "./env";

    runPackages = with nixpkgs; [
      pythonPackages.python
      pythonPackages.venvShellHook
    ];

    devPackages = with nixpkgs; runPackages ++ [
      pythonPackages.pylint
      pythonPackages.flake8
      pythonPackages.black
    ];

    postShellHook = ''
      PYTHONPATH=\$PWD/\${venvDir}/\${pythonPackages.python.sitePackages}/:\$PYTHONPATH
    '';

  in {
    runShell = p.mkShell {
      inherit venvDir;
      name = "pythonify-run";
      packages = runPackages;
      postShellHook = postShellHook;
    };
    devShells = {
      default = p.mkShell {
        inherit venvDir;
        packages = devPackages;
        postShellHook = postShellHook;
      };
    };
  });
}
