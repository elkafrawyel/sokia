class StaticData {
  bool _status;
  String _message;
  StaticDataModel _data;

  bool get status => _status;
  String get message => _message;
  StaticDataModel get data => _data;

  StaticData({
      bool status, 
      String message, 
      StaticDataModel data}){
    _status = status;
    _message = message;
    _data = data;
}

  StaticData.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? StaticDataModel.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

class StaticDataModel {
  int _id;
  int _shipping;
  int _fee;

  int get id => _id;
  int get shipping => _shipping;
  int get fee => _fee;

  StaticDataModel({
      int id, 
      int shipping, 
      int fee}){
    _id = id;
    _shipping = shipping;
    _fee = fee;
}

  StaticDataModel.fromJson(dynamic json) {
    _id = json["id"];
    _shipping = json["shipping"];
    _fee = json["fee"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["shipping"] = _shipping;
    map["fee"] = _fee;
    return map;
  }

}