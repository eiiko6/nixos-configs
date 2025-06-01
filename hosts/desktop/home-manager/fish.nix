{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
      grep = "grep --color=auto";
      ff = "fastfetch -c ~/.config/fastfetch/image.jsonc";
      ffs = "fastfetch -c ~/.config/fastfetch/small.jsonc --logo-type small";
      fff = "fastfetch -c ~/.config/fastfetch/full.jsonc";
      sd = "shutdown 0";
      rb = "shutdown -r 0";
      vim = "nvim";
      svim = "sudo nvim";
      ls = "exa -1lhmU --group-directories-first --no-permissions --no-user --icons --color always --sort date -r --time-style iso";
      lsa = "exa -1alhmUF --group-directories-first --no-permissions --no-user --icons --color always --sort date -r --time-style iso";
      cls = "c && lsa";
      c = "clear";
      cm = "chezmoi";
      cmcd = "cd /home/strawberries/.local/share/chezmoi/";
      ta = "tmux attach";
      theme = "~/.config/scripts/palette/change-wallpaper.sh";
    };

    interactiveShellInit = ''
      function palette
          ~/.config/scripts/palette/change-wallpaper.sh $argv
      end

      if status is-interactive
          ff
      else
          set -U fish_greeting
      end

      # Env variables
      set -Ux EDITOR nvim
      set -x MANPAGER 'nvim +Man!'

      # Set the prompt
      starship init fish | source

      # Bindings
      bind \b 'commandline -r ""'

      # External configs
      for file in ~/.config/fish/functions/*
          source $file 2>/dev/null
      end
      source ~/private/config.fish 2>/dev/null
    '';
  };
}
