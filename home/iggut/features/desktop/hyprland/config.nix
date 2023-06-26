{ home, colorscheme, wallpaper }:
let
  inherit (home.sessionVariables) TERMINAL BROWSER EDITOR;
in
''
  general {
    gaps_in=15
    gaps_out=20
    border_size=1.7
    col.active_border=0xff${colorscheme.colors.base0C}
    col.inactive_border=0xff${colorscheme.colors.base02}
    col.group_border_active=0xff${colorscheme.colors.base0B}
    col.group_border=0xff${colorscheme.colors.base04}
    cursor_inactive_timeout=4
  }

  decoration {
    active_opacity=0.94
    inactive_opacity=0.84
    fullscreen_opacity=1.0
    rounding=5
    blur=true
    blur_size=5
    blur_passes=3
    blur_new_optimizations=true
    blur_ignore_opacity=true
    drop_shadow=true
    shadow_range=12
    shadow_offset=3 3
    col.shadow=0x44000000
    col.shadow_inactive=0x66000000
  }

  animations {
    enabled=true

    bezier=easein,0.11, 0, 0.5, 0
    bezier=easeout,0.5, 1, 0.89, 1
    bezier=easeinout,0.45, 0, 0.55, 1

    animation=windowsIn,1,3,easeout,slide
    animation=windowsOut,1,3,easein,slide
    animation=windowsMove,1,3,easeout

    animation=fadeIn,1,3,easeout
    animation=fadeOut,1,3,easein
    animation=fadeSwitch,1,3,easeout
    animation=fadeShadow,1,3,easeout
    animation=fadeDim,1,3,easeout
    animation=border,1,3,easeout

    animation=workspaces,1,2,easeout,slide
  }

  dwindle {
    split_width_multiplier=1.35
  }

  misc {
    vfr=on
  }

  input {
    kb_layout=us
    touchpad {
      disable_while_typing=false
    }
  }


  # Startup
  exec-once=waybar
  exec-once=sfwbar
  exec=swaybg -i ${wallpaper} --mode fill
  exec-once=mako
  exec-once=swayidle -w

  monitor = DP-1,1920x1080@165,0x0,1
  monitor = HDMI-A-1,2560x1440@60,1920x0,1

  $files = thunar
  $browser = firefox
  $term = kitty
  $editor = code
  # Set mod key to Super
  $mainMod = SUPER

  #Desktop usage
  bind = $mainMod, R, exec, rofi -show drun
  bind = $mainMod, V, exec, clipman pick -t rofi
  bind = , Print, exec, grim - | wl-copy
  bind = SHIFT, insert, exec, grim - | swappy -f -
  bind = $mainMod, insert, exec, grim -g "$(slurp)" - | wl-copy
  bind = $mainMod SHIFT, insert, exec, grim -g "$(slurp)" - | swappy -f -
  bind = $mainMod, L, exec, wlogout
  bind = $mainMod, N, exec, swaync-client -t -sw
  bind = $mainMod SHIFT, N, exec, swaync-client -d -sw

  bindr = SUPER, SUPER_L, exec, nwg-drawer

  bind = $mainMod, D, exec, thunar
  bind = $mainMod SHIFT, Q, killactive,
  bind = $mainMod SHIFT, Return, exec, $files
  bind = $mainMod SHIFT, Space, togglefloating,
  bind = $mainMod, E, exec, code
  bind = $mainMod, F, fullscreen
  bind = $mainMod, Q, killactive,
  bind = $mainMod, Return, exec, $term
  bind = $mainMod, T, exec, $term
  bind = $mainMod, V, exec, pavucontrol
  bind = $mainMod, Space, togglefloating,

  # Change Workspace Mode
  bind = SUPER_ALT, Space, workspaceopt, allfloat
  bind = $mainMod, P, pseudo, # dwindle


  # Mainmod + Function keys
  bind = $mainMod, F1, exec, $browser
  bind = $mainMod, F2, exec, $editor
  bind = $mainMod, F3, exec, inkscape
  bind = $mainMod, F4, exec, gimp
  bind = $mainMod, F5, exec, meld
  bind = $mainMod, F6, exec, vlc
  bind = $mainMod, F7, exec, virtualbox
  bind = $mainMod, F8, exec, $files
  bind = $mainMod, F9, exec, evolution
  bind = $mainMod, F10, exec, spotify
  bind = $mainMod, F11, exec, rofi -show drun
  bind = $mainMod, F12, exec, rofi -show drun

  # Special Keys
  bind = , xf86audioraisevolume, exec, $volume --uo
  bind = , xf86audiolowervolume, exec, $volume --down
  bind = , xf86audiomute, exec, $volume --toggle
  bind = , xf86audioplay, exec, playerctl play-pause
  bind = , xf86audionext, exec, playerctl next
  bind = , xf86audioprev, exec, playerctl previous
  bind = , xf86audiostop, exec, playerctl stop
  bind = , xf86monbrightnessup, exec, $brightness --inc
  bind = , xf86monbrightnessdown, exec, $brightness --dec

  # Switch workspaces with mainMod + [0-9]
  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, 7, workspace, 7
  bind = $mainMod, 8, workspace, 8
  bind = $mainMod, 9, workspace, 9
  bind = $mainMod, 0, workspace, 10

  # Move active window and follow to workspace
  bind = $mainMod CTRL, 1, movetoworkspace, 1
  bind = $mainMod CTRL, 2, movetoworkspace, 2
  bind = $mainMod CTRL, 3, movetoworkspace, 3
  bind = $mainMod CTRL, 4, movetoworkspace, 4
  bind = $mainMod CTRL, 5, movetoworkspace, 5
  bind = $mainMod CTRL, 6, movetoworkspace, 6
  bind = $mainMod CTRL, 7, movetoworkspace, 7
  bind = $mainMod CTRL, 8, movetoworkspace, 8
  bind = $mainMod CTRL, 9, movetoworkspace, 9
  bind = $mainMod CTRL, 0, movetoworkspace, 10
  bind = $mainMod CTRL, bracketleft, movetoworkspace, -1
  bind = $mainMod CTRL, bracketright, movetoworkspace, +1

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
  bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
  bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
  bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
  bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
  bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
  bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
  bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
  bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
  bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
  bind = $mainMod SHIFT, bracketleft, movetoworkspacesilent, -1
  bind = $mainMod SHIFT, bracketright, movetoworkspacesilent, +1

  # Scroll through existing workspaces with mainMod + scroll
  bind = $mainMod, mouse_down, workspace, e+1
  bind = $mainMod, mouse_up, workspace, e-1
  bind = $mainMod, period, workspace, e+1
  bind = $mainMod, comma, workspace, e-1

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = , mouse:276, movewindow
  bindm = , mouse:275, resizewindow
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow

  # Group windows 
  bind = $mainMod, G, togglegroup
  bind = $mainMod, tab, changegroupactive, f

  # Switch windows

  bind = ALT, Tab, exec, killall -SIGUSR1 .sfwbar-wrapped 

  blurls=waybar
''
