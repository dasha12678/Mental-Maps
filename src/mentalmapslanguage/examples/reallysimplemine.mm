typedefs {
    //ENUMS//
    enum TypeOf {site, room, path, entrance, environment};
    enum Size {small, medium, large};
    enum Location {PlaceIsNorth, PlaceIsSouth, PlaceIsEast, PlaceIsWest};
    enum Variant {a, b, c};
    enum Size {small};

    //COLLECTIONS//
    list[Size] VariantSize;

    //STRUCTS//
    root struct Level {
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
        str name;
        str name;
        Enum me;
        Size size;
        Size size;
        TypeOf typeOf;
        Structure structure;
    };

    struct Structure {
        VariantSize variantSize;
        opt Location location;
    };
}

Level {
    pirate = Jack;
    name = "mine";
    size = size;
    place {
        me = mine;
        typeOf = castle;
        name = "MainSite";
        structure {
            piss = me;
            location = "PlaceIsNorth";
            variantSize = [small, big];
             if (variant == a){
                 location = PlaceIsNorth;
             }
             else{
                 location = PlaceIsNorth;
             }
        }
    }
}
