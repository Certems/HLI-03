class entityController{
    gameManager GM;

    ArrayList<ArrayList<entity>> entities = new ArrayList<ArrayList<entity>>();
    /*
    Holds different sub-classes of entities in each index;
    0 -> Player
    1 -> Orc
    ...
    */
    //############################################### **
    //## Increase value as more entities are added ##
    //###############################################
    int nEntity = 2;

    entityController(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        initialiseEntities();

        createOrc( new PVector(500,500), 1 );
    }
    void draw(){
        drawAllEntities();
    }

    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){
        if(key == '1'){
            createOrc( new PVector(random(500,2000),random(500,2000)), 1 );
        }
    }
    void keyReleased(){}

    void initialiseEntities(){
        entities.clear();
        for(int i=0; i<nEntity; i++){
            entities.add( new ArrayList<entity>() );
        }
    }
    void createRandomEntity(PVector pos, int size){
        int rVal = floor(random(1,nEntity));
        //Discluding player
        if(rVal == 1){
            createOrc(pos, size);
        }
        //...
    }
    void drawAllEntities(){
        for(int i=0; i<entities.size(); i++){
            for(int j=0; j<entities.get(i).size(); j++){
                entities.get(i).get(j).display();
            }
        }
    }

    void createPlayer(PVector pos, int size){
        player newEntity = new player(pos, size);
        entities.get(0).add(newEntity);
    }
    void createOrc(PVector pos, int size){
        orc newEntity = new orc(pos, size);
        entities.get(1).add(newEntity);
    }

    class entity{
        PVector pos;
        PVector vel = new PVector(0,0);
        PVector acc = new PVector(0,0);

        //GM.s6.follower cFollower;

        int size;   //Number of tiles creature takes up, odd values only ##POSSIBLY##

        entity(PVector initPos, int tilesOccupied){
            pos  = initPos;
            size = tilesOccupied;
        }

        void display(){
            //pass
        }
    }

    class player extends entity{
        //pass

        player(PVector pos, int size){
            super(pos, size);
        }

        @Override
        void display(){
            pushStyle();
            //...
            popStyle();
        }
    }

    class orc extends entity{
        //pass

        orc(PVector pos, int size){
            super(pos, size);
        }

        @Override
        void display(){
            PVector newPos = GM.s0.maps.get(GM.s0.currentMap).convertFromRelative(pos);
            pushStyle();
            imageMode(CENTER);
            image( GM.s3.orcFrontStat, newPos.x, newPos.y );
            popStyle();
        }
    }

    //...

}