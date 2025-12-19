{
  __findFile,
  config,
  den,
  inputs,
  ...
}:
{
  den.default = {
    nixos = {
      imports = [
        inputs.sops-nix.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
      ];
      system.stateVersion = "23.05";
      users.mutableUsers = false;
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };
    homeManager =
      { config, ... }:
      {
        imports = [
          inputs.sops-nix.homeManagerModule
          inputs.impermanence.homeManagerModules.impermanence
        ];
        home.stateVersion = "23.05";
        sops = {
          age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
          # defaultSymlinkPath = "/run/user/${toString user.uid}/secrets";
          # defaultSecretsMountPoint = "/run/user/${toString user.uid}/secrets.d";
        };
      };

    includes = [
      den._.inputs'
      <den/home-manager>
      <cfg/hm-global-config>
      <den/unfree_builder>
      <den/define-user>

      (if config ? _module.args.CI then <cfg/ci-no-boot> else { })

      (den.lib.take.exactly (
        { OS, host }:
        den.lib.take.unused OS {
          nixos = {
            networking = {
              hostName = host.hostName;
              hostId = builtins.substring 0 8 (builtins.hashString "md5" "${host.hostName}");
            };
          };
        }
      ))
    ];
  };
}
