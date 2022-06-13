#!/bin/bash

#BEGIN - Table of Contents ====================================

   #  Minify CSS and JS files, lint
      #  MinJS
      #  MinCSS

#END   - Table of Contents ====================================

#* Minify CSS and JS files, lint
#** MinJS
# Minify JS file, lint
# usage: `minJS input.js output.min.js`
minJS() {
  terser "$1" --compress --mangle -o "$2"
}
#** MinCSS
# Style linter, autoprefixer and minifier
# usage: `minCSS input.css output.min.css`
minCSS() {
  npx postcss autoprefixer "$1" postcss-clean --no-map -o "$2"
}
