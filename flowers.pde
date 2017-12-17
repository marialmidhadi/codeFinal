class Flower {
  float x;   //x position
  float y;   //y position
  float z;   //z position
  float r; //radius of sphere


  Flower(float _x, float _y, float _z, float _r) {
    x= _x;
    y= _y;
    z= _z;
    r= _r;

    println("flower created!");
  }



  // call this method to display the flower 
  void display() {
    noStroke();
    fill(140, 200, 150);
    smooth();
    lights();
    translate(x, y, z);
    sphere(r);
  }
}