int wdt = 960;
int hgt = 540;
int size = 20;
int cols = wdt / size;
int rows = hgt / size;
boolean drawing = true;
Cell[][] cells;

void setup(){
  windowResize(wdt, hgt);
  frameRate(60);
  rectMode(CORNER);
  cells = new Cell[rows][cols];
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      Cell temp = new Cell(j, i, false);
      cells[i][j] = temp;
    }
  }
  System.out.println("Currently drawing");
}

void draw(){
  background(0);
  for(Cell[] tempArr : cells){
    for(Cell temp : tempArr){
      temp.tick();
    }
  }
  if(!drawing){
    for(Cell[] tempArr : cells){
      for(Cell temp : tempArr){
        temp.alive = temp.next;
      }
    }
  }
  renderGrid();
}

void keyPressed(){
  switch(key){
    case ENTER:
      drawing = !drawing;
      if(drawing){
        frameRate(60);
        System.out.println("Currently drawing");
      }
      else{
        frameRate(10);
        System.out.println("Currently simulating");
      }
      break;
      
    case ' ':
      if(drawing){
        drawing = false;
        draw();
        drawing = true;
      }
  }
}

void mouseDragged(){
  if(drawing && mouseX >= 0 && mouseX <= wdt && mouseY >= 0 && mouseY <= hgt){
    int mouseXI = (int)mouseX / size;
    int mouseYI = (int)mouseY / size;
    Cell target = cells[mouseYI][mouseXI];
    target.next = !target.alive;
  }
}

void mouseReleased(){
  for(Cell[] tempArr : cells){
    for(Cell temp : tempArr){
      temp.alive = temp.next;
    }
  }
}

void renderGrid(){
  for(int i = 0; i < wdt / size; i++){
    stroke(150);
    line(i * size, 0, i * size, hgt);
  }
  for(int i = 0; i < hgt / size; i++){
    stroke(150);
    line(0, i * size, wdt, i * size);
  }
}
