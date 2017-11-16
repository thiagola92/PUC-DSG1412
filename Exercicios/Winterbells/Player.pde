public class Player {
  
  int radius = 15;
  int gravity = 1;
  int jumpSpeed = 5;
  int jumpDistance = 8; // The lower, the bigger distance
  
  boolean playing;
  
  PVector position;
  PVector velocity;
  PVector destination;
  
  public Player() {
    
    this.playing = false;
    
    this.position = new PVector(width/2, height - 30);
    this.velocity = new PVector(15, this.gravity);
    this.destination = new PVector(0, height - 30);
    
  }
  
  public void draw() {
    fill(0, 200, 255);
    ellipse(position.x, position.y, 2*radius, 2*radius);
  }
  
  public void update() {
    
    if(destination.x > position.x && destination.x - position.x > velocity.x)
      position.x += velocity.x;
    else if(destination.x < position.x && position.x - destination.x > velocity.x)
      position.x -= velocity.x;
      
    if(destination.y > position.y && destination.y - position.y > velocity.y)
      position.y += velocity.y;
    else if(destination.y < position.y && position.y - destination.y > velocity.y)
      position.y -= velocity.y;
      
    if(position.x >= destination.x - velocity.x && position.x <= destination.x + velocity.x) {
      if(position.y >= destination.y - velocity.y && position.y <= destination.y + velocity.y)
        onDestination();
    }
    
  }
  
  public boolean collision(int x, int y, int radius) {
    ellipse(x, y, 2*radius, 2*radius);
    
    float distanceX = abs(position.x - x);
    float distanceY = abs(position.y - y);
    float distanceTotal = sqrt(distanceX * distanceX + distanceY * distanceY);
    
    if(this.radius + radius >= distanceTotal)
      return true;
    
    return false;
  }
  
  public void jump() {
    velocity.y = jumpSpeed;
    
    int jump = (int)-(height/jumpDistance);
    
    if(position.y + jump < 0) {
      destination.y = 0;
    } else {
      destination.y = position.y + jump;
    }
      
    playing = true;
  }
  
  public void fall() {
    velocity.y = gravity;
    
    if(playing) {
      destination.y = height + 30;
    }
  }
  
  public void onDestination() {
    if(position.y > height + radius) {
      println("GAME OVER");
    } else {
      fall();
    }
  }
  
}

void createPlayers() {
  
  for(int i = 0; i < player.length; i++) {
    player[i] = new Player();
  }
  
}

void updatePlayers() {
  
  for(int i = 0; i < player.length; i++) {
    if(player[i] != null) {
      player[i].update();
      player[i].draw();
    }
  }
  
}