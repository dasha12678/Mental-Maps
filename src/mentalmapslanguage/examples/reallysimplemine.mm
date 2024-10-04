typedefs {
    //ENUMS//
    enum TypeOf {site, room, path, entrance, environment};
    enum Size {small, medium, large};
    enum Location {PlaceIsNorth, PlaceIsSouth, PlaceIsEast, PlaceIsWest};
    enum Variant {a, b, c};

    //COLLECTIONS//
    list[Size] VariantSize;

    //STRUCTS//
    root struct level {
        str name;
        Place place xor Enemy enemy;
    }

    struct Place{
        str name;
        TypeOf typeOf;
        Structure structure;
    }

    struct Structure{  
        VariantSize variantSize;
        opt Location location;
    }
}

level {
    name = "mine";
    place{
        typeOf = site;
        name = "MainSite";
        structure{
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
