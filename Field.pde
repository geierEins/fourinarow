class Field {

  int cols, rows, borderSize;
  boolean fourInArow;
  Spot[][] spots;
  float fieldX, fieldY, fieldWidth, fieldHeight, widthByCols, heightByRows;

  // normally: new Field(7,6)
  Field(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    this.borderSize = 50;
    this.fieldX = borderSize;
    this.fieldY = borderSize;
    this.fieldWidth = width-(borderSize*2);
    this.fieldHeight = height - (borderSize*2);
    this.widthByCols = fieldWidth/cols;
    this.heightByRows = fieldHeight/cols;
    this.fourInArow = false;
    this.spots = new Spot[cols][rows];
    putEmptySpotsIntoField();
  }

  void resetField() {
    this.fourInArow = false;
    for (int r = 0; r < this.rows; r++) {
      for (int c = 0; c < this.cols; c++) {
        spots[c][r].resetSpot();
      }
    }
  }

  void putEmptySpotsIntoField() {
    float size = widthByCols; // one circle size for two directions!
    for (int r = 0; r < this.rows; r++) {
      for (int c = 0; c < this.cols; c++) {
        spots[c][r] = new Spot(
          0.5 * widthByCols + c * widthByCols + fieldX, //x 
          height -(0.5 * widthByCols + r * widthByCols) - fieldY, //y
          size);
      }
    }
  }

  void addStoneToCol(String farbe, int col) {
    for (int r = 0; r < this.rows; r++) {
      if (spots[col][r].isEmpty) {
        spots[col][r].addStoneToSpot(farbe);
        break;
      }
    }
  }

  void runField() {

    drawField();
    checkForFourInArow();
    alertWhenFourInArow();
  }

  void drawField() {
    for (int r = 0; r < this.rows; r++) {
      for (int c = 0; c < this.cols; c++) {
        spots[c][r].drawSpot();
      }
    }
  }
  
  void drawFieldFrame(){
    noFill();
    strokeWeight(10);
    stroke(150);
    rect(borderSize, borderSize, fieldWidth, fieldHeight);
  }

  void alertWhenFourInArow() {
    if (this.fourInArow) {
      state = "RESULTS";
    }
  }

  void checkForFourInArow() {
    checkForFourByStrategy("horRight");
    checkForFourByStrategy("vertUp");
    checkForFourByStrategy("diaUp");
    checkForFourByStrategy("diaDown");
  }

  void checkForFourByStrategy(String strategy) {
    int cd = 0;
    int rd = 0;
    int cStart = 0;
    int rStart = 0;
    int cEnd = this.cols;
    int rEnd = this.rows;
    // figure our config params for strategy
    switch(strategy) {
    case "vertUp":
      rd = 1;
      rEnd-=3;
      break;
    case "horRight":
      cd = 1;
      cEnd-=3;
      break;
    case "diaUp":
      cd = 1;
      rd = 1;
      cEnd-=3;
      rEnd-=3;
      break;
    case "diaDown":
      cd = 1;
      rd = -1;
      cEnd-=3;
      rStart+=3;
      break;
    }

    for (int r=rStart; r<rEnd; r++) {
      for (int c=cStart; c<cEnd; c++) {
        boolean fourStonesThere = false;
        // four stone there check
        if (spots[c][r].isEmpty==false &&
          spots[c+(1*cd)][r+(1*rd)].isEmpty==false &&
          spots[c+(2*cd)][r+(2*rd)].isEmpty==false &&
          spots[c+(3*cd)][r+(3*rd)].isEmpty==false) {
          fourStonesThere = true;
        }
        if (fourStonesThere==false) {
          continue;
        }
        // color check
        if ((spots[c][r].isBlack &&
          spots[c+(1*cd)][r+(1*rd)].isBlack &&
          spots[c+(2*cd)][r+(2*rd)].isBlack &&
          spots[c+(3*cd)][r+(3*rd)].isBlack) ||
          (spots[c][r].isWhite &&
          spots[c+(1*cd)][r+(1*rd)].isWhite &&
          spots[c+(2*cd)][r+(2*rd)].isWhite &&
          spots[c+(3*cd)][r+(3*rd)].isWhite)) {
          
          fourInArow=true; // win
          // mark winning spots
          spots[c][r].isWinning=true;
          spots[c+(1*cd)][r+(1*rd)].isWinning=true;
          spots[c+(2*cd)][r+(2*rd)].isWinning=true;
          spots[c+(3*cd)][r+(3*rd)].isWinning=true;
          break;
        }
      }
    }
  }
}
