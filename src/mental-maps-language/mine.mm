//Unexplored 2 Level Template ""Mine" written in Mental Maps DSL

level template Mine{

    extra{
    type="Destination";
    civType="Cave";
    mapIcon="Cave1";
    }

    site Main Site{ 
        location North; 
        size small or medium; 

        extra{
            themes="cave|hazards|CAVEHAZARD|[CAVEHAZARD]|openGates|narrowPassages";
            terrainAB="solidRock";
            terrainC="OPEN";
            terrainDEF="solidRock";
        }

        entrance{
            location South; 
        }
        
        environment{ 
        }

        room The Place{ 
            location North; 
            isGoal;
            antechamber;
            lock Natural Lock; 
            style clearing; 
            item ore; 
        }

        path Path{ 
            direction South and Up; 
            story cue Ore Hint; 
        }
    }

    site Secret Site{ 
        location NorthEast; 
        size tiniest;

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
            location South; 
        }

        room Room with Tunnel{ 
            style tunnel;
            encounter hazard;
        }
    }

connection from Main Site to Secret Site in direction North 
connection from Secret Site to Main Site in direction SouthEast 
}