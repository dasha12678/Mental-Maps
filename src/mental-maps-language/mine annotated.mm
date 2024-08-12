//Unexplored 2 Level Template ""Mine" written in Mental Maps DSL
//Annotated with corresponding rules from Level Template DSL

level template Mine{ //name="dest.cave (mine)"

    extra{
    type="Destination";
    civType="Cave";
    mapIcon="Cave1";
    }

    site Main Site{ //id="mainSite"
        location North; //direction="north"
        size small or medium; //[small,medium]

        extra{
            themes="cave|hazards|CAVEHAZARD|[CAVEHAZARD]|openGates|narrowPassages";
            terrainAB="solidRock";
            terrainC="OPEN";
            terrainDEF="solidRock";
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
            lock Natural Lock; //entranceGateIsNaturalLock
            style clearing; //clearing
            item ore; //spawnOre
        }

        path{ //roomIsPath
            direction South and Up; //pathLeadsSouthAndUp
            story cue Ore Hint; //spawnOreHint
        }
    }

    site Secret Site{ //id="secretSite", parent="mainSite"
        location NorthEast; //direction="northEast"
        size tiniest; //tiniest

        extra{
            themes="cave|openGates|narrowPassages|noOpportunities|noSideTunnels|CAVEHAZARD|[RARECAVEHAZARD]";
            terrain="cave";
            lightSettings="SemiDark";
            passageType="placed";
            terrainAB="solidRock";
            terrainC="OPEN";
            terrainDEF="solidRock";
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