class mapController{
    gameManager GM;

    ArrayList<map> maps = new ArrayList<map>();
    int currentMap  = 0;    //Index of the map currently being used / loaded

    boolean cameraLeft  = false;
    boolean cameraRight = false;
    boolean cameraUp    = false;
    boolean cameraDown  = false;

    mapController(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        GM.s3.loadTextures();
        createMap();
    }
    void draw(){
        drawMap(currentMap);
        cameraMovement();
    }
    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){
        cameraCalcPress();
    }
    void keyReleased(){
        cameraCalcRelease();
    }


    void createMap(){
        int[] newMapSpec = {1,1,0,0};
        map newMap = new map(newMapSpec, 60, 60, 5);
        maps.add(newMap);
    }
    void drawMap(int mapN){
        maps.get(mapN).display();
    }
    void cameraCalcPress(){
        if(key == 'w'){
            cameraUp    = true;
        }
        if(key == 's'){
            cameraDown  = true;
        }
        if(key == 'a'){
            cameraLeft  = true;
        }
        if(key == 'd'){
            cameraRight = true;
        }
    }
    void cameraCalcRelease(){
        if(key == 'w'){
            cameraUp    = false;
        }
        if(key == 's'){
            cameraDown  = false;
        }
        if(key == 'a'){
            cameraLeft  = false;
        }
        if(key == 'd'){
            cameraRight = false;
        }
    }
    void cameraMovement(){
        float moveSpd = 10.0;
        if(cameraUp){
            maps.get(currentMap).relativePos.y -= moveSpd;
        }
        if(cameraDown){
            maps.get(currentMap).relativePos.y += moveSpd;
        }
        if(cameraLeft){
            maps.get(currentMap).relativePos.x -= moveSpd;
        }
        if(cameraRight){
            maps.get(currentMap).relativePos.x += moveSpd;
        }
    }


    class map{
        //## ONLY WORKS IF ...<ArrayList<tile>> allows extended versions and recognises them --> NEEDS TESTING ##
        ArrayList<ArrayList<tile>> mapTiles = new ArrayList<ArrayList<tile>>();     //Contains all tiles, sorted into type
        ArrayList<PVector> mapIndex         = new ArrayList<PVector>();             //Contains the type and number within the type of this specific tile (at this index)

        int[] mapSpec;

        //## MAY NEED ADJUSTING, JUST AN IDEA FOR ORGANISING ENTITIES ##
        //ArrayList<ArrayList<entity>> mapEntities = new ArrayList<ArrayList<entity>>();

        ArrayList<String> tFormatted = new ArrayList<String>();

        int nCol;               //Number of columns and rows for this current map
        int nRow;               //
        int eDepth;             //The amount of edging the map will have (of its respective type, e.g water, walls, sky, etc)
        int nRand;              //Random number used for population probability possibilities
        int tSplit;             //The number of characters in where the text was last split into another line
        int wordEnd;            //The number of characters ago where a word ended

        float tileWidth     = 40.0;     //Width of a single (square) tile

        PVector relativePos = new PVector(0,0);         //Relative position of the camera (centre of screen)
        PVector mapDim      = new PVector(0,0);         //Width and height of board

        map(int[] mapSpecification, int rowNumber, int columnNumber, int edgeDepth){
            mapSpec         = mapSpecification;
            nRow            = rowNumber;
            nCol            = columnNumber;
            eDepth          = edgeDepth;

            mapDim.x        = nCol*tileWidth;
            mapDim.y        = nRow*tileWidth;
            relativePos.x   = mapDim.x /2.0;
            relativePos.y   = mapDim.y /2.0;

            generateMap();
        }

        //########################################
        //## SEPARATE THIS TO BE SOMEWHERE ELSE ##
        //########################################
        void textBox(String dispText, PVector boxPos, PVector boundBox, int tSize, boolean isFilled, PVector boxCol, PVector textCol, boolean symbolised){
            //Draws text in given bounding box, formatted into separate lines
            //dispText  = the text to be written
            //boxPos    = the centre position of the bounding box
            //boundBox  = the dimensions of the bounding box
            //tSize     = the text size
            //isFilled  = whether or not the box should be coloured (filled) or transparent (!filled)
            //boxCol    = the colour of the bounding nox area
            //textCol   = the colour of the text
            //symbolised= whether or not to use default text or symbol text

            //(1)Draw the bounding box in the given colour
            //(2)Split text into lines
            //(3)Draw characters
            //(4)If symbolised, draw in symbols
            //(5)If not, draw in regular characters

            //(1)
            pushStyle();
            rectMode(CENTER);
            noFill();
            //noStroke();           //## OPTIONAL, MAY LOOK BETTER ##
            if(isFilled == true)
            {
                fill( boxCol.x, boxCol.y, boxCol.z );
            }
            rect(boxPos.x, boxPos.y, boundBox.x, boundBox.y);
            popStyle();

            //(2)
            pushStyle();
            tFormatted.clear();
            tSplit  = 0;
            wordEnd = 0;
            for(int i=0; i<dispText.length(); i++)  //Go through all characters in the text...
            {
                wordEnd++;
                if( (( dispText.substring(i, i+1) ).equals(" ")) || (i == dispText.length()-1) )    //If is the end of a word (is a space character)
                {
                    wordEnd = 0;
                }
                if( (( (i-tSplit) *tSize) > (boundBox.x *1.6)) || (i == dispText.length()-1) )    //if this character will result in exceeding the bounding box...
                {
                    tFormatted.add( dispText.substring(tSplit, i+1-wordEnd) );
                    tSplit  = i+1-wordEnd;
                    wordEnd = 0;
                }
            }
            popStyle();

            //(3)
            pushStyle();
            //textMode(CENTER);
            if(symbolised == true)
            {
                //(4)
                //#################
                //NOT AVAILABLE YET
                //#################
            }
            else
            {
                //(5)
                textSize(tSize);
                for(int i=0; i<tFormatted.size(); i++)  //For each line...
                {
                    //Draw that line
                    text( tFormatted.get(i), (boxPos.x - (boundBox.x/2.0)) + (tSize/2.0), (boxPos.y - (boundBox.y/2.0)) + (8.0*tSize/10.0) + (tSize*i) );
                }
                
            }
            popStyle();           

        }
        void display(){
            //Displays the current map, and all the entities present on it
            //(1)Draw the floors for all tiles
            //(2)Draw the content
            //(3)Draw the entities
            for(int i=0; i<mapIndex.size(); i++)   //Go through each tile...
            {
                PVector rPos = convertFromTileInd( i );
                PVector tPos = convertFromRelative( rPos ); //Temporary position
                
                displayFloorContents(tPos, i);
                //displayEntities(tPos, i);
            }
            

        }
        void displayFloorContents(PVector tPos, int tInd){
            //If tile is on screen...
            //###############################################################################################################
            //## MAYBE ADD A SIZE TO TILES, AND MULTIPLY THE "+-tileWidth" BY THAT SIZE SO IT ALWAYS EXTENDS OUT CORRECTLY ##
            //###############################################################################################################
            if( ((tPos.x >= 0 -tileWidth) && (tPos.x <= width +tileWidth))   &&   ((tPos.y >= 0 -tileWidth) && (tPos.y <= height +tileWidth)) )
            {

                //If tile has a floor...
                if( mapTiles.get( int(mapIndex.get(tInd).x) ).get( int(mapIndex.get(tInd).y) ).hasFloor )
                {
                    //Draw the floor
                    mapTiles.get( int(mapIndex.get(tInd).x) ).get( int(mapIndex.get(tInd).y) ).displayFloor(tPos);
                }
                //Draw its main content
                mapTiles.get( int(mapIndex.get(tInd).x) ).get( int(mapIndex.get(tInd).y) ).displayTile(tPos);

            }
        }
        /*
        void displayEntities(PVector tPos, int tInd){
            for(int i=0; i<mapEntities.size(); i++)                 //For all entity types...
            {
                for(int j=0; j<mapEntities.get(tInd).size(); j++)      //For all entities...
                {
                    tPos = convertFromRelative( mapEntities.get(tInd).get(j).pos );
                    //If entity on screen...
                    if( ((tPos.x >= 0 -tileWidth*mapEntities.get(tInd).get(j).size) && (tPos.x <= width +tileWidth*mapEntities.get(tInd).get(j).size))   &&   ((tPos.y >= 0 -tileWidth*mapEntities.get(tInd).get(j).size) && (tPos.y <= height +tileWidth*mapEntities.get(tInd).get(j).size)) )
                    {
                        //Draw entity
                        mapEntities.get(tInd).get(j).display(tPos);
                    }
                }
            }
        }
        */
        PVector convertFromTileInd(int ind){
            //Converts a tile index to a relative position
            //ind = the tile index to be converted to a relative position
            return new PVector( ( ind % nCol )*(tileWidth), ( floor( float(ind)/float(nCol) ) )*(tileWidth));
        }
        PVector convertFromRelative(PVector rPos){
            //Convert a relative position to a screen position
            //rPos = the relative position to be converted
            return new PVector(rPos.x + (width /2.0) - relativePos.x,  rPos.y + (height /2.0) - relativePos.y);
        }
        int convertToTile(PVector rPos){
            //Converts a relative position to a tile position
            return ( floor(rPos.y/tileWidth)*(nCol) + floor(rPos.x/tileWidth) );
        }
        void addTile(tile item, PVector tPlace, int reqType, int mIndex){
            //Adds a tile to a given index, replacing the tile previously there
            //  item    = the NEW tile you want to add to the map
            //  tPlace  = the location of the OLD tile
            //  reqType = the type of the NEW tile
            //  mIndex  = the INDEX of the tile (on the map)
            //(1.1)Remove old tile (at the mapIndex specified / given here) + shifting its values
            //(1.2)Remove old mapIndex
            //(2)Add new mapIndex
            //(3)Add new tile to its required place in mapTiles
            
            removeTile(tPlace, mIndex);                                                     //(1)
            mapIndex.add( mIndex, new PVector(reqType, mapTiles.get(reqType).size()) );     //(2)
            mapTiles.get(reqType).add( item );                                              //(3)
        }
        void removeTile(PVector tPlace, int mIndex){
            //Remove a tile from the mapTiles permenantly, shifting other values down
            //(1)Remove tile (specified at tPlace)
            //(2)Shift mapIndex values down 1 where needed
            //(3)Remove mapIndex for that tile
            mapTiles.get( int(tPlace.x) ).remove( int(tPlace.y) );
            
            //For all tiles of the same type as the one removed...
            for(int i=int(tPlace.y); i<mapTiles.get( int(tPlace.x) ).size(); i++)
            {
                //Shift their mapIndex values down by 1, if > than the tile position (tPlace.y) removed
                mapIndex.get( mapTiles.get( int(tPlace.x) ).get(i).tInd ).y -= 1;
            }

            //Removed after so the index stored by each tile is not incorrect (by being shifted itself before the new tile is added back)
            mapIndex.remove(mIndex);
        }
        int findMouseTile(){
            //Finds the index of the tile that the mouse is hovering
            //###################
            //## LIKELY BROKEN ##
            //###################
            return ( floor((relativePos.x - (width / 2.0) + mouseX)/(tileWidth)) + floor((relativePos.y - (height / 2.0) + mouseY)/(tileWidth))*(nCol) );
        }
        /*
        void spawnEntities(int num){
            //Spawns random enemies across the map
            for(int i=0; i<num; i++)
            {
                //Generate the probability
                nRand = floor( random(0,100) );

                if( (0 <= nRand)&&(nRand < 90) )    //Spawn orc             --> 90%
                {
                    orc newEntity = new orc(new PVector( mapDim.x/2 +random(-10*tileWidth, 10*tileWidth), mapDim.y/2 +random(-10*tileWidth, 10*tileWidth) ), 1);
                    newEntity.createInv();
                    mapEntities.get(0).add( newEntity );
                }
                if( (90 <= nRand)&&(nRand < 100) )    //Spawn sludgeMonster   --> 10%
                {
                    sludgeMonster newEntity = new sludgeMonster(new PVector( mapDim.x +random(-10*tileWidth, 10*tileWidth), mapDim.y +random(-10*tileWidth, 10*tileWidth) ), 3);
                    newEntity.createInv();
                    mapEntities.get(1).add( newEntity );
                }
            }
            
        }
        */
        void generateMap(){
            //Generates the original map
            //(0)Fill mapTiles with spaces for tiles
            //(1)Fill the map with all empty tiles and the default floor for the region
            //(2)Generate a border to the map
            //(3)Generate natural features
            //(4)Generate artifical features
            //(5)Populate with trees and water using an expanding algorithm
            //(6)Fill in (small) gaps in the population (if all surrounded, fill), to make water and trees more natural
            fillMapTiles();
            //fillEntityArray();
            generateFullEmpty();
            generateMapBorder();
            generateNatural();
            generateArtifical();
            populateNatural();
            fillNatural();
            generateFlooring();
            //spawnEntities(1);
        }
        void fillMapTiles(){
            //Add arrayLists to mapTiles equal to the number of tiles in the game, so they can all be stored correctly
            //**NEEDS adjusting when new tile types are added
            for(int i=0; i<GM.s3.tTypeNum; i++)    //For all X tile types...
            {
                //Add a space for the given tile type
                mapTiles.add( new ArrayList<tile>() );
            }
        }
        /*
        void fillEntityArray(){
            for(int i=0; i<enviro.nEntity; i++)    //For all entity types...
            {
                //Add a space for them in the entity arraylist
                mapEntities.add( new ArrayList<entity>() );
            }
        }
        */
        void generateFullEmpty(){
            //Generate a full map of given dimensions that is all empty tiles and default floors (EXCEPT the edge tiles, which will be water)
            //(1)For every tile there should be, add an empty -> ONLY WORKS FOR FRESH MAPS -> DOES NOT CLEAR BEFOREHAND

            //Go through all tiles
            for(int j=0; j<nRow; j++)
            {
                for(int i=0; i<nCol; i++)
                {

                    //Make them all emptys and add them to mapTiles
                    empty newTile = new empty((j*nCol)+i, new PVector(-1, -1, -1), new PVector(0, 0, 0), true, false); //##Interesting note; The tProp here can be anything because emptys are not drawn, so a texture is never atempted to be pulled=> no errors for weird values + no weird textures drawn
                    mapTiles.get(0).add( newTile );
                    mapIndex.add( new PVector(0,(j*nCol) +i ) );

                }
            }
        }
        void generateMapBorder(){
            //##############################################
            //## GENERATE CIRCULAR RADI FOR MAP EDGES TOO ##
            //##############################################
            //################################################################         ***************************************************************
            //## GENERATE INTERIORS, BUT WITH SOME OF THE OUTSIDE SHOWN TOO ##    +    ** The world map idea, showing where each faction is located **
            //################################################################         ***************************************************************

            //Generate the border for the map
            if(mapSpec[0] == 0){    //Nothing
                makeBorderNothing();
            }
            if(mapSpec[0] == 1){    //Water
                makeBorderWater();
            }
            if(mapSpec[0] == 2){    //Interior
                makeBorderInterior();
            }
            if(mapSpec[0] == 3){    //Sky
                makeBorderSky();
            }
            if(mapSpec[0] == 4){    //...
                //...
            }

        }
        void makeBorderNothing(){
            //pass
        }
        void makeBorderWater(){
            for(int i=0; i<nCol; i++)
            {
                for(int j=0; j<nRow; j++)
                {

                    //Make WATER border
                    //#########################################################
                    //## MAKE IT TAKE ON THE FLOOR TYPE FROM ITS PARENT TILE ##
                    //#########################################################
                    //(1)Remove old tile, and its index, here
                    //(2)Add this tile, and its index, here instead                                
                    if( ( ( (floor( ((i*nCol)+j)/(nCol) )) < (eDepth) )||( floor( ((i*nCol)+j)/(nCol) ) >= (nRow-eDepth) ) )   ||   ( ( (((i*nCol)+j) % (nCol)) < (eDepth) )||( (((i*nCol)+j) % (nCol)) >= (nCol-eDepth) ) ) )    //If this tile is on the edge...
                    {
                        //Change this tile to the required tile type
                        //####################################################
                        //## ADD A RANDOMISER TO CHOOSE FROM DIFFERENT SETS ##
                        //####################################################
                        water newTile = new water((i*nCol)+j, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                        addTile(newTile, mapIndex.get( (i*nCol)+j ), 9, (i*nCol)+j);
                    }

                }
            }
        }
        void makeBorderInterior(){
            for(int i=0; i<nCol; i++)
            {
                for(int j=0; j<nRow; j++)
                {

                    //Make WALL border
                    //#########################################################
                    //## MAKE IT TAKE ON THE FLOOR TYPE FROM ITS PARENT TILE ##
                    //#########################################################
                    //(1)Remove old tile, and its index, here
                    //(2)Add this tile, and its index, here instead
                    if( ( ( (floor( ((i*nCol)+j)/(nCol) )) < (eDepth) )||( floor( ((i*nCol)+j)/(nCol) ) >= (nRow-eDepth) ) )   ||   ( ( (((i*nCol)+j) % (nCol)) < (eDepth) )||( (((i*nCol)+j) % (nCol)) >= (nCol-eDepth) ) ) )    //If this tile is on the edge...
                    {
                        //Change this tile to the required tile type
                        wall newTile = new wall((i*nCol)+j, new PVector(0, 1, 0), new PVector(0, 0, 0), false, true);
                        addTile(newTile, mapIndex.get( (i*nCol)+j ), 1, (i*nCol)+j);
                    }

                }
            }
        }
        void makeBorderSky(){
            for(int i=0; i<nCol; i++)
            {
                for(int j=0; j<nRow; j++)
                {

                    //Make CLOUDY border
                    //#########################################################
                    //## MAKE IT TAKE ON THE FLOOR TYPE FROM ITS PARENT TILE ##
                    //#########################################################
                    //pass

                }
            }
        }
        void generateNatural(){
            //Seed the starts of forests and lakes with rare tree and water placements
            if(mapSpec[1] == 0){    //Nothing
                makeNaturalNothing();
            }
            if(mapSpec[1] == 1){    //Forest
                makeNaturalForest();
            }
            if(mapSpec[1] == 2){    //...
                //...
            }

        }
        void makeNaturalNothing(){
            //pass
        }
        void makeNaturalForest(){
            for(int i=0; i<mapIndex.size(); i++)
            {

                //If not an edge piece...
                if( (( floor(i/nCol) >= eDepth )&&( floor(i/nCol) < nRow-eDepth ))   &&   (( (i%nCol) >= eDepth )&&( (i%nCol) < nRow-eDepth )) )
                {
                    //Try to populate it
                    nRand = floor( random(0,100) );


                    //Spawn tree        --> 2%
                    if( (0 <= nRand) && (nRand < 2) )
                    {
                        tree newTile = new tree(i, new PVector(0, 0, 7), new PVector(0, 0, 0), true, true);
                        addTile(newTile, mapIndex.get(i), 8, i);
                    }
                    //Spawn water       --> 1%
                    if( (2 <= nRand) && (nRand < 3) )
                    {
                        water newTile = new water(i, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                        addTile(newTile, mapIndex.get(i), 9, i);
                    }

                }

            }
        }
        void generateArtifical(){
            //############################################################
            //## LIKE CHAIRS FOR GRAND HALLS,   TENTS FOR WOODS,    ETC ##
            //############################################################
            //Generate artificial structures to place into the map
            //(1)Place major structures (e.g port, tradingOutpost, etc)
            //(2)Place minor structures (e.g small huts, houses, etc)
            if(mapSpec[2] == 0){    //Nothing
                makeArtificialNothing();
            }
            if(mapSpec[2] == 1){    //...
                //...
            }

        }
        void makeArtificialNothing(){
            //pass
        }
        void generateFlooring(){
            //Creates that approporiate flooring for tha map
            if(mapSpec[3] == 0){    //Grass
                makeFloorGrass();
            }
            if(mapSpec[3] == 1){    //Tiled
                makeFloorTiled();
            }
            if(mapSpec[3] == 2){    //...
                //...
            }

        }
        void makeFloorGrass(){
            for(int i=0; i<mapIndex.size(); i++)    //Go through all tiles...
            {
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.x = 0;
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.y = 0;
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.z = 0;
            }
        }
        void makeFloorTiled(){
            for(int i=0; i<mapIndex.size(); i++)    //Go through all tiles...
            {
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.x = 0;
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.y = 1;
                mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).fProp.z = 0;
            }
        }
        void populateNatural(){
            //Populate map with lakes and forests by expanding out from seeded trees and water
            for(int i=0; i<mapIndex.size(); i++)   //Check all map tiles...
            {

                //If not edge tiles (SHOULD be unaffected by this process)...       ##MAY CHANGE EVENTUALLY, e.g for cool edge palm trees or something
                if( (( floor(i/nCol) >= eDepth )&&( floor(i/nCol) < nRow-eDepth ))   &&   (( (i%nCol) >= eDepth )&&( (i%nCol) < nRow-eDepth )) )
                {

                    //Create random number for probability          ## CAN MOVE INSIDE THE CURLIES TO SPEED UP MINUTELY ##
                    nRand = floor( random(0,100) );

                    //If tree...
                    if( mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).type == 8 )
                    {
                        //Try to populate
                        if( (0 <= nRand) && (nRand < 55) )  //Grow water        --> 55%
                        {
                            tree newTile1 = new tree(i +1, new PVector(0, 0, 7), new PVector(0, 0, 0), true, true);
                            addTile(newTile1, mapIndex.get(i +1), 8, i +1);
                            tree newTile2 = new tree(i -1, new PVector(0, 0, 7), new PVector(0, 0, 0), true, true);
                            addTile(newTile2, mapIndex.get(i -1), 8, i -1);
                            tree newTile3 = new tree(i +nCol, new PVector(0, 0, 7), new PVector(0, 0, 0), true, true);
                            addTile(newTile3, mapIndex.get(i +nCol), 8, i +nCol);
                            tree newTile4 = new tree(i -nCol, new PVector(0, 0, 7), new PVector(0, 0, 0), true, true);
                            addTile(newTile4, mapIndex.get(i -nCol), 8, i -nCol);
                        }
                    }
                    //If water...
                    if( mapTiles.get( int(mapIndex.get(i).x) ).get( int(mapIndex.get(i).y) ).type == 9 )
                    {
                        //Try to populate
                        if( (0 <= nRand) && (nRand < 55) )  //Grow water        --> 55%
                        {
                            water newTile1 = new water(i +1, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                            addTile(newTile1, mapIndex.get(i +1), 9, i +1);
                            water newTile2 = new water(i -1, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                            addTile(newTile2, mapIndex.get(i -1), 9, i -1);
                            water newTile3 = new water(i +nCol, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                            addTile(newTile3, mapIndex.get(i +nCol), 9, i +nCol);
                            water newTile4 = new water(i -nCol, new PVector(0, 0, 8), new PVector(0, 0, 0), false, true);
                            addTile(newTile4, mapIndex.get(i -nCol), 9, i -nCol);
                        }
                    }
                    //... ##If more natural tiles are added##

                }

            }
        }
        void fillNatural(){
            //Fill in gaps where single tiles are left in lakes or forests
            //pass
        }
        
    }


    class tile{
        boolean hasFloor;       //If this tile has a floor
        boolean hasCollision;   //If you can collide with this tile
        boolean inUse;          //Whether the tile is being used by an entity
        boolean pathChecked = false;

        int type;   //The type of tile this tile is
        int tInd;   //The position of this tile on the map (=> also in the mapIndex list too)
        int tTemp;  //Temporary holder for a tile number
        int pathLast        = -2;

        float runningWeight = 0;

        PVector fProp;   //Type of floor on this tile; Set, Style, Number
        PVector tProp;   //Tyep of tile om this tile;  Set, Style, Type
        PVector screenPos = new PVector(0,0);

        tile(int tileIndex, PVector tileProperties, PVector floorProperties, boolean floorExistsHere, boolean tileHasCollision){
            tInd            = tileIndex;
            tProp           = tileProperties;
            fProp           = floorProperties;
            hasFloor        = floorExistsHere;
            hasCollision    = tileHasCollision;
            type            = int(tProp.z) +1;      //To account for the empty
        }

        void displayFloor(PVector pos){
            //Shared function for all tiles (as floors have no unique qualities)
            //pos = screen position the tile is to be drawn at
            //(1)Convert relative position to a screen position
            //(2)Draw the corresponding floor tile at that location
            //...
            //#####
            //## HAVE A FUNCTION TO CONVERT THE RELATIVE POS (held by the tile) TO SCREEN POS ##
            //#####
            pushStyle();
            imageMode(CENTER);
            image( GM.s3.floorTextures.get( int(fProp.x) ).get( int(fProp.y) ).get( int(fProp.z) ) , pos.x, pos.y);
            popStyle();
        }
        void displayTile(PVector pos){
            //Giga brain
        }
        
    }

    class itemContainer extends tile{
        //pass

        itemContainer(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        //pass
    }

    class fluidContainer extends tile{
        //pass

        fluidContainer(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        //pass
    }

    class empty extends tile{
        //pass

        empty(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            //Has no content, only a floor
        }
    }

    class wall extends tile{
        //pass

        wall(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            if( (tInd + maps.get( currentMap ).nCol) >= maps.get( currentMap ).mapIndex.size() )    //If a bottom of map...
            {
                image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            }
            else
            {
                //If is a hidden piece...
                tTemp = tInd +maps.get(currentMap).nCol;
                if( maps.get( currentMap ).mapTiles.get( int(maps.get( currentMap ).mapIndex.get(tTemp).x) ).get( int(maps.get( currentMap ).mapIndex.get(tTemp).y) ).type == 1 )
                {
                    image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(1) , pos.x, pos.y);
                }
                else    //If is a visible piece...
                {
                    image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
                }
            }
            
            popStyle();
        }
    }

    class barrel extends itemContainer{
        //pass --> PERHAPS 'isOpen' / 'isInUse' FOR OPEN LID ANIMATION

        barrel(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class door extends tile{
        //pass --> PERHAPS 'isOpen'

        door(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class table extends tile{
        //pass  --> Maybe be a contaienr, that displays the items within it on it instead ??? or a NEW VARIANT

        table(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class chair extends tile{
        //pass  --> 'isInUse' / 'occupied'

        chair(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class counter extends tile{
        //pass  --> 'isInUse' / 'occupied'

        counter(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class miscMachine extends tile{
        //pass

        miscMachine(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class tree extends tile{
        //pass  --> 'growthStage'  ---> MAYBE GROWER TYPE ???

        tree(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class water extends tile{
        //pass  --> MAYBE 'fishWithin'

        water(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            //pushStyle();
            //imageMode(CENTER);
            //image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            //popStyle();



            pushStyle();

            imageMode(CENTER);
            if( (tInd - maps.get( currentMap ).nCol) < 0 )    //If a top of map...
            {
                image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            }
            else
            {
                //If water is above you (e.g you are below water, and so extend it with a full tile)
                tTemp = tInd -maps.get(currentMap).nCol;
                if( maps.get( currentMap ).mapTiles.get( int(maps.get( currentMap ).mapIndex.get(tTemp).x) ).get( int(maps.get( currentMap ).mapIndex.get(tTemp).y) ).type == 9 )
                {
                    image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
                }
                else    //If land is above you (e.g you are an embankment)
                {
                    image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(1) , pos.x, pos.y);
                }
            }
            
            popStyle();
        }
    }

    class lrgTree extends tile{
        //pass  --> MAYBE 'growerType'

        lrgTree(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class pump extends fluidContainer{
        //pass

        pump(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class vat extends fluidContainer{
        //pass

        vat(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class machinery extends fluidContainer{
        //pass  --> MAYBE NEED FLUIDMAHCINE AND ITEMMACHINE, OR (more likely) A 'fluidItemConatiner' to hold both -->e.g WATER + BOTTLES = BREW

        machinery(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class field extends tile{
        //pass  --> LIKELY NEEDS A DIFFERENT VARIANT, e.g GROWER?????

        field(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class invisCollider extends tile{
        //########################################################################
        //## LIKELY NOT NEEDED DUE TO HAVING 'empty' WITH 'hasCollision = true' ##
        //########################################################################

        invisCollider(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class fireContained extends tile{
        //pass

        fireContained(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class tradingOutpost extends itemContainer{
        //pass

        tradingOutpost(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

    class port extends tile{
        //pass

        port(int tInd, PVector tProp, PVector fProp, boolean hasFloor, boolean hasCollision){
            super(tInd, tProp, fProp, hasFloor, hasCollision);
        }

        @Override
        void displayTile(PVector pos){
            pushStyle();

            imageMode(CENTER);
            image( GM.s3.tileTextures.get( int(tProp.x) ).get( int(tProp.y) ).get( int(tProp.z) ).get(0) , pos.x, pos.y);
            
            popStyle();
        }
    }

}
