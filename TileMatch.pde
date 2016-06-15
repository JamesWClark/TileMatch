import java.util.Collections;

final int MAX_GUESSES = 2;

int numAttempts = 0;
int numMatched = 0;
int precision = 0;

int numTiles = 18;
int tileW = 60; // width
int tileH = 60; // height
int spacing = 10;

ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Tile> guesses = new ArrayList<Tile>();

void setup() {
  size(800, 600);
  String[] labels = {
    "bear",
    "cheetah",
    "fox",
    "giraffe",
    "hippo",
    "horse",
    "monkey",
    "rabbit",
    "zebra"
  };
  loadTiles(labels);
}

void draw() {
  background(255);
  drawTiles();
  stats(100, 300, 16);
}

void stats(int x, int y, int fontSize) {
  fill(0);
  textSize(fontSize);
  text("Attempts: " + numAttempts, x, y + spacing);
  text("Matches: " + numMatched, x, y + fontSize + spacing);
  String p = numAttempts == 0 ? "0" : str(round(float(numMatched) / float(numAttempts)));
  text("Precision: " + p, x, y + 2 * fontSize + spacing);  
  text("Time: " + millis() / 1000, x, y + 3 * fontSize + spacing);
}

// build shuffled tiles
void loadTiles(String[] labels) {
  // a list of 
  ArrayList<String> list = new ArrayList<String>();
  
  // add two copies to the list (there are two cards to match)
  for(int i = 0; i < labels.length; i++) {
    String one = labels[i].toString();
    String two = labels[i].toString();
    list.add(one);
    list.add(two);
  }
  
  for(int i = 0; i < labels.length; i++) {
    println(list.get(i));
  }
  
  // shuffle the cards
  Collections.shuffle(list);
  
  // create graphical tiles for the cards
  int count = 0;
  for(int y = 0; y < 3 * (spacing + tileH); y += tileH + spacing) {
    for(int x = 0; x < 6 * (spacing + tileW); x += tileW + spacing) {
      Tile t = new Tile(x, y, tileW, tileH, list.get(count++));
      tiles.add(t);
    }
  }
}

void drawTiles() {
  for(int i = 0; i < tiles.size(); i++) {
    tiles.get(i).drawTile();
  }
}

void mousePressed() {
  for(Tile t : tiles) {
    t.handleClick();
  }
  if(guesses.size() == MAX_GUESSES) {
    Tile guess1 = guesses.get(0);
    Tile guess2 = guesses.get(1);
    if(guess1.label.equals(guess2.label)) {
      guess1.matched = true;
      guess2.matched = true;
      numMatched++;
    }
    numAttempts++;
  } else if (guesses.size() > MAX_GUESSES) {
    Tile guess1 = guesses.get(0);
    Tile guess2 = guesses.get(1);
    guess1.hide();
    guess2.hide();
    guesses.remove(guess1);
    guesses.remove(guess2);
  }
}