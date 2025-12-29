{ __findFile, ... }:
{
  den.aspects.pointalpha = {

    includes = [
      (<den/unfree> [
        "keymapp"
        "makemkv"
      ])
    ];

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
      { pkgs, config, ... }:
      {
        sops = {
          defaultSopsFile = ./secrets.yaml;
          secrets.zrepl = { };
        };

        environment.systemPackages = [ pkgs.solaar ];

        nix.settings = {
          keep-outputs = true;
          keep-derivations = true;
          cores = 8;
        };

        services = {
          smartd = {
            enable = true;
            devices = [ { device = "/dev/nvme1"; } ];
          };
          pipewire = {
            wireplumber.extraConfig = {
              "10-bluez"."monitor.bluez.properties" = {
                "bluez5.enable-sbc-xq" = true;
                "bluez5.enable-msbc" = true;
                "bluez5.enable-hw-volume" = true;
              };
              "11-bluetooth-policy"."wireplumber.settings"."bluetooth.autoswitch-to-headset-profile" = false;
            };
          };
          zrepl.settings.jobs = [
            {
              name = "pointalpha_safe";
              type = "source";
              filesystems = {
                "rpool/safe<" = true;
              };
              snapshotting = {
                type = "periodic";
                interval = "1h";
                prefix = "zrepl_";
              };
              send = {
                encrypted = false;
                compressed = true;
              };
              serve = {
                type = "tls";
                listen = ":8888";
                ca = ../../../../files/cert/zrepl/tank.crt;
                cert = ../../../../files/cert/zrepl/pointalpha.crt;
                key = config.sops.secrets.zrepl.path;
                client_cns = [ "tank" ];
              };
            }
          ];
        };

        programs = {
          ausweisapp = {
            enable = true;
            openFirewall = true;
          };
          nh.flake = "/home/shawn/dev/nixos-configuration";
          kdeconnect.enable = true;
          droidcam.enable = true;
          adb.enable = true;
        };

      };

  };
}
