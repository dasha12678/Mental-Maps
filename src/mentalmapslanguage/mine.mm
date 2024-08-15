//Unexplored 2 Level Template ""Mine" written in Mental Maps DSL

level Mine{

    // extra{
    // type="Destination";
    // civType="Cave";
    // mapIcon="Cave1";
    // }

    site MainSite{ 
        location North; 
        size small; //or medium

        // extra{
        //     themes="cave|hazards|CAVEHAZARD|[CAVEHAZARD]|openGates|narrowPassages";
        //     terrainAB="solidRock";
        //     terrainC="OPEN";
        //     terrainDEF="solidRock";
        // }

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
            //storycue oreHint; 
        }
    }

    site Secret Site{ 
        location NorthEast; 
        size tiniest;

        // extra{
        //     themes="cave|openGates|narrowPassages|noOpportunities|noSideTunnels|CAVEHAZARD|[RARECAVEHAZARD]";
        //     terrain="cave";
        //     lightSettings="SemiDark";
        //     passageType="placed";
        //     terrainAB="solidRock";
        //     terrainC="OPEN";
        //     terrainDEF="solidRock";
        // }

        entrance{ 
            location South; 
        }

        room RoomWithTunnel{ 
            style tunnel;
            encounter hazard;
        }
    }

connection from Main Site to Secret Site in direction North 
connection from Secret Site to Main Site in direction SouthEast 
}