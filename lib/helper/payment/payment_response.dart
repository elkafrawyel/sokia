/// result : {"code":"200.300.404","description":"invalid or missing parameter","parameterErrors":[{"name":"amount","value":"92.0","message":"must match ^[0-9]{1,12}(\\.[0-9]{2})?$"}]}
/// buildNumber : "a49e48548e0ab89218c7c80cbe0b3b509c6f33be@2021-03-18 14:51:39 +0000"
/// timestamp : "2021-03-20 21:22:38+0000"
/// ndc : "C4ACFF1E0AED5627FD61D065639A0FE6.uat01-vm-tx03"

class PaymentResponse {
  Result _result;
  String _buildNumber;
  String _timestamp;
  String _ndc;
  String _id;

  Result get result => _result;

  String get buildNumber => _buildNumber;

  String get timestamp => _timestamp;

  String get ndc => _ndc;

  String get id => _id;

  PaymentResponse({
    Result result,
    String buildNumber,
    String timestamp,
    String ndc,
    String id,
  }) {
    _result = result;
    _buildNumber = buildNumber;
    _timestamp = timestamp;
    _ndc = ndc;
    _id = id;
  }

  PaymentResponse.fromJson(dynamic json) {
    _result = json["result"] != null ? Result.fromJson(json["result"]) : null;
    _buildNumber = json["buildNumber"];
    _timestamp = json["timestamp"];
    _ndc = json["ndc"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_result != null) {
      map["result"] = _result.toJson();
    }
    map["buildNumber"] = _buildNumber;
    map["timestamp"] = _timestamp;
    map["ndc"] = _ndc;
    map["id"] = _id;
    return map;
  }
}

/// code : "200.300.404"
/// description : "invalid or missing parameter"
/// parameterErrors : [{"name":"amount","value":"92.0","message":"must match ^[0-9]{1,12}(\\.[0-9]{2})?$"}]

class Result {
  String _code;
  String _description;
  List<ParameterErrors> _parameterErrors;

  String get code => _code;

  String get description => _description;

  List<ParameterErrors> get parameterErrors => _parameterErrors;

  Result(
      {String code,
      String description,
      List<ParameterErrors> parameterErrors}) {
    _code = code;
    _description = description;
    _parameterErrors = parameterErrors;
  }

  Result.fromJson(dynamic json) {
    _code = json["code"];
    _description = json["description"];
    if (json["parameterErrors"] != null) {
      _parameterErrors = [];
      json["parameterErrors"].forEach((v) {
        _parameterErrors.add(ParameterErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["description"] = _description;
    if (_parameterErrors != null) {
      map["parameterErrors"] = _parameterErrors.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "amount"
/// value : "92.0"
/// message : "must match ^[0-9]{1,12}(\\.[0-9]{2})?$"

class ParameterErrors {
  String _name;
  String _value;
  String _message;

  String get name => _name;

  String get value => _value;

  String get message => _message;

  ParameterErrors({String name, String value, String message}) {
    _name = name;
    _value = value;
    _message = message;
  }

  ParameterErrors.fromJson(dynamic json) {
    _name = json["name"];
    _value = json["value"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["value"] = _value;
    map["message"] = _message;
    return map;
  }
}
