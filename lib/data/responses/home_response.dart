import 'package:get/get.dart';

class HomeResponse {
  bool _status;
  String _message;
  List<Category> _categories;
  List<Mosque> _mosques;

  bool get status => _status;

  String get message => _message;

  List<Category> get categories => _categories;

  List<Mosque> get mosques => _mosques;

  HomeResponse(
      {bool status,
      String message,
      List<Category> categories,
      List<Mosque> mosques}) {
    _status = status;
    _message = message;
    _categories = categories;
    _mosques = mosques;
  }

  HomeResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    if (json["categories"] != null) {
      _categories = [];
      json["categories"].forEach((v) {
        _categories.add(Category.fromJson(v));
      });
    }
    if (json["mosques"] != null) {
      _mosques = [];
      json["mosques"].forEach((v) {
        _mosques.add(Mosque.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_categories != null) {
      map["categories"] = _categories.map((v) => v.toJson()).toList();
    }
    if (_mosques != null) {
      map["mosques"] = _mosques.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Mosque {
  int _id;
  String _mosqueName;
  String _mosqueImage;
  String _mosqueAdress;
  bool _availableFastShipping;
  bool _mosqueOpen;
  String _mosqueLongitude;
  String _mosqueLatitude;

  int get id => _id;

  String get mosqueName => _mosqueName;

  String get mosqueImage => _mosqueImage;

  String get mosqueAdress =>
      _mosqueAdress == null ? 'noAddress'.tr : _mosqueAdress;

  bool get availableFastShipping => _availableFastShipping;

  bool get mosqueOpen => _mosqueOpen;

  String get mosqueLongitude => _mosqueLongitude;

  String get mosqueLatitude => _mosqueLatitude;

  String get status => _mosqueOpen ? 'opened'.tr : 'closed'.tr;

  String get fastShipping => _availableFastShipping
      ? 'availableFastShipping'.tr
      : 'notAvailableFastShipping'.tr;

  Mosque(
      {int id,
      String mosqueName,
      String mosqueImage,
      String mosqueAdress,
      bool availableFastShipping,
      bool mosqueOpen,
      String mosqueLongitude,
      String mosqueLatitude}) {
    _id = id;
    _mosqueName = mosqueName;
    _mosqueImage = mosqueImage;
    _mosqueAdress = mosqueAdress;
    _availableFastShipping = availableFastShipping;
    _mosqueOpen = mosqueOpen;
    _mosqueLongitude = mosqueLongitude;
    _mosqueLatitude = mosqueLatitude;
  }

  Mosque.fromJson(dynamic json) {
    _id = json["id"];
    _mosqueName = json["mosqueName"];
    _mosqueImage = json["mosqueImage"];
    _mosqueAdress = json["mosqueAdress"];
    _availableFastShipping = json["availableFastShipping"];
    _mosqueOpen = json["mosqueOpen"];
    _mosqueLongitude = json["mosqueLongitude"];
    _mosqueLatitude = json["mosqueLatitude"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["mosqueName"] = _mosqueName;
    map["mosqueImage"] = _mosqueImage;
    map["mosqueAdress"] = _mosqueAdress;
    map["availableFastShipping"] = _availableFastShipping;
    map["mosqueOpen"] = _mosqueOpen;
    map["mosqueLongitude"] = _mosqueLongitude;
    map["mosqueLatitude"] = _mosqueLatitude;
    return map;
  }
}

class Category {
  int _id;
  String _categoryName;
  String _categoryImage;

  int get id => _id;

  String get categoryName => _categoryName;

  String get categoryImage => _categoryImage;

  Category({int id, String categoryName, String categoryImage}) {
    _id = id;
    _categoryName = categoryName;
    _categoryImage = categoryImage;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _categoryName = json["categoryName"];
    _categoryImage = json["categoryImage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["categoryName"] = _categoryName;
    map["categoryImage"] = _categoryImage;
    return map;
  }
}
