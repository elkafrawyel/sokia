class AutoCompleteResponse {
  List<Predictions> _predictions;
  String _status;

  List<Predictions> get predictions => _predictions;

  String get status => _status;

  AutoCompleteResponse({List<Predictions> predictions, String status}) {
    _predictions = predictions;
    _status = status;
  }

  AutoCompleteResponse.fromJson(dynamic json) {
    if (json["predictions"] != null) {
      _predictions = [];
      json["predictions"].forEach((v) {
        _predictions.add(Predictions.fromJson(v));
      });
    }
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_predictions != null) {
      map["predictions"] = _predictions.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    return map;
  }
}

class Predictions {
  String _description;
  String _placeId;
  String _reference;

  String get description => _description;

  String get placeId => _placeId;

  String get reference => _reference;

  Predictions({
    String description,
    String placeId,
    String reference,
  }) {
    _description = description;
    _placeId = placeId;
    _reference = reference;
  }

  Predictions.fromJson(dynamic json) {
    _description = json["description"];
    _placeId = json["place_id"];
    _reference = json["reference"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = _description;
    map["place_id"] = _placeId;
    map["reference"] = _reference;
    return map;
  }
}
