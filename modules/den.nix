{ inputs, ... }:
{
  debug = true;
  den.hosts.x86_64-linux = {
    pointalpha = {
      users.shawn = { };
    };
    zenbook = {
      instantiate = inputs.nixpkgs-stable.lib.nixosSystem;
      hm-module = inputs.home-manager-stable.nixosModules.home-manager;
      users.shawn = { };
    };
  };
  den.homes.x86_64-linux.shawn = { };
}
