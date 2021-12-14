// Needs a set of instructions so that the dots would be able to move on their own
// Random at the start and as the NN works the instructions would be edited to steer the dot to the goal

class Dot {
  PVector pos;
  ArrayList<PVector> forces = new ArrayList<PVector>();
  color stroke_colour;
  int iteration;
  boolean dead;
  float fitness;
  
  Dot(float posx, float posy, ArrayList forces) {
    this.fitness = 0;
    this.iteration = 0;
    this.pos = new PVector(posx, posy);
    this.forces = forces;
    this.stroke_colour = color(255, 255, 255);
    this.dead = false;
  }

  void drawdot() {
    stroke(this.stroke_colour);
    fill(this.stroke_colour);
    ellipseMode(CENTER);
    ellipse(this.pos.x, this.pos.y, 10, 10);
  }

  void update() {
    try {
      this.pos.add(this.forces.get(iteration));
    } 
    catch(Exception e) {
      this.dead();
    }
    this.iteration += 1;
  }


  void dead() {
    this.stroke_colour = color(255, 0, 0);
    for (int i = iteration; i < this.forces.size() - 1; i++) {
      this.forces.set(i, new PVector(0, 0));
    }
  }

  void success() {
    this.stroke_colour = color(0, 255, 0);
    for (int i = iteration; i < this.forces.size() - 1; i++) {
      this.forces.set(i, new PVector(0, 0));
    }
  }

  void check_contact(Wall wall) {
    if (this.pos.x > wall.top_left.x && this.pos.x < wall.bottom_right.x &&
      this.pos.y > wall.top_left.y && this.pos.y < wall.bottom_right.y) 
    {
      this.dead = true;
      this.dead();
    }
  }

  void check_success(Goal goal) {
    if (this.pos.x > goal.top_left.x && this.pos.x < goal.bottom_right.x &&
      this.pos.y > goal.top_left.y && this.pos.y < goal.bottom_right.y)
    {
      this.success();
    }
  }
}
