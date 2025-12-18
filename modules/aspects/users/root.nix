{
  __findFile,
  ...
}:
{
  den.aspects.root = {
    includes = [
      (<den/user-shell> "zsh")
    ];

    nixos =
      { config, ... }:
      {
        sops.secrets.root = {
          sopsFile = ./secrets.yaml;
          neededForUsers = true;
        };

        users.users.root.hashedPasswordFile = config.sops.secrets.root.path;
      };
  };
}
