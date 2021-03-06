import 'package:get/get.dart';

class HomeResponse {
  bool _status;
  String _message;
  List<Category> _categories;
  List<Mosque> _mosques;
  List<Occasions> _occasions;

  bool get status => _status;

  String get message => _message;

  List<Category> get categories => _categories;

  List<Mosque> get mosques => _mosques;

  List<Occasions> get occasions => _occasions;

  HomeResponse(
      {bool status,
      String message,
      List<Category> categories,
      List<Mosque> mosques,
      List<Occasions> occasions}) {
    _status = status;
    _message = message;
    _categories = categories;
    _mosques = mosques;
    _occasions = occasions;
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
    if (json["occasions"] != null) {
      _occasions = [];
      json["occasions"].forEach((v) {
        _occasions.add(Occasions.fromJson(v));
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
    if (_occasions != null) {
      map["occasions"] = _occasions.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Occasions {
  int _id;
  String _occasionName;
  String _occasionImage;
  String _occasionAdress;
  bool _availableFastShipping;
  bool _occasionOpen;
  String _occasionLongitude;
  String _occasionLatitude;
  String _createdAt;
  String _updatedAt;

  int get id => _id;

  String get occasionName => _occasionName;

  String get occasionImage => _occasionImage;

  String get occasionAdress =>
      _occasionAdress == null ? 'noAddress'.tr : _occasionAdress;

  String get fastShipping => _availableFastShipping
      ? 'availableFastShipping'.tr
      : 'notAvailableFastShipping'.tr;

  bool get occasionOpen => _occasionOpen;

  bool get availableFastShipping => _availableFastShipping;

  String get status => _occasionOpen ? 'opened'.tr : 'closed'.tr;

  String get occasionLongitude => _occasionLongitude;

  String get occasionLatitude => _occasionLatitude;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  Occasions(
      {int id,
      String occasionName,
      String occasionImage,
      String occasionAdress,
      bool availableFastShipping,
      bool occasionOpen,
      String occasionLongitude,
      String occasionLatitude,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _occasionName = occasionName;
    _occasionImage = occasionImage;
    _occasionAdress = occasionAdress;
    _availableFastShipping = availableFastShipping;
    _occasionOpen = occasionOpen;
    _occasionLongitude = occasionLongitude;
    _occasionLatitude = occasionLatitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Occasions.fromJson(dynamic json) {
    _id = json["id"];
    _occasionName = json["occasionName"];
    _occasionImage = json["occasionImage"];
    _occasionAdress = json["occasionAdress"];
    _availableFastShipping = json["availableFastShipping"];
    _occasionOpen = json["occasionOpen"];
    _occasionLongitude = json["occasionLongitude"];
    _occasionLatitude = json["occasionLatitude"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["occasionName"] = _occasionName;
    map["occasionImage"] = _occasionImage;
    map["occasionAdress"] = _occasionAdress;
    map["availableFastShipping"] = _availableFastShipping;
    map["occasionOpen"] = _occasionOpen;
    map["occasionLongitude"] = _occasionLongitude;
    map["occasionLatitude"] = _occasionLatitude;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
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
  var _categoryPrice;
  String _note;

  int get id => _id;

  String get categoryName => _categoryName;

  String get categoryImage => _categoryImage;

  double get categoryPrice => double.parse(_categoryPrice.toString());

  String get note => _note == null ? '' : _note;

  Category({
    int id,
    String categoryName,
    String categoryImage,
    var categoryPrice,
    String note,
  }) {
    _id = id;
    _categoryName = categoryName;
    _categoryImage = categoryImage;
    _categoryPrice = categoryPrice;
    _note = note;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _categoryName = json["categoryName"];
    _categoryImage = json["categoryImage"];
    _categoryPrice = json["categoryPrice"];
    _note = json["note"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["categoryName"] = _categoryName;
    map["categoryImage"] = _categoryImage;
    map["categoryPrice"] = _categoryPrice;
    map["note"] = _note;
    return map;
  }
}
