{ config, lib, pkgs, inputs, ... }:

let
  ferrisbotPkg = inputs.ferrisbot.packages.${pkgs.system}.default;
in
{
  systemd.services.ferrisbot = {
    description = "FerrisBot Discord Bot";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${ferrisbotPkg}/bin/ferrisbot";
      EnvironmentFile = "/etc/ferrisbot.env";
      Restart = "on-failure";
      DynamicUser = true;
      StateDirectory = "ferrisbot";
    };
  };
}
