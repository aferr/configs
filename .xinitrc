xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/local
xset fp rehash
xset +fp /usr/share/fonts/TTF
xset fp rehash
xrdb -merge .Xresources
#/home/andrew/bin/wallpaper &
#feh --bg-scale .background &
xcompmgr -n -c -C -t-5 -l-5 -r4.2 -o.55 &
xmodmap .Xmodmap
xmodmap -e "clear lock"
xflux -z 14850
xmonad
