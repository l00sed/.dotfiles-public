#BEGIN - Table of Contents ====================================

   #  Gradient Generators with ImageMagick
     #  Useful Links:
     #  Gradient Swirl
     #  Smile Gradient
     #  Ripple Gradient
     #  Voronoi Gradient
     #  Triple Dot Blur

#END   - Table of Contents ====================================

#* Gradient Generators with ImageMagick

#** Useful Links:
#     Using gradients:
#       https://legacy.imagemagick.org/Usage/canvas/
#     Color library:
#       https://imagemagick.org/script/color.php

#** Gradient Swirl
# -------------------
# Generates a rotating line that
# change color from 0-360 degrees
gradient_swirl() {
   convert -size 1x1000 gradient:$1-$2 -rotate 90 \
           +distort Polar "$3,0,.5,.5" +repage \
           -transverse background.jpeg
}

#** Smile Gradient
# -------------------
smile_gradient() {
  convert -size $3x$3 radial-gradient:$1-$2 \
          +distort Polar '49' +repage \
          background.jpeg
}

#** Ripple Gradient
# ------------------
ripple_gradient() {
  echo "P2 2 2 2   2 1 1 0 " | \
  convert - -resize 100x100\! background.jpeg
}

#** Voronoi Gradient
# ------------------
voronoi_gradient() {
  convert -size 3840x2160 xc: -colorspace RGB \
    -sparse-color Voronoi "300,100 $1  100,800 $2  700,600 $3  800,200 $4" \
    -blur 0x15 -colorspace sRGB \
    background.jpeg
}

#** Triple Dot Blur
# -----------------
td_blur_gradient() {
  convert -size 1920x1080 xc: -colorspace RGB \
          -sparse-color Shepards "500,500 $1 1800,300 $2 1600,900 $3" \
          -brightness-contrast -12x9 \
          -colorspace sRGB background.jpeg
  if [ $4 ]; then
    sudo mv background.jpeg /etc/regolith/styles/waterfall/background.jpeg
  fi
}
