class loader{
    gameManager GM;

    int tTypeNum    = 18;   //** Number of tile types, UPDATE when more added

    //Fonts
    //-----
    //Default HLI
    //PFont DefaultHLI; //## LIKELY WONT WORK, CURRENTLY NOT WORKING ##//
    PImage a_DefaultHLI;
    PImage A_DefaultHLI;
    PImage b_DefaultHLI;
    PImage B_DefaultHLI;
    PImage c_DefaultHLI;
    PImage C_DefaultHLI;
    PImage d_DefaultHLI;
    PImage D_DefaultHLI;
    PImage e_DefaultHLI;
    PImage E_DefaultHLI;
    PImage f_DefaultHLI;
    PImage F_DefaultHLI;
    PImage g_DefaultHLI;
    PImage G_DefaultHLI;
    PImage h_DefaultHLI;
    PImage H_DefaultHLI;
    PImage i_DefaultHLI;
    PImage I_DefaultHLI;
    PImage j_DefaultHLI;
    PImage J_DefaultHLI;
    PImage k_DefaultHLI;
    PImage K_DefaultHLI;
    PImage l_DefaultHLI;
    PImage L_DefaultHLI;
    PImage m_DefaultHLI;
    PImage M_DefaultHLI;
    PImage n_DefaultHLI;
    PImage N_DefaultHLI;
    PImage o_DefaultHLI;
    PImage O_DefaultHLI;
    PImage p_DefaultHLI;
    PImage P_DefaultHLI;
    PImage q_DefaultHLI;
    PImage Q_DefaultHLI;
    PImage r_DefaultHLI;
    PImage R_DefaultHLI;
    PImage s_DefaultHLI;
    PImage S_DefaultHLI;
    PImage t_DefaultHLI;
    PImage T_DefaultHLI;
    PImage u_DefaultHLI;
    PImage U_DefaultHLI;
    PImage v_DefaultHLI;
    PImage V_DefaultHLI;
    PImage w_DefaultHLI;
    PImage W_DefaultHLI;
    PImage x_DefaultHLI;
    PImage X_DefaultHLI;
    PImage y_DefaultHLI;
    PImage Y_DefaultHLI;
    PImage z_DefaultHLI;
    PImage Z_DefaultHLI;

    //Misc
    //----
    PImage missingTexture;
    PImage menu1;

    //Entities
    //--------
    PImage userFrontStat1Set1;
    PImage orcFrontStat;
    PImage sludgeMonsterFrontStat;

    //Floors
    //------
    PImage floorMagic_plain_1;
    PImage floorMagic_bricked_1;
    PImage floorMagic_fancy_1;

    PImage floorNatural_plain_0;
    PImage floorNatural_flowered_0;
    PImage floorNatural_stone_0;

    //Tile main
    //---------
    PImage wallMagic_visible_1;
    PImage wallMagic_hidden_1;
    PImage barrelMagic_1;
    PImage doorMagic_e2e4_1;
    PImage doorMagic_e1e3_1;
    PImage tableMagic_single_1;
    PImage chairMagic_single_1;
    //PImage counterMagic_ ... ALL THE Es AND Cs
    //...
    //PImage miscMachine .... SOMETHING SOMETHING
    //...
    PImage tree_single_1;
    PImage water_middle_1;
    PImage water_e1_1;
    PImage lrgTree_single_1;
    PImage pump_single_1;
    PImage vat_single_1;
    PImage machinery_single_1;
    PImage field_middle_1;
    //.... MAYBE AN EDGE PIECE
    PImage fireContained_single_1;
    PImage tradingOutpost_1;
    PImage port_1;

    //Sounds
    //## MAKE THEM LESS MUDDY, MORE CONFIDENCE TO THEM e.g LIKE CUBE WORLD LVL UP SOUND ##//
    SoundFile backgroundMusic1;
    SoundFile traditionalSong1;
    SoundFile footstepsGrass;
    SoundFile buttonSelectionSound;
    SoundFile generalClickSound;
    SoundFile largeEventSound;
    SoundFile smallEventSound;
    SoundFile openInventorySound;
    SoundFile placeTileSound;


    ArrayList<ArrayList<ArrayList<PImage>>> floorTextures              = new ArrayList<ArrayList<ArrayList<PImage>>>();
    ArrayList<ArrayList<ArrayList<ArrayList<PImage>>>> tileTextures    = new ArrayList<ArrayList<ArrayList<ArrayList<PImage>>>>();

    loader(gameManager GMi){
        GM = GMi;
    }

    void setup(){
        //pass
    }
    void draw(){
        //pass
    }

