typedefs {
    //ENUMS//
    enum Size {small, medium, large};
    enum Location {North, South, East, West};

    //STRUCTS//
    root struct Level {
        str name;
        Place place;
    };

    struct Place {
        str name;
        Structure structure;
    };

    struct Structure {
        Size size;
        opt Location location;
    };
}

Level {
    name = "mine";
    size = medium;
    place {
        name = "MainSite";
        structure {
            location = North;
            size = small;
        }
    }
}
