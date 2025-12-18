{
  __findFile,
  ...
}:
{
  den.aspects.shawn = {

    includes = [
      <den/primary-user>
      (<den/user-shell> "zsh")

      (<den/unfree_agg> [
        "tampermonkey"
        "betterttv"
        "video-downloadhelper"
      ])
    ];

    nixos =
      {
        config,
        inputs',
        lib,
        ...
      }:
      {
        sops.secrets.shawn = {
          sopsFile = ./secrets.yaml;
          neededForUsers = true;
        };

        users.users.shawn = {
          isNormalUser = true;
          group = "users";
          uid = 1000;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMguHbKev03NMawY9MX6MEhRhd6+h2a/aPIOorgfB5oM shawn"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmwxYRglh8MIGWZvQR/6mYCO7NTTJFnrQq7j5pjfkvZ smartphone"
          ];
          hashedPasswordFile = config.sops.secrets.shawn.path;
        };
        nix.settings.trusted-users = [ "shawn" ];
      };
  };
}
