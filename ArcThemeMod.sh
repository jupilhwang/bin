#!/usr/bin/env bash

cd /usr/share/themes/Arc-Darker

sudo cp ../Numix/xfwm4/close-* xfwm4
sudo cp ../Numix/xfwm4/hide-* xfwm4
sudo cp ../Numix/xfwm4/maximize-* xfwm4

sudo cp ../Numix/unity/close.svg unity/window-buttons/
sudo cp ../Numix/unity/close_unfocused.svg unity/window-buttons/
sudo cp ../Numix/unity/close_focused_pressed.svg unity/window-buttons/close_pressed.svg
sudo cp ../Numix/unity/close_focused_prelight.svg unity/window-buttons/close_prelight.svg
sudo cp ../Numix/unity/maximize.svg unity/window-buttons/
sudo cp ../Numix/unity/maximize_unfocused.svg unity/window-buttons/
sudo cp ../Numix/unity/maximize_focused_pressed.svg unity/window-buttons/maximize_pressed.svg
sudo cp ../Numix/unity/maximize_focused_prelight.svg unity/window-buttons/maximize_prelight.svg
sudo cp ../Numix/unity/minimize.svg unity/window-buttons/
sudo cp ../Numix/unity/minimize_unfocused.svg unity/window-buttons/
sudo cp ../Numix/unity/minimize_focused_pressed.svg unity/window-buttons/minimize_pressed.svg
sudo cp ../Numix/unity/minimize_focused_prelight.svg unity/window-buttons/minimize_prelight.svg

sudo sed -i -- 's/#444444/#2f343f/g' ./xfwm4/close-*
sudo sed -i -- 's/#444444/#2f343f/g' ./xfwm4/hide-*
sudo sed -i -- 's/#444444/#2f343f/g' ./xfwm4/maximize-*

sudo sed -i -- 's/#f0544c/#5294e2/g' ./xfwm4/close-*
sudo sed -i -- 's/#f0544c/#5294e2/g' ./xfwm4/hide-*
sudo sed -i -- 's/#f0544c/#5294e2/g' ./xfwm4/maximize-*

#sudo sed -i -- 's/#f0544c/#2f343f/g' ./unity/close*
#sudo sed -i -- 's/#f0544c/#2f343f/g' ./unity/maximize*
#sudo sed -i -- 's/#f0544c/#2f343f/g' ./unity/unmaximize*
#sudo sed -i -- 's/#f0544c/#2f343f/g' ./unity/minimize*

sudo rm -rf ./xfwm4/close-*.png
sudo rm -rf ./xfwm4/hide-*.png
sudo rm -rf ./xfwm4/maximize-*.png

sudo sed -i 's/assets\/titlebutton-close-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-backdrop-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-backdrop-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-hover-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-hover-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-active-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-active.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-close-active-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/close-active.xpm/g' ./gtk-3.0/*.css

sudo sed -i 's/assets\/titlebutton-maximize-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-backdrop-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-backdrop-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-hover-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-hover-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-active-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-active.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-maximize-active-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/maximize-active.xpm/g' ./gtk-3.0/*.css

sudo sed -i 's/assets\/titlebutton-minimize-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-backdrop-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-backdrop-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-inactive.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-hover-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-hover-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-pressed.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-active-dark.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-active.xpm/g' ./gtk-3.0/*.css
sudo sed -i 's/assets\/titlebutton-minimize-active-dark@2.png/\/usr\/share\/themes\/Arc-Darker\/xfwm4\/hide-active.xpm/g' ./gtk-3.0/*.css

