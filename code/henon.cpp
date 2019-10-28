// This ANSI-C program computes various images of the henon map's attractor.

#include <cstdlib>
#include <iostream>
#include <ostream>

#include <png++/png.hpp>


png::image< png::rgb_pixel_16 > image(1024, 1024);

int main(int argc, const char *argv[]) {
  for (png::uint_32 y = 0; y < image.get_height(); ++y) {
    for (png::uint_32 x = 0; x < image.get_width(); ++x) {
      image[y][x] = png::rgb_pixel_16(x*64, y*64, (x + y)*64);
      // non-checking equivalent of image.set_pixel(x, y, ...);
    }
  }
  image.write("rgb.png");
  return 0;
}
