class homeMenu{
    gameManager GM;

    homeMenu(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        //pass
    }
    void draw(){
        displayHomeMenu();
    }

    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){}
    void keyReleased(){}

    //##############################################################################
    //## MAKE BUTTONS ARBITRARILY PLACEABLE, MAYBE STORE IN LIST AS BUTTON OBJECT ##
    //##############################################################################

    void displayHomeMenu(){
        float homeButtonWidth   = width/6;    //**Used for all menu buttons**
        float homeButtonHeight  = height/16;  //
        float homeButtonSpacing = 60;         //
        pushStyle();
        imageMode(CENTER);
        rectMode (CENTER);
        textAlign(CENTER);
        
        image(GM.s3.menu1, width/2, height/2);
        
        //
        
        
        
        
        //
        
        stroke(2);
        fill(255);
        rect(width/8, (3*width/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Continue", width/8, (3*width/8)+(2*homeButtonSpacing));
        
        stroke(2);
        fill(255);
        rect(7*width/8, (3*width/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("New Game", 7*width/8, (3*width/8)+(2*homeButtonSpacing));
        
        stroke(2);
        fill(255);
        rect(width/8, (3*width/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Options", width/8, (3*width/8)+(4*homeButtonSpacing));
        
        stroke(2);
        fill(255);
        rect(7*width/8, (3*width/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Exit", 7*width/8, (3*width/8)+(4*homeButtonSpacing));
        
        popStyle();
    }
}