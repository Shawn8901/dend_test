{
  den.aspects.pointalpha = {

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.keymapp
          pkgs.portfolio
          #pkgs.pytr
          #fPkgs.jameica-fhs
          pkgs.jameica
          pkgs.makemkv
          pkgs.libation
          (pkgs.asunder.override { mp3Support = true; })
          pkgs.deezer-enhanced
        ];
      };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.solaar
        ];

        # nixpkgs.config.allowUnfree = true;

        nix.settings = {
          keep-outputs = true;
          keep-derivations = true;
          cores = 8;
        };

        services.openssh = {
          hostKeys = [
            {
              path = "/persist/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
            {
              path = "/persist/etc/ssh/ssh_host_rsa_key";
              type = "rsa";
              bits = 4096;
            }
          ];
        };

      };

  };
}
