class Spot {

  float x, y, size;
  boolean isEmpty, isBlack, isWhite, isWinning;


  Spot(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.isEmpty = true;
    this.isBlack = false;
    this.isWhite = false;
    this.isWinning = false;
  }

  void addStoneToSpot(String farbe) {
    this.isEmpty = false;
    switch(farbe) {
    case "BLACK":
      this.isBlack = true;
      break;
    case "WHITE":
      this.isWhite = true;
      break;
    }
  }

  void drawSpot() {
    fillAndStrokeState();
    circle(x, y, size*0.9);
  }

  void fillAndStrokeState() {
    if (isEmpty) {
      fill(255);
      strokeWeight(1);
      stroke(180);
    }
    if (isBlack) {
      fill(40, 40, 40);
      strokeWeight(2);
      stroke(0);
    } 
    if (isWhite) {
      fill(200, 200, 200);
      strokeWeight(2);
      stroke(0);
    }
    if (isWinning) {
      strokeWeight(5);
      stroke(255, 0, 0);
    }
  }

  void resetSpot() {
    this.isEmpty = true;
    this.isBlack = false;
    this.isWhite = false;
    this.isWinning = false;
  }
}
