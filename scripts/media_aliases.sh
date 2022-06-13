#!/bin/bash
#BEGIN - Table of Contents ====================================

   #  FFMpeg
     #  Make an .mp4 video from an input folder of image
     #  Convert a video to png images
     #  Convert 'test.mp4' to 'test.gif'
     #  Convert a video to a gif
   #  Autotrace - https:github.comautotraceautotrace
     #  Convert an image to an .svg graphic
   #  ImageMagick
     #  Thumbnail images for faster load times
     #  Thumbnail for all images in a directory
     #  Imagemagick Smart-Resize
   #  Image manipulation - https:github.comtransitive-bullshitprimitive-clireadme
     #  polygonized lqip image for single file
     #  polygonized lqip images for all image in a directory

#END   - Table of Contents ====================================

#* FFMpeg
#** Make an .mp4 video from an input folder of image
# The input glob pattern MUST BE WRAPPED IN QUOTES otherwise the command will interpret it as multiple arguments and fail
mkvid() {
  ffmpeg -framerate 30 -pattern_type glob -i "$1" -vcodec libx264 -crf 0 test.mp4
}
#** Convert a video to png images
convpng() {
  ffmpeg -i "$1" -vf "scale=(iw*sar)*max("$2"/(iw*sar)\,"$3"/ih):ih*max("$2"/(iw*sar)\,"$3"/ih), crop="$2":"$3",fps=30" "$4"
}
#** Convert an animated gif to a mp4 video
convmp4_full() {
  ffmpeg -f gif -i sketch.gif video.mp4
}
#** Convert an animated gif to a mp4 video
convmp4_half() {
  ffmpeg -i sketch.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" video.mp4
}
#** Convert 'test.mp4' to 'test.gif'
alias convgif='ffmpeg -i sketch.mp4 -vf scale=iw/2:ih/2 -f gif sketch.gif'
#** Convert a video to a gif
mkgif() {
  ffmpeg -pattern_type glob -r 1 -i "$1" -vf "scale='min(640,iw)':'min(480,ih)':force_original_aspect_ratio=decrease,pad=640:480:(ow-iw)/2:(oh-ih)/2" -pix_fmt yuv420p -f gif output.gif
}

#* Autotrace - https://github.com/autotrace/autotrace
#** Convert an image to an .svg graphic
convsvg() {
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  autotrace -output-file "$2" -input-format "$extension" -dpi 600 -color-count 16 "$1"
}

wm2mp4() {
  ffmpeg -i sketch.webm -fflags +genpts -r 25 -crf 0 -c:v copy sketch.mp4
}

#* ImageMagick

#** Thumbnail images for faster load times
thumb() {
  if [ ${1##*.} != "gif" ]
    then
      convert $1 -resize 300x300 thumbs/${1%.*}-thumbnail.${1##*.}
  fi
  if [ ${1##*.} = "gif" ]
    then
      convert $1 -coalesce -resize 300x300 thumbs/${1%.*}-thumbnail.${1##*.}
  fi
}

#** Thumbnail for all images in a directory
thumbAll () {
  for image in *;
    do thumb "$image"
  done
}

#** Imagemagick Smart-Resize
smartRes() {
   mogrify -write thumbs/${1%.*}-thumbnail.${1##*.} -filter Triangle -define filter:support=2 -thumbnail 500 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

#* Image manipulation - https://github.com/transitive-bullshit/primitive-cli#readme
#** polygonized lqip image for single file
poly() {
  if [ ${1##*.} != "gif" ]
    then
      primitive -i $1 -o lqip/${1%.*}-lqip.${1##*.} -r 32 -s 32 -bg 'avg' -n 150 -v
  fi
  if [ ${1##*.} = "gif" ]
    then
      convert "$1[0]" temp.gif
      primitive -i temp.gif -o lqip/${1%.*}-lqip.jpg -bg 'avg' -r 32 -s 32 -n 150 -v
      rm temp.gif
  fi
}
#** polygonized lqip images for all image in a directory
polyAll () {
  for image in *;
    do
      poly "$image"
  done
}


