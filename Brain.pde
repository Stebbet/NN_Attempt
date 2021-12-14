class Brain {
  Brain() {
  }

  float fitness(Goal goal, Dot dot) {
    float distance = dist(dot.pos.x, dot.pos.y, goal.top_left.x + goal_width/2, goal.top_left.y + goal_width/2);
    float m = map(distance, 0, 800, 1, 0);
    //m = 1/(1+pow(exp(1.0), -m)); //sigmoid
    dot.fitness = m;
    return m;
  }
  
  boolean fitness_func(Dot dot, float avg){
    if(dot.fitness >= avg){
      return true;
    }
    return false;
  }

  Dot offspring(Dot dot1, Dot dot2) {
    ArrayList<PVector> zip = new ArrayList<PVector>();
    for (int i = 0; i < num_of_forces - 1; i++) {
      int choice = int(random(1, 2));
      if (choice == 1) {
        zip.add(dot1.forces.get(int(random(0, num_of_forces - 1))));
      } else {
        zip.add(dot2.forces.get(int(random(0, num_of_forces - 1))));
      }
    }
    // Mutation

    int mut = int(random(0, num_of_forces - 1));
    zip.set(mut, new PVector(random(-5, 5), random(-5, 5)));

    return new Dot(x, y, zip);
  }
}
