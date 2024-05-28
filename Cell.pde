class Cell{
  int xI, yI;
  boolean alive, next;
  
  Cell(){
  }
  
  Cell(int xI_, int yI_, boolean alive_){
    xI = xI_;
    yI = yI_;
    alive = alive_;
    next = alive_;
  }
  
  public void tick(){
    if(!drawing){
      checkState();
    }
    render();
  }
  
  private int countNeighbors(){
    int neighbors = 0;
    for(int i = -1; i <= 1; i++){
      for(int j = -1; j <= 1; j++){
        int tempRow = i + yI;
        int tempCol = j + xI;
        if(!(i == 0 && j == 0) && tempRow >= 0 && tempRow < rows && tempCol >= 0 && tempCol < cols && cells[tempRow][tempCol].alive){
          neighbors++;
        }
      }
    }
    return(neighbors);
  }
  
  private void checkState(){
    int neighbors = countNeighbors();
    if(alive){
      if(neighbors < 2 || neighbors > 3){
        next = false;
      }
    }
    else if(neighbors == 3){
      next = true;
    }
  }
  
  private void render(){
    if(next){
      noStroke();
      fill(255);
      rect(xI * size, yI * size, size, size);
    }
  }
}
