PImage photo, maskImage;
void salvafoto() {
  photo = loadImage("conversione.png");
  maskImage = loadImage("mask.png");
  photo.blend(maskImage,0,0,1500,900,0,0,1500,900, ADD);
  photo.save(datafoto);
}
