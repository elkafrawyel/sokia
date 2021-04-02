class UserModel {
  int _id;
  String _image;
  String _name;
  String _email;
  String _apiToken;
  String _firebaseToken;
  String _phone;
  String _approved;
  String _socialType;

  int get id => _id;

  String get image => _image;

  String get name => _name;

  String get email => _email;

  String get apiToken => _apiToken;

  String get phone => _phone;

  bool get approved => _approved == 'yes' ? true : false;


  String get socialType => _socialType;

  UserModel({
    int id,
    String image,
    String name,
    String email,
    String apiToken,
    String firebaseToken,
    String phone,
    String approved,
    String socialType,
  }) {
    _id = id;
    _image = image;
    _name = name;
    _email = email;
    _apiToken = apiToken;
    _firebaseToken = firebaseToken;
    _phone = phone;
    _approved = approved;
    _socialType = socialType;
  }

  UserModel.fromJson(dynamic json) {
    _id = json["id"];
    _image = json["image"];
    _name = json["name"];
    _email = json["email"];
    _apiToken = json["api_token"];
    _firebaseToken = json["firebase_token"];
    _phone = json["phone"];
    _approved = json["approved"];
    _socialType = json["socialType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["image"] = _image;
    map["name"] = _name;
    map["email"] = _email;
    map["api_token"] = _apiToken;
    map["firebase_token"] = _firebaseToken;
    map["phone"] = _phone;
    map["approved"] = _approved;
    map["socialType"] = _socialType;
    return map;
  }
}
