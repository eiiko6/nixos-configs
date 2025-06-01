{ config, pkgs, inputs, lib, ... }:
let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/eiiko6/pkmsmp/refs/heads/master/pack.toml";
    packHash = "sha256-hBcgJHSlnWi+rHn9TSu5KNa5cBSEyXPErQXzYN32cF4=";
    manifestHash = "sha256-uiE+ksV0GgIw7R86nev7b3aUDpqfAeVhYifZLgnKg10=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
in
{
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      vanilla-survival = {
        enable = true;
        autoStart = false;
        package = pkgs.paperServers.paper-1_21_4;

        jvmOpts = "-Xms14336M -Xmx14336M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15";

        serverProperties = {
          server-port = 49153;
          motd = "Vanilla survival server";

          simulation-distance = 25;
          view-distance = 25;

          spawn-protection = 0;

          gamemode = "survival";
          difficulty = "hard";
        };
      };
      vanilla-creative = {
        enable = true;
        autoStart = false;
        package = pkgs.paperServers.paper-1_21_4;

        jvmOpts = "-Xms14336M -Xmx14336M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15";

        serverProperties = {
          server-port = 49153;
          motd = "Vanilla creative server";

          simulation-distance = 25;
          view-distance = 25;

          spawn-protection = 0;

          gamemode = "creative";
          difficulty = "normal";
          level-type = "minecraft\:flat";
          generate-structures = false;
        };
      };
      pkmsmp = {
        enable = true;
        autoStart = false;
        package = pkgs.fabricServers.${serverVersion}.override { loaderVersion = fabricVersion; };

        jvmOpts = "-Xms14336M -Xmx14336M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15";

        symlinks = {
          "mods" = "${modpack}/mods";
        };

        serverProperties = {
          server-port = 49153;
          motd = "PkmSMP hosted myself ^^";

          simulation-distance = 25;
          view-distance = 25;

          spawn-protection = 0;

          gamemode = "survival";
          difficulty = "hard";
        };
      };
    };
  };
}
