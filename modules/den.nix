{ inputs, ... }:
{
  debug = true;
  #instantiate = inputs.nixpkgs-stable.lib.nixosSystem;
  den.hosts.x86_64-linux.pointalpha = {
    users.shawn = { };
  };
  den.homes.x86_64-linux.shawn = { };
}
