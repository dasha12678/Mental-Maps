//Unexplored 2 Level "Mine" written in Mental Maps DSL.
//Annotated with corresponding rules from Level Template DSL.

level mine{ //name="mine"

    enum Location = [North, East, South, West];
    enum Direction = [North, East, South, West, Northeast, Northwest, Southeast, Southwest];
    enum Size = [tiniest, tiny, small, medium, large];

    site mainSite{ //id="mainSite"
        Location location = North; //direction="north"
        Size size = small; //[small,medium]

        entrance{
            Location location = South; //entranceSouth
        }
        
        environment{ //buildEnvironment
        }

        room thePlace{ //roomIsPlace
            Location location = North; //placeIsNorth
            //isGoal
        }

        path{ //roomIsPath
            Direction direction = South; //pathLeadsSouthAndUp
        }
    }

    site secretSite{ //id="secretSite", parent="mainSite"
        Location location = NorthEast; //direction="northEast"
        Size size = tiniest; //tiniest

        entrance{ 
            Location location = South; //entranceSouth
        }

        //noEnvironment

        room{ //roomIsRoom
        }
    }

connection from mainSite to secretSite in direction North //addConnection(start="mainSite", end="secretSite", direction="North")
connection from secretSite to mainSite in direction SouthEast //addConnection(start="secretSite", end="mainSite", direction="SouthEast")
}
