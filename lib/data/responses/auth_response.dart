import 'package:sokia_app/data/data_models/errors.dart';
import 'package:sokia_app/data/data_models/user_model.dart';

class AuthResponse {
  bool _status;
  String _message;
  UserModel _user;
  VErrors _vErrors;

  bool get status => _status;

  String get message => _message;

  UserModel get user => _user;

  VErrors get vErrors => _vErrors;

  AuthResponse(
      {bool status, String message, UserModel userModel, VErrors vErrors}) {
    _status = status;
    _message = message;
    _user = userModel;
    _vErrors = vErrors;
  }

  AuthResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _user = json["data"] != null ? UserModel.fromJson(json["data"]) : null;
    _vErrors =
        json["v_errors"] != null ? VErrors.fromJson(json["v_errors"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_user != null) {
      map["data"] = _user.toJson();
    }
    if (_vErrors != null) {
      map["v_errors"] = _vErrors.toJson();
    }
    return map;
  }
}
