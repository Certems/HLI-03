class optionsMenu{
    gameManager GM;

    optionsMenu(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        //pass
    }
    void draw(){
        displayOptionsMenu();
    }

    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){}
    void keyReleased(){}

    //##############################################################################
    //## MAKE BUTTONS ARBITRARILY PLACEABLE, MAYBE STORE IN LIST AS BUTTON OBJECT ##
    //##############################################################################

    void displayOptionsMenu(){
        float homeButtonWidth   = width/6;    //**Used for all menu buttons**
        float homeButtonHeight  = height/16;  //
        float homeButtonSpacing = 60;         //
        pushStyle();
        rectMode(CENTER);  //##WILL REPLACE WITH IMAGE EVENTUALLY##//
        imageMode(CENTER);
        textAlign(CENTER);
        
        /*
        fill(150,220,205);
        strokeWeight(4);
        ellipse(width/2, height/2, width/2, height/6);
        
        fill(0);
        textSize(15);
        text("CURRENTLY NO OPTIONS, PRESS 'u' TO LEAVE", width/2, height/2);
        */
        
        //1st
        stroke(2);
        fill(255);
        rect(width/2, (height/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Tile index list", width/2, (height/8)+(2*homeButtonSpacing));
        
        //2nd
        stroke(2);
        fill(255);
        rect(width/2, (height/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Select2", width/2, (height/8)+(4*homeButtonSpacing));
        
        //3rd
        stroke(2);
        fill(255);
        rect(width/2, (height/8)+(6*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Select3", width/2, (height/8)+(6*homeButtonSpacing));
        
        //4th
        stroke(2);
        fill(255);
        rect(width/2, (height/8)+(8*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
        fill(0);
        textSize(20);
        text ("Back", width/2, (height/8)+(8*homeButtonSpacing));
        
        popStyle();
    }
}