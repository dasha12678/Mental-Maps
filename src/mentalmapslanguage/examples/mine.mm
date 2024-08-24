//Unexplored 2 Level "Mine" written in Mental Maps DSL.

level mine{

    //Types
    enum Variant = [a,b];
    enum Theme = [cave, hazards, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
    enum Terrain = [CLOSED, bedrock, sheerDown, someBushes, canyonDown, rareRocks, someRocks, grass, slopeBackUp, forest, cliffDown, VEGETATION, outside, solidRock, NOTLOW, rareBushes, sparseTrees, OPEN, dirt, slopeUp, bushes, HIGH, BUSHES, cave];
    enum LightSetting =  [SemiDark, daylight, Dark];
    enum PassageType = [placed];

    enum Location = [North, East, South, West];
    enum Direction = [North, East, South, West, Northeast, Northwest, Southeast, Southwest];
    enum Size = [tiniest, tiny, small, medium, large];

    extra{
        type = "Destination";
        civType = "Cave";
        mapIcon = "Cave1";
    }

    site mainSite{ 
        Location location North;
        Size size small;

        extra{
            Theme themes = [cave, hazards, CAVEHAZARD, openGates, narrowPassages]; 
            Terrain terrainAB = solidRock;
            Terrain terrainC = OPEN;
            Terrain terrainDEF = solidRock;
        }

        entrance{
            Location location South; 
        }
        
        environment{ 
        }

        room thePlace{ 
            Location location = North; 
            isGoal;
            antechamber;
            lock NaturalLock; 
            style clearing; 
            item ore; 
        }

        path{ 
            Direction direction South;
            storyElement oreHint; 
        } 
    }

    site SecretSite{ 
        Direction location Northeast; 
        Size size tiny;

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
            Location location South; 
        }

        room{ 
            style tunnel;
            encounter hazard;
        }
    }

connection from MainSite to SecretSite in direction North
connection from SecretSite to MainSite in direction Southeast 
}