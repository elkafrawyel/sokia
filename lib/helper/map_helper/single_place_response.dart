class SinglePlaceResponse {
  Result _result;
  String _status;

  Result get result => _result;
  String get status => _status;

  SinglePlaceResponse({
      Result result, 
      String status}){
    _result = result;
    _status = status;
}

  SinglePlaceResponse.fromJson(dynamic json) {
    _result = json["result"] != null ? Result.fromJson(json["result"]) : null;
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_result != null) {
      map["result"] = _result.toJson();
    }
    map["status"] = _status;
    return map;
  }

}

class Result {
  String _formattedAddress;
  Geometry _geometry;
  String _name;
  String _placeId;

  String get formattedAddress => _formattedAddress;
  Geometry get geometry => _geometry;
  String get name => _name;
  String get placeId => _placeId;

  Result({
      String formattedAddress, 
      Geometry geometry, 
      String name, 
      String placeId}){
    _formattedAddress = formattedAddress;
    _geometry = geometry;
    _name = name;
    _placeId = placeId;
}

  Result.fromJson(dynamic json) {
    _formattedAddress = json["formatted_address"];
    _geometry = json["geometry"] != null ? Geometry.fromJson(json["geometry"]) : null;
    _name = json["name"];
    _placeId = json["place_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["formatted_address"] = _formattedAddress;
    if (_geometry != null) {
      map["geometry"] = _geometry.toJson();
    }
    map["name"] = _name;
    map["place_id"] = _placeId;
    return map;
  }

}

/// location : {"lat":-33.866489,"lng":151.1958561}

class Geometry {
  Location _location;

  Location get location => _location;

  Geometry({
      Location location}){
    _location = location;
}

  Geometry.fromJson(dynamic json) {
    _location = json["location"] != null ? Location.fromJson(json["location"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_location != null) {
      map["location"] = _location.toJson();
    }
    return map;
  }

}

/// lat : -33.866489
/// lng : 151.1958561

class Location {
  double _lat;
  double _lng;

  double get lat => _lat;
  double get lng => _lng;

  Location({
      double lat, 
      double lng}){
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