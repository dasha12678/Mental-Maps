typedefs {
    //ENUMS//
    enum TypeOf {site, room, path, entrance, environment};
    enum Size {small, medium, large};
    enum Location {North, South, East, West};
    enum Variant {a, b};

    //COLLECTIONS//
    set[Size] VariantSize;

    //STRUCTS//
    root struct Level {
        str name;
        Place place;
    };

    struct Place {
        str name;
        TypeOf typeOf;
        Structure structure;
        Room room;
    };

    struct Room {
        str name;
        TypeOf typeOf;
    };

    struct Structure {
        VariantSize size;
        opt Location location;
    };
}

Level {
    name = "mine";
    place {
        name = "MainSite";
        typeOf = site;
        structure {
            variantSize = {small, big};
            if (variant == a){
                 location = North;
            }
            else{
                 location = South;
            }
        }
        room {
            name = "cave";
            typeOf = room;
        }
    }
}


