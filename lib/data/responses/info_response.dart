import 'package:sokia_app/data/data_models/errors.dart';

class InfoResponse {
  bool _status;
  String _message;
  VErrors _vErrors;

  bool get status => _status;

  String get message => _message;

  VErrors get vErrors => _vErrors;

  InfoResponse({
    bool status,
    String message,
    VErrors vErrors,
  }) {
    _status = status;
    _message = message;
    _vErrors = vErrors;
  }

  InfoResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _vErrors = vErrors;
    _vErrors =
        json["v_errors"] != null ? VErrors.fromJson(json["v_errors"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_vErrors != null) {
      map["v_errors"] = _vErrors.toJson();
    }
    return map;
  }
}
