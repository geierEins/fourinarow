Field field;
int pointer, introBackground, playingBackground, resultsBackground;
String state;
Screens screens;

void setup() {
  size(700, 700);
  field = new Field(7, 6);
  screens = new Screens();
  state = "INTRO";
  introBackground = color(247,231,222);
  playingBackground = color(220,220,220);
  resultsBackground = color(245,230,222);
  pointer = 1; // 1=WHITE | -1=BLACK
}

void draw() {

  switch(state) {
    //--------------------------
  case "INTRO":
    background(introBackground);
    screens.showIntroScreen();
    break;
    //--------------------------
  case "PLAYING":
    background(playingBackground);
    screens.showPlayersTurn();
    field.runField();
    break;
    //--------------------------
  case "RESULTS":
    background(resultsBackground);
    field.drawField();
    screens.showResultScreen();
    break;
  }
}

void mousePressed() {
  switch(state) {

  case "INTRO":
    state="PLAYING";
    break;

  case "PLAYING": 
    int mappedCol = (int)map(mouseX, field.borderSize, width-field.borderSize, 0, 7);
    switch(pointer) {
    case 1:
      field.addStoneToCol("WHITE", mappedCol);
      field.checkForFourInArow();
      pointer*=-1;
      break;
    case -1:
      field.addStoneToCol("BLACK", mappedCol);
      field.checkForFourInArow();
      pointer*=-1;
      break;
    }
    break;
  case "RESULTS":
    field.resetField();
    state = "PLAYING";
    break;
  }
}

void keyPressed() {
  if (key == 'r') {
    setup();
  }
}
