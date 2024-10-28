module json::Functions
import List;

    str Level(value parameter){
        return "{<parameter>}";}

    str LevelLevelName(value parameter){
        return "\"levelName\": <parameter>";}

    str LevelDimensions(value parameter){
        return "\"dimensions\": {<parameter>} \n";}

    str LevelTiles(value parameter){
        return "\"tiles\": [<intercalate(",", parameter)>] \n";}

    str LevelEntities(value parameter){
        return "\"entities\": [<intercalate(",", parameter)>] \n";}

    str DimensionsWidth(value parameter){
        return "\"width\": <parameter>";}

    str DimensionsHeight(value parameter){
        return "\"height\": <parameter>";}

    str TileType(value parameter){
        return "\"type\": <parameter>";}

    str TileCount(value parameter){
        return "\"count\": <parameter>";}

    str EntityPlayer(value parameter){
        return "<parameter>";}

    str EntityEnemy(value parameter){
        return "<parameter>";}

    str PlayerProperties(value parameter){
        return "\"properties\": {<parameter>} \n";}

    str PlayerPosition(value parameter){
        return "\"position\": {<parameter>} \n";}

    str EnemyEnemyType(value parameter){
        return "\"enemyType\": <parameter> \n";}

    str EnemyProperties(value parameter){
        return "\"properties\": {<parameter>} \n";}

    str EnemyPosition(value parameter){
        return "\"position\": {<parameter>} \n";}

    str PropertiesHealth(value parameter){
        return "\"health\": <parameter>";}

    str PositionX(value parameter){
        return "\"x\": <parameter>";}

    str PositionY(value parameter){
        return "\"y\": <parameter>";}
