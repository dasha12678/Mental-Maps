//Hypothetical Level Template ""Mine" written in Mental Maps DS

level template Mine{

    site Main Site{ 
        location North; 
        size small or medium; 

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