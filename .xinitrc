xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/local
xset fp rehash
xset +fp /usr/share/fonts/TTF
xset fp rehash
xrdb -merge .Xresources
feh --bg-scale /home/andrew/.background
xmodmap .Xmodmap
xmodmap -e "clear lock"
xflux -z 14850
xmonad
