class ConditionsResponse {
  bool _status;
  List<ConditionModel> _help;

  bool get status => _status;
  List<ConditionModel> get data => _help;

  ConditionsResponse({bool status, List<ConditionModel> data}) {
    _status = status;
    _help = data;
  }

  ConditionsResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _help = [];
      json["data"].forEach((v) {
        _help.add(ConditionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_help != null) {
      map["data"] = _help.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ConditionModel {
  int _id;
  String _title;
  String _body;

  int get id => _id;
  String get title => _title;
  String get body => _body;

  ConditionModel({int id, String privacyTitle, String privacy}) {
    _id = id;
    _title = privacyTitle;
    _body = privacy;
  }

  ConditionModel.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["privacyTitle"];
    _body = json["privacy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["privacyTitle"] = _title;
    map["privacy"] = _body;
    return map;
  }
}
