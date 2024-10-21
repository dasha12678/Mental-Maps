module mentalmapslanguage::Variant

enum Size {["small","medium","large"]};

enum Location {["North","South","East","West"]};

root struct Level {
   str name;
   Place place;
}

struct Place {
   str name;
   Structure structure;
};

struct Structure {
   Size size;
   opt Location location;
};



  name = "mine";
  place {
  name = "MainSite";
  structure {
  location = North;
  size = small;
;
};
;
};
