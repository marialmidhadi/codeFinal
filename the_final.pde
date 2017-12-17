import blobDetection.*;
import peasy.*;
PeasyCam cam;
Flower[] b = new Flower [20];

PImage img;

float levels = 60;                    // number of contours
float factor = 1;                     // scale factor
float elevation = 75;                 // total height of the 3d model

float colorStart =  100;                // Starting degree of color range in HSB Mode (0-360)
float colorRange =  50;              // color range / can also be negative



// Array of BlobDetection Instances
BlobDetection[] theBlobDetection = new BlobDetection[int(levels)];

void setup() {
  size(1300, 1000, P3D); 

  img = loadImage("heightmap.gif");           // heightmap 256 x 256
  cam = new PeasyCam(this, 1000);
  colorMode(HSB, 360, 100, 100);   //HSB color mode 

  for (int i =0; i < b.length; i++) {

    //set random values to window of contour map so that it stays within those bounds (256 x 256)
    b[i] = new Flower(random(0, 256), random(0, 256), random(10, 30), random(50, 100));
    b[i].display();
  }

  //Computing Blobs with different thresholds 
  for (int i=0; i<levels; i++) {
    theBlobDetection[i] = new BlobDetection(img.width, img.height);
    theBlobDetection[i].setThreshold(i/levels);
    theBlobDetection[i].computeBlobs(img.pixels);
  }

  //peasycam settings
  cam.setWheelScale(0.1); //make the scroll more controlled
  //cam.setMinimumDistance(50);   <---these make program really slow for some reason
  //cam.setMaximumDistance(500);
}

void draw() { 
  background(0);
  translate(-img.width*factor, -img.height*factor);
  for (int i=0; i<levels; i++) {
    translate(0, 0, elevation/levels);  
    drawContours(i);
  }
  
//if flower.mousePressed{
// make flower disappear
//}

}

//uses blob detection to create elevations 
void drawContours(int i) {
  Blob b;
  EdgeVertex eA, eB;

  for (int n=0; n<theBlobDetection[i].getBlobNb(); n++) {
    b=theBlobDetection[i].getBlob(n);
    if (b!=null) {
      stroke((i/levels*colorRange)+colorStart, 100, 150);      // coloring the contours

      for (int m=0; m<b.getEdgeNb(); m++) {
        eA = b.getEdgeVertexA(m);
        eB = b.getEdgeVertexB(m);
        if (eA !=null && eB !=null)
          line(
            eA.x*img.width*factor, eA.y*img.height*factor, 
            eB.x*img.width*factor, eB.y*img.height*factor 
            );
      }
    }
  }
}