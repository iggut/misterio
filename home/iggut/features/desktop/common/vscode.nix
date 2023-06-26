{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          b4dm4n.vscode-nixpkgs-fmt
          bbenoist.nix
          eamodio.gitlens
          esbenp.prettier-vscode
          foxundermoon.shell-format
          genieai.chatgpt-vscode
          github.codespaces
          github.github-vscode-theme
          roman.ayu-next
          github.copilot
          github.vscode-github-actions
          github.vscode-pull-request-github
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode.hexeditor
          ms-vsliveshare.vsliveshare
          njpwerner.autodocstring
          pkief.material-icon-theme
          pkief.material-product-icons
          redhat.vscode-xml
          redhat.vscode-yaml
          timonwong.shellcheck
          tobiasalthoff.atom-material-theme
          tyriar.sort-lines
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "sweet-vscode";
            publisher = "eliverlara";
            sha256 = "sha256-kJgqMEJHyYF3GDxe1rnpTEmbfJE01tyyOFjRUp4SOds=";
            version = "1.1.1";
          }
          {
            name = "ruff";
            publisher = "charliermarsh";
            sha256 = "sha256-2FAq5jEbnQbfXa7O9O231aun/pJ8mkoBf1u4ekkBQu8=";
            version = "2023.13.10931546";
          }
          {
            name = "beardedicons";
            publisher = "beardedbear";
            sha256 = "sha256-CyBWz0I11g5qiAWvMeYC9KO+pbwJS5MpwLtmMhDrz3E=";
            version = "1.12.0";
          }
          {
            name = "materialiconic-product-icons";
            publisher = "nyxb";
            sha256 = "sha256-BHgRhOUVhV1DyuofVRYtVU0/u7vZzdSxJEObDg481cI=";
            version = "0.0.2";
          }
        ];
    })
  ];

}
