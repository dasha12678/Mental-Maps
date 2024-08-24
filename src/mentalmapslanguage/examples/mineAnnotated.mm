//Unexplored 2 Level "Mine" written in Mental Maps DSL.
//Annotated with corresponding rules from Level Template DSL.

level mine{ //name="mine"
    //Types
    enum Variant = [a,b];
    enum Theme = [cave, hazards, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
    enum Terrain = [CLOSED, bedrock, sheerDown, someBushes, canyonDown, rareRocks, someRocks, grass, slopeBackUp, forest, cliffDown, VEGETATION, outside, solidRock, NOTLOW, rareBushes, sparseTrees, OPEN, dirt, slopeUp, bushes, HIGH, BUSHES, cave];
    enum LightSetting = [SemiDark, daylight, Dark];
    enum PassageType = [placed];

    enum Location = [North, East, South, West];
    enum Direction = [North, East, South, West, Northeast, Northwest, Southeast, Southwest];
    enum Size = [tiniest, tiny, small, medium, large];

    site mainSite{ //id="mainSite"
        Location location = North; //direction="north"
        Size size = small or medium; //[small,medium]
        Theme themes = [cave, hazards, CAVEHAZARD, openGates, narrowPassages]; 
        Terrain terrainAB = solidRock;
        Terrain terrainC = OPEN;
        Terrain terrainDEF = solidRock;

        entrance{
            Location location = South; //entranceSouth
        }
        
        environment{ //buildEnvironment
        }

        room thePlace{ //roomIsPlace
            Location location = North; //placeIsNorth
            //antechamber; //addAntechamber
            //isGoal;
            lock = NaturalLock; //entranceGateIsNaturalLock
            style = clearing; //clearing
            item = ore; //spawnOre
        }

        path{ //roomIsPath
            Direction direction = [South, Up]; //pathLeadsSouthAndUp
            storyCue = OreHint; //spawnOreHint
        }
    }

    site secretSite{ //id="secretSite", parent="mainSite"
        Location location = NorthEast; //direction="northEast"
        Size size = tiniest; //tiniest

        Theme themes = [cave, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
        Terrain terrain = cave;
        LightSetting lightSettings = SemiDark;
        PassageType passageType = placed;
        Terrain terrainAB = solidRock;
        Terrain terrainC = OPEN;
        Terrain terrainDEF = solidRock;

        entrance{ 
            Location location = South; //entranceSouth
        }

        //noEnvironment

        room{ //roomIsRoom
            style = tunnel; //tunnel
            encounter = hazard; //hazard
        }
    }

connection from mainSite to secretSite in direction North //addConnection(start="mainSite", end="secretSite", direction="North", passageType="placed")
connection from secretSite to mainSite in direction SouthEast //addConnection(start="secretSite", end="mainSite", direction="SouthEast", passageType="placed")
}
