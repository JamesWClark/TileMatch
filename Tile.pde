class Tile {
  int x;
  int y;
  int w;
  int h;
  String label;
  PImage icon;
  boolean display = false;
  boolean clickable = true;
  boolean matched = false;

  Tile(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.icon = loadImage(label + ".jpg");
  }

  void drawTile() {
    if (this.display || this.matched) {
      image(icon, x, y);
    } else {
      fill(255, 0, 0);
      rect(x, y, w, h);
    }
  }

  // core game logic
  void handleClick() {
    if (!matched && mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      guesses.add(this);
      show();
    }
  }
  
  void show() {
    if(!matched) {
        this.clickable = false;
        this.display = true;
    }
  }
  
  void hide() {
    if(!matched) {
      this.clickable = true;    
      this.display = false;
    }
  }
}