    void loadFonts(){
        //Initialise fonts
        //DefaultHLI = createFont("DefaultHLI.ttf", 32);
        a_DefaultHLI = loadImage("a_DefaultHLI.png");
        A_DefaultHLI = loadImage("Au_DefaultHLI.png");
        b_DefaultHLI = loadImage("b_DefaultHLI.png");
        B_DefaultHLI = loadImage("Bu_DefaultHLI.png");
        c_DefaultHLI = loadImage("c_DefaultHLI.png");
        C_DefaultHLI = loadImage("Cu_DefaultHLI.png");
        d_DefaultHLI = loadImage("d_DefaultHLI.png");
        D_DefaultHLI = loadImage("Du_DefaultHLI.png");
        e_DefaultHLI = loadImage("e_DefaultHLI.png");
        E_DefaultHLI = loadImage("Eu_DefaultHLI.png");
        f_DefaultHLI = loadImage("f_DefaultHLI.png");
        F_DefaultHLI = loadImage("Fu_DefaultHLI.png");
        g_DefaultHLI = loadImage("g_DefaultHLI.png");
        G_DefaultHLI = loadImage("Gu_DefaultHLI.png");;
        h_DefaultHLI = loadImage("h_DefaultHLI.png");
        H_DefaultHLI = loadImage("Hu_DefaultHLI.png");
        i_DefaultHLI = loadImage("i_DefaultHLI.png");
        I_DefaultHLI = loadImage("Iu_DefaultHLI.png");
        j_DefaultHLI = loadImage("j_DefaultHLI.png");
        J_DefaultHLI = loadImage("Ju_DefaultHLI.png");
        k_DefaultHLI = loadImage("k_DefaultHLI.png");
        K_DefaultHLI = loadImage("Ku_DefaultHLI.png");
        l_DefaultHLI = loadImage("l_DefaultHLI.png");
        L_DefaultHLI = loadImage("Lu_DefaultHLI.png");
        m_DefaultHLI = loadImage("m_DefaultHLI.png");
        M_DefaultHLI = loadImage("Mu_DefaultHLI.png");
        n_DefaultHLI = loadImage("n_DefaultHLI.png");
        N_DefaultHLI = loadImage("Nu_DefaultHLI.png");
        o_DefaultHLI = loadImage("o_DefaultHLI.png");
        O_DefaultHLI = loadImage("Ou_DefaultHLI.png");
        p_DefaultHLI = loadImage("p_DefaultHLI.png");
        P_DefaultHLI = loadImage("Pu_DefaultHLI.png");
        q_DefaultHLI = loadImage("q_DefaultHLI.png");
        Q_DefaultHLI = loadImage("Qu_DefaultHLI.png");
        r_DefaultHLI = loadImage("r_DefaultHLI.png");
        R_DefaultHLI = loadImage("Ru_DefaultHLI.png");
        s_DefaultHLI = loadImage("s_DefaultHLI.png");
        S_DefaultHLI = loadImage("Su_DefaultHLI.png");
        t_DefaultHLI = loadImage("t_DefaultHLI.png");
        T_DefaultHLI = loadImage("Tu_DefaultHLI.png");
        u_DefaultHLI = loadImage("u_DefaultHLI.png");
        U_DefaultHLI = loadImage("Uu_DefaultHLI.png");
        v_DefaultHLI = loadImage("v_DefaultHLI.png");
        V_DefaultHLI = loadImage("Vu_DefaultHLI.png");
        w_DefaultHLI = loadImage("w_DefaultHLI.png");
        W_DefaultHLI = loadImage("Wu_DefaultHLI.png");
        x_DefaultHLI = loadImage("x_DefaultHLI.png");
        X_DefaultHLI = loadImage("Xu_DefaultHLI.png");
        y_DefaultHLI = loadImage("y_DefaultHLI.png");
        Y_DefaultHLI = loadImage("Yu_DefaultHLI.png");
        z_DefaultHLI = loadImage("z_DefaultHLI.png");
        Z_DefaultHLI = loadImage("Zu_DefaultHLI.png");
    }
    void loadTextures(){
        //Misc
        missingTexture          = loadImage("missingTexture.png");
        menu1                   = loadImage("menu1.png");

        //Entities
        userFrontStat1Set1      = loadImage("lowRes_userFront_stationaryAnim_set1_1.png"  );
        orcFrontStat            = loadImage("orc_front_stationary.png");
        sludgeMonsterFrontStat  = loadImage("sludgeMonster_Front_Stationary.png");

        //Floor
        floorMagic_plain_1      = loadImage("floorMagic_plain.png");
        floorMagic_bricked_1    = loadImage("floorMagic_bricked.png");
        floorMagic_fancy_1      = loadImage("floorMagic_fancy.png");

        floorNatural_plain_0    = loadImage("floorNatural_plain.png");
        floorNatural_flowered_0 = loadImage("floorNatural_flowered.png");
        floorNatural_stone_0    = loadImage("floorNatural_stone.png");

        //Tiles
        wallMagic_hidden_1      = loadImage("wallMagic_vertical_hidden.png");
        wallMagic_visible_1     = loadImage("wallMagic_Middle.png");
        barrelMagic_1           = loadImage("barrelMagic_plain.png");
        doorMagic_e2e4_1        = loadImage("doorMagic_plain.png");
        doorMagic_e1e3_1        = loadImage("doorMagic_plain_sideway.png");
        tableMagic_single_1     = loadImage("tableMagic_plain.png");
        chairMagic_single_1     = loadImage("stoolMagic_plain.png");
        //counterMagic_ ... ALL THE Es AND Cs
        //...
        //miscMachine .... SOMETHING SOMETHING
        //...
        tree_single_1           = loadImage("tree.png");
        water_middle_1          = loadImage("water_center.png");
        water_e1_1              = loadImage("water_front.png");
        lrgTree_single_1        = loadImage("lrgTree.png");
        pump_single_1           = loadImage("pump.png");
        vat_single_1            = loadImage("vat.png");
        machinery_single_1      = loadImage("machinery.png");
        field_middle_1          = loadImage("field.png");
        //.... MAYBE AN EDGE PIECE
        fireContained_single_1  = loadImage("fireContained.png");
        tradingOutpost_1        = loadImage("tradingOutpost.png");
        port_1                  = loadImage("port.png");

        //Texture Sets
        //------------
        //(1)Setup lists
        //(2)Place textures into lists

        //xxxxxxxxx
        //x FLOOR x
        //xxxxxxxxx
        //--ALTS--
        floorTextures.add( new ArrayList<ArrayList<PImage>>() );
        floorTextures.add( new ArrayList<ArrayList<PImage>>() );
        floorTextures.add( new ArrayList<ArrayList<PImage>>() );
        //... ## IF YOU HAVE ALTERNATE TEXTURES, ADD ANOTHER SET ##

        //--STYLE--
        for(int i=0; i<floorTextures.size(); i++)                    //For each alternate set...
        {
            floorTextures.get(i).add( new ArrayList<PImage>() );     //Add empty groups for each style (e.g natural, magic, etc)
            floorTextures.get(i).add( new ArrayList<PImage>() );
        }

        //--TEXTURES--
        //Set0- Style0-
        floorTextures.get(0).get(0).add(floorNatural_plain_0);
        //...
        // "" - Style1-
        floorTextures.get(0).get(1).add(floorMagic_plain_1);
        //...

        //Set1- Style0-
        floorTextures.get(1).get(0).add(floorNatural_flowered_0);
        //...
        // "" - Style1-
        floorTextures.get(1).get(1).add(floorMagic_bricked_1);
        //...

        //Set2- Style0-
        floorTextures.get(2).get(0).add(floorNatural_stone_0);
        //...
        // "" - Style1-
        floorTextures.get(2).get(1).add(floorMagic_fancy_1);
        //...




        //xxxxxxxxx
        //x TILES x
        //xxxxxxxxx
        //--ALTS--
        tileTextures.add( new ArrayList<ArrayList<ArrayList<PImage>>>() );
        //... ## IF YOU HAVE ALTERNATE TEXTURES, ADD ANOTHER SET ##

        //--STYLE--
        for(int i=0; i<tileTextures.size(); i++)                               //For each alternate set...
        {
            tileTextures.get(i).add( new ArrayList<ArrayList<PImage>>() );     //Add empty groups for each style (e.g natural, magic, etc)
            tileTextures.get(i).add( new ArrayList<ArrayList<PImage>>() );
        }

        //--TYPES--
        for(int i=0; i<tileTextures.size(); i++)                //For each alternate set...
        {
            for(int j=0; j<tileTextures.get(i).size(); j++)     //For each style in those sets...
            {
                for(int z=0; z<tTypeNum; z++)                   //For each tile type in those styles in those sets...
                {
                    //Add a space for the textures of that type
                    tileTextures.get(i).get(j).add( new ArrayList<PImage>() );
                }  
            }
        }

        //--TEXTURES--
        //Set0- Style0- Type...
        tileTextures.get(0).get(0).get(0).add(missingTexture);tileTextures.get(0).get(0).get(0).add(missingTexture);
        tileTextures.get(0).get(0).get(1).add(missingTexture);
        tileTextures.get(0).get(0).get(2).add(missingTexture);tileTextures.get(0).get(0).get(2).add(missingTexture);
        tileTextures.get(0).get(0).get(3).add(missingTexture);
        tileTextures.get(0).get(0).get(4).add(missingTexture);
        tileTextures.get(0).get(0).get(5).add(missingTexture);   //#### NEEDS TO BE COUNTER, FIGURE IT OUT, 15 TEXTURES ISH ####
        tileTextures.get(0).get(0).get(6).add(missingTexture);   //#### FIGURE IT OUT, MISC MACHINE IMAGE ??? ####
        tileTextures.get(0).get(0).get(7).add(tree_single_1);
        tileTextures.get(0).get(0).get(8).add(water_middle_1);tileTextures.get(0).get(0).get(8).add(water_e1_1);
        tileTextures.get(0).get(0).get(9).add(lrgTree_single_1);
        tileTextures.get(0).get(0).get(10).add(missingTexture);
        tileTextures.get(0).get(0).get(11).add(missingTexture);
        tileTextures.get(0).get(0).get(12).add(missingTexture);
        tileTextures.get(0).get(0).get(13).add(field_middle_1);
        tileTextures.get(0).get(0).get(14).add(missingTexture);  //#### SHOULD BE INVIS COLLIDER, NOT REALLY NEEDED NOW #####
        tileTextures.get(0).get(0).get(15).add(missingTexture);
        tileTextures.get(0).get(0).get(16).add(missingTexture);
        tileTextures.get(0).get(0).get(17).add(missingTexture);
        //Set0- Style1- Type...
        tileTextures.get(0).get(1).get(0).add(wallMagic_visible_1);tileTextures.get(0).get(1).get(0).add(wallMagic_hidden_1);
        tileTextures.get(0).get(1).get(1).add(barrelMagic_1);
        tileTextures.get(0).get(1).get(2).add(doorMagic_e2e4_1);tileTextures.get(0).get(1).get(2).add(doorMagic_e1e3_1);
        tileTextures.get(0).get(1).get(3).add(tableMagic_single_1);
        tileTextures.get(0).get(1).get(4).add(chairMagic_single_1);
        tileTextures.get(0).get(1).get(5).add(barrelMagic_1);   //#### NEEDS TO BE COUNTER, FIGURE IT OUT, 15 TEXTURES ISH ####
        tileTextures.get(0).get(1).get(6).add(barrelMagic_1);   //#### FIGURE IT OUT, MISC MACHINE IMAGE ??? ####
        tileTextures.get(0).get(1).get(7).add(missingTexture);
        tileTextures.get(0).get(1).get(8).add(missingTexture);tileTextures.get(0).get(1).get(8).add(missingTexture);
        tileTextures.get(0).get(1).get(9).add(missingTexture);
        tileTextures.get(0).get(1).get(10).add(pump_single_1);
        tileTextures.get(0).get(1).get(11).add(vat_single_1);
        tileTextures.get(0).get(1).get(12).add(machinery_single_1);
        tileTextures.get(0).get(1).get(13).add(missingTexture);
        tileTextures.get(0).get(1).get(14).add(barrelMagic_1);  //#### SHOULD BE INVIS COLLIDER, NOT REALLY NEEDED NOW #####
        tileTextures.get(0).get(1).get(15).add(fireContained_single_1);
        tileTextures.get(0).get(1).get(16).add(tradingOutpost_1);
        tileTextures.get(0).get(1).get(17).add(port_1);
        //...
    }
    void loadSound(){
        /*
        backgroundMusic_1    = new SoundFile(this, "backgroundMusic1.wav");
        traditionalSong_1    = new SoundFile(this, "traditionalSong1.wav");
        footstepsGrass       = new SoundFile(this, "footstepsGrass.wav");
        buttonSelectionSound = new SoundFile(this, "buttonSelectionSound.wav");
        generalClickSound    = new SoundFile(this, "generalClickSound.wav");
        largeEventSound      = new SoundFile(this, "largeEventSound.wav");
        smallEventSound      = new SoundFile(this, "smallEventSound.wav");
        openInventorySound   = new SoundFile(this, "openInventorySound.wav");
        placeTileSound       = new SoundFile(this, "placeTileSound.wav");
        */
    }

    void mousePressed(){}
    void mouseReleased(){}
    void keyPressed(){}
    void keyReleased(){}
}