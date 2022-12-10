class overlay{
    gameManager GM;

    float xAlign1 = 30.0;

    float yAlign1 = 30.0;

    overlay(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        //pass
    }
    void draw(){
        showFrameRate();
        showMouseTile();
    }

    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){}
    void keyReleased(){}

    void showFrameRate(){
        pushStyle();
        textSize(18);
        stroke(255);
        text(frameRate, xAlign1, 1.0*yAlign1);
        popStyle();
    }
    void showMouseTile(){
        pushStyle();
        textSize(18);
        stroke(255);
        int hoveredTile = GM.s0.maps.get( GM.s0.currentMap ).findMouseTile();
        text("MouseTile -> "+ hoveredTile, xAlign1, 2.0*yAlign1);
        popStyle();
    }
    /*
    void ...(){
        pushStyle();
        textSize(18);
        stroke(255);
        text(... , xAlign1, ...*yAlign1);
        popStyle();
    }
    */
}