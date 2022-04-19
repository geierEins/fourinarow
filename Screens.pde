class Screens {

  // Constants
  int Y_AXIS = 1;
  int X_AXIS = 2;

  void showIntroScreen() {
    fill(50);
    noStroke();
    textAlign(CENTER);
    textSize(50);
    text("start game", width/2, height/2);
    fill(80);
    textSize(20);
    text("(click anywhere)", width/2, height/2+30);
  }

  void showPlayersTurn() {
    // alpha over view
    textAlign(CENTER);
    textSize(35);
    noStroke();
    if (pointer==1) {
      fill(255, 180);
      setGradient(0, 0, width, 125, color(255), playingBackground, Y_AXIS);
      //fill(40, 200);
      //text("white player's turn", width/2, 75);
    } else {
      fill(40, 180);
      setGradient(0, 0, width, 125, color(20), playingBackground, Y_AXIS);
      //fill(240, 200);
      //text("black player's turn", width/2, 75);
    }
  }

  void showResultScreen() {
    // alpha over view
    fill(255, 120);
    rect(0, 0, width, height);

    fill(20);
    textAlign(CENTER, CENTER);
    textSize(70);
    if (pointer==-1) { // WHITE wins
      text("white player wins!", width/2, height/12);
    } else {  // BLACK wins
      text("black player wins!", width/2, height/12);
    }
    fill(50);
    textSize(20);
    text("(click anywhere to play again)", width/2, height/12 + 60);
  }

  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}
