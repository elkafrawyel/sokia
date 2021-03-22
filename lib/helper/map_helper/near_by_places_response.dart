class NearByPlacesResponse {
  List<Results> _results;
  String _status;

  List<Results> get results => _results;

  String get status => _status;

  NearByPlacesResponse({List<Results> results, String status}) {
    _results = results;
    _status = status;
  }

  NearByPlacesResponse.fromJson(dynamic json) {
    if (json["results"] != null) {
      _results = [];
      json["results"].forEach((v) {
        _results.add(Results.fromJson(v));
      });
    }
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_results != null) {
      map["results"] = _results.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    return map;
  }
}

class Results {
  Geometry _geometry;
  String _name;
  String _placeId;
  //like formatted address
  String _vicinity;

  Geometry get geometry => _geometry;

  String get name => _name;

  String get placeId => _placeId;

  String get vicinity => _vicinity;

  Results(
      {String businessStatus,
      Geometry geometry,
      String name,
      String placeId,
      String vicinity}) {
    _geometry = geometry;
    _name = name;
    _placeId = placeId;
    _vicinity = vicinity;
  }

  Results.fromJson(dynamic json) {
    _geometry =
        json["geometry"] != null ? Geometry.fromJson(json["geometry"]) : null;
    _name = json["name"];
    _placeId = json["place_id"];
    _vicinity = json["vicinity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if (_geometry != null) {
      map["geometry"] = _geometry.toJson();
    }
    map["name"] = _name;
    map["place_id"] = _placeId;
    map["vicinity"] = _vicinity;
    return map;
  }
}

class Geometry {
  Location _location;
  Viewport _viewport;

  Location get location => _location;

  Viewport get viewport => _viewport;

  Geometry({Location location, Viewport viewport}) {
    _location = location;
    _viewport = viewport;
  }

  Geometry.fromJson(dynamic json) {
    _location =
        json["location"] != null ? Location.fromJson(json["location"]) : null;
    _viewport =
        json["viewport"] != null ? Viewport.fromJson(json["viewport"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_location != null) {
      map["location"] = _location.toJson();
    }
    if (_viewport != null) {
      map["viewport"] = _viewport.toJson();
    }
    return map;
  }
}

/// northeast : {"lat":30.9503881802915,"lng":31.18582483029151}
/// southwest : {"lat":30.9476902197085,"lng":31.18312686970851}

class Viewport {
  Northeast _northeast;
  Southwest _southwest;

  Northeast get northeast => _northeast;

  Southwest get southwest => _southwest;

  Viewport({Northeast northeast, Southwest southwest}) {
    _northeast = northeast;
    _southwest = southwest;
  }

  Viewport.fromJson(dynamic json) {
    _northeast = json["northeast"] != null
        ? Northeast.fromJson(json["northeast"])
        : null;
    _southwest = json["southwest"] != null
        ? Southwest.fromJson(json["southwest"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_northeast != null) {
      map["northeast"] = _northeast.toJson();
    }
    if (_southwest != null) {
      map["southwest"] = _southwest.toJson();
    }
    return map;
  }
}

/// lat : 30.9476902197085
/// lng : 31.18312686970851

class Southwest {
  double _lat;
  double _lng;

  double get lat => _lat;

  double get lng => _lng;

  Southwest({double lat, double lng}) {
    _lat = lat;
    _lng = lng;
  }

  Southwest.fromJson(dynamic json) {
    _lat = json["lat"];
    _lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = _lat;
    map["lng"] = _lng;
    return map;
  }
}

/// lat : 30.9503881802915
/// lng : 31.18582483029151

class Northeast {
  double _lat;
  double _lng;

  double get lat => _lat;

  double get lng => _lng;

  Northeast({double lat, double lng}) {
    _lat = lat;
    _lng = lng;
  }

  Northeast.fromJson(dynamic json) {
    _lat = json["lat"];
    _lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = _lat;
    map["lng"] = _lng;
    return map;
  }
}

/// lat : 30.9490488
/// lng : 31.1845113

class Location {
  double _lat;
  double _lng;

  double get lat => _lat;

  double get lng => _lng;

  Location({double lat, double lng}) {
    _lat = lat;
    _lng = lng;
  }

  Location.fromJson(dynamic json) {
    _lat = json["lat"];
    _lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = _lat;
    map["lng"] = _lng;
    return map;
  }
}
