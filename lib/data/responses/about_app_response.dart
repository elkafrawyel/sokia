class AboutAppResponse {
  bool _status;
  AboutApp _aboutApp;

  bool get status => _status;

  AboutApp get data => _aboutApp;

  AboutAppResponse({bool status, AboutApp data}) {
    _status = status;
    _aboutApp = data;
  }

  AboutAppResponse.fromJson(dynamic json) {
    _status = json["status"];
    _aboutApp = json["data"] != null ? AboutApp.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_aboutApp != null) {
      map["data"] = _aboutApp.toJson();
    }
    return map;
  }
}

class AboutApp {
  int _id;
  String _title;
  String _body;

  int get id => _id;

  String get title => _title;

  String get body => _body;

  AboutApp({int id, String privacyTitle, String privacy}) {
    _id = id;
    _title = privacyTitle;
    _body = privacy;
  }

  AboutApp.fromJson(dynamic json) {
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
