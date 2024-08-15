level Mine{

    //Types
    enum Variant = [a,b];
    enum Theme = [cave, hazards, openGates, narrowPassages, noOpportunities, noSideTunnels, CAVEHAZARD, RARECAVEHAZARD];
    enum Terrain = [CLOSED, bedrock, sheerDown, someBushes, canyonDown, rareRocks, someRocks, grass, slopeBackUp, forest, cliffDown, VEGETATION, outside, solidRock, NOTLOW, rareBushes, sparseTrees, OPEN, dirt, slopeUp, bushes, HIGH, BUSHES, cave];
    enum LightSetting =  [SemiDark, daylight, Dark];
    enum PassageType = [placed];

    site MainSite{ 
        location North;
        size small;

        extra{
            Theme themes = [cave, hazards, CAVEHAZARD, openGates, narrowPassages]; 
            Terrain terrainAB = solidRock;
            Terrain terrainC = OPEN;
            Terrain terrainDEF = solidRock;
        }

        entrance{
            location South; 
        }
        
        environment{ 
        }

        room thePlace{ 
            location North; 
            isGoal;
            antechamber;
            lock NaturalLock; 
            style clearing; 
            item ore; 
        }

        path Path{ 
            direction South;
            storyElement oreHint; 
        } 
    }

    site SecretSite{ 
        location Northeast; 
        size tiny;

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
            location South; 
        }

        room RoomWithTunnel{ 
            style tunnel;
            encounter hazard;
        }
    }

connection from MainSite to SecretSite in direction North
connection from SecretSite to MainSite in direction Southeast 
}