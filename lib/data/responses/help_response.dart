class HelpResponse {
  bool _status;
  List<HelpModel> _help;

  bool get status => _status;
  List<HelpModel> get data => _help;

  HelpResponse({bool status, List<HelpModel> data}) {
    _status = status;
    _help = data;
  }

  HelpResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _help = [];
      json["data"].forEach((v) {
        _help.add(HelpModel.fromJson(v));
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

class HelpModel {
  int _id;
  String _title;
  String _body;

  int get id => _id;
  String get title => _title;
  String get body => _body;

  HelpModel({int id, String privacyTitle, String privacy}) {
    _id = id;
    _title = privacyTitle;
    _body = privacy;
  }

  HelpModel.fromJson(dynamic json) {
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
