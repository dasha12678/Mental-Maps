//Unexplored 2 Level Template ""Mine" written in Mental Maps DSL
//Annotated with corresponding rules from Level Template DSL

//Types
enum Variant = [a,b];
enum Theme = [cave, hazards, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
enum Terrain = [CLOSED, bedrock, sheerDown, someBushes, canyonDown, rareRocks, someRocks, grass, slopeBackUp, forest, cliffDown, VEGETATION, outside, solidRock, NOTLOW, rareBushes, sparseTrees, OPEN, dirt, slopeUp, bushes, HIGH, BUSHES, cave];
enum LightSetting =  [SemiDark, daylight, Dark];
enum PassageType = [placed];

//parameter - Level scope
//str type;
//str civType;
//str mapIcon; 

level mine{ //name="mine"

    //extra{
    //type="Destination";
    //civType="Cave";
    //mapIcon="Cave1";
    //}

    site mainSite{ //id="mainSite"
        location North; //direction="north"
        size small or medium; //[small,medium]

        extra{
            Theme themes = [cave, hazards, CAVEHAZARD, openGates, narrowPassages]; 
            Terrain terrainAB = solidRock;
            Terrain terrainC = OPEN;
            Terrain terrainDEF = solidRock;
        }

        entrance{
            location South; //entranceSouth
        }
        
        environment{ //buildEnvironment
        }

        room The Place{ //roomIsPlace
            location North; //placeIsNorth
            antechamber; //addAntechamber
            isGoal;
            lock NaturalLock; //entranceGateIsNaturalLock
            style clearing; //clearing
            item ore; //spawnOre
        }

        path{ //roomIsPath
            direction South and Up; //pathLeadsSouthAndUp
            story cue Ore Hint; //spawnOreHint
        }
    }

    site secretSite{ //id="secretSite", parent="mainSite"
        location NorthEast; //direction="northEast"
        size tiniest; //tiniest

        extra{
            Theme themes = [cave, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
            Terrain terrain = cave;
            LightSetting lightSettings = SemiDark;
            PassageType passageType = placed;
            Terrain terrainAB = solidRock;
            Terrain terrainC = OPEN;
            Terrain terrainDEF = solidRock;
        }

        entrance{ 
            location South; //entranceSouth
        }

        //noEnvironment

        room Room with Tunnel{ //roomIsRoom
            style tunnel //tunnel
            encounter hazard //hazard
        }
    }

connection from Main Site to Secret Site in direction North //addConnection(start="mainSite", end="secretSite", direction="North", passageType="placed")
connection from Secret Site to Main Site in direction SouthEast //addConnection(start="secretSite", end="mainSite", direction="SouthEast", passageType="placed")
}

//Varianting to be added at a later stage