//Hypothetical Level "Mine" written in Mental Maps DSL.

level Mine{

    site MainSite{ 
        location North;
        size small;

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