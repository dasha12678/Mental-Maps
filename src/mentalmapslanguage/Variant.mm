typedefs {
enum TileType {"grass","water"};

enum EnemyType {"slime"};

root struct Level {
   str levelName;
   Dimensions dimensions;
   list[Tile] tiles;
   list[Entity] entities;
};

struct Dimensions {
   int width;
   int height;
};

struct Tile {
   TileType type;
   int count;
};

struct Entity {
   Player player xor Enemy enemy;
};

struct Player {
   Properties properties;
   opt Position position;
};

struct Enemy {
   opt EnemyType enemyType;
   Properties properties;
   opt Position position;
};

struct Properties {
   int health;
};

struct Position {
   int x;
   int y;
};

}


Level {
		levelName = "Mini Level";
	dimensions {
		width = 5;
		height = 5;
}
		tiles = ["",""];
		entities = ["",""];
}