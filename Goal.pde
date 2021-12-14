class Goal {
  PVector top_left;
  PVector bottom_right;

  Goal(int x1, int y1, int x2, int y2) {
    this.top_left = new PVector(x1, y1);
    this.bottom_right = new PVector(x2, y2);
  }

  void draw_goal() {
    stroke(0,255,0);
    fill(0,255,0);
    rectMode(CORNERS);
    rect(this.top_left.x, this.top_left.y, this.bottom_right.x, this.bottom_right.y);
  }
}
