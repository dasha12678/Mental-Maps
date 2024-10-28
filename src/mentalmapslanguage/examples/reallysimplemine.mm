typedefs {
    //ENUMS//
    enum TypeOf {site, room, path, entrance, environment};
    enum Size {small, medium, large};
    enum Location {PlaceIsNorth, PlaceIsSouth, PlaceIsEast, PlaceIsWest};
    enum Variant {a, b, c};
    enum Size {small};

    //COLLECTIONS//
    list[Size] VariantSize;
    list[int] DifferentSize;

    //STRUCTS//
    root struct Level {
        str name;
        str name;
        Size size;
        Place place xor Enemy enemy;
    };

    struct Room {
        str name;
        Size roomSize;
    };

    struct Place {
        Room room;
        int name;
        str name;
        Enum me;
        Size size;
        Size size;
        TypeOf typeOf;
        Structure structure;
    };

    struct Structure {
        VariantSize variantSize;
        DifferentSize differentSize;
        opt Location location;
    };
}

Level {
    pirate = Jack;
    name = 10.0;
    size = size;
    place {
        me = mine;
        typeOf = castle;
        name = "MainSite";
        structure {
            piss = 10;
            location = PlaceIsNorth;
            variantSize = [small, big];
            differentSize = [1, me];
             if (variant == a){
                 location = North;
             }
             else{
                 location = South;
             }
             if (variant == a){
                location = East;
             }
        }
    }
}
