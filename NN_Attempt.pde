int num_of_dots = 200;
int num_of_walls = 6;
int window_width = 1000;
int window_height = 900;
int total_deaded = 0;
int goal_width = 20;
int num_of_forces = 500;
int gen = 1;
float x = 500;
float y = 800;
int count = 0;

ArrayList<Dot> population = new ArrayList<Dot>();
ArrayList<Wall> walls = new ArrayList<Wall>();
Goal goal;
Brain brain;

void setup() {
  size(1000, 900);
  noStroke();

  brain = new Brain();
  goal = new Goal(490, 90, 490+goal_width, 90+goal_width);
  draw_boundaries();



  for (int i = 0; i < num_of_dots; i++) {
    ArrayList<PVector> forces = new ArrayList<PVector>();
    for (int j = 0; j < num_of_forces; j++) {
      forces.add(new PVector(random(-5, 5), random(-5, 5)));
    }
    population.add(new Dot(x, y, forces));
  }
}

void draw() {
  background(0);
  count+=5;
  for (int i = 0; i < population.size(); i++) {
    for (int j = 0; j < walls.size(); j++) {
      walls.get(j).draw_wall();
      population.get(i).check_contact(walls.get(j));
    }
    population.get(i).check_success(goal);
    goal.draw_goal();
    population.get(i).update();
    population.get(i).update();
    population.get(i).update();
    population.get(i).update();
    population.get(i).update();
    population.get(i).drawdot();
  }

  if (count == 500) {
    new_generation();
    gen++;

    count = 0;
  }

  //println(population.get(143).iteration);
}

void draw_boundaries() {
  walls.add(new Wall(-50, -50, 1050, 5)); //Top
  walls.add(new Wall(-50, 0, 5, 900)); //Left
  walls.add(new Wall(995, 0, 1050, 900));//Right
  walls.add(new Wall(-50, 895, 1050, 950));//Bottom
  walls.add(new Wall(400,500,600,600));
}

void new_generation() {
  ArrayList<Dot> best = new ArrayList<Dot>();
  float tot = 0;
  float avg = 0;
  ArrayList<Dot> new_pop = new ArrayList<Dot>();



  for (int i = 0; i < population.size() - 1; i++) {
    tot += brain.fitness(goal, population.get(i));
  }
  avg = tot/population.size();
  println(avg);
  
  for (int i = 0; i < population.size() - 1; i++){
   if(brain.fitness_func(population.get(i), avg)){
     best.add(population.get(i));
   }
  }

  while (best.size() < 100) {
    best.add(population.get(int(random(0, 199))));
  }

  while (best.size() > 100) {
    best.remove(best.size() - 1);
  }

  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < best.size() - 1; i++) { 
      new_pop.add(brain.offspring(best.get(round(random(0, best.size()-1))), best.get(round(random(0, best.size()-1)))));
    }
  }
  while (new_pop.size() > 200) {
    new_pop.remove(best.size() - 1);
  }
  for (int i = population.size()-1; i > 0 - 1; i--) {
    population.remove(i);
  }

  for (int i = 0; i < new_pop.size() - 1; i++) {
    population.add(new_pop.get(i));
  }

}
