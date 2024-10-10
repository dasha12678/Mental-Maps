typedefs {
    //ENUMS//
    enum TypeOf {site, room, path, entrance, environment};
    enum Size {small, medium, large};
    enum Location {PlaceIsNorth, PlaceIsSouth, PlaceIsEast, PlaceIsWest};
    enum Variant {a, b, c};
    enum Size {shart};

    //COLLECTIONS//
    list[Size] VariantSize;

    //STRUCTS//
    root struct Level {
        str name;
        Place place xor Enemy enemy;
        enum Size {shart};
    };

    struct Room {
        str name;
        Size roomSize;
    };

    struct Place {
        Room room;
        str name;
        str name;
        Size big;
        TypeOf typeOf;
        Structure structure;
    };

    struct Structure {
        VariantSize variantSize;
        opt Location location;
    };
}

Level {
    pirate = kill;
    me = tired;
    name = "mine";
    place {
        me = mine;
        typeOf = site;
        name = "MainSite";
        structure {
            location = me;
            piss = me;
            variantSize = [small, large];
             if (variant == a){
                 location = PlaceIsNoth;
             }
             else{
                 location = PlaceIsNorth;
             }
        }
    }
}
