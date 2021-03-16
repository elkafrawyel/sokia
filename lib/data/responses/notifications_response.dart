class NotificationsResponse {
  bool _status;
  List<NotificationModel> _notifications;

  bool get status => _status;

  List<NotificationModel> get notifications => _notifications;

  NotificationsResponse({bool status, List<NotificationModel> data}) {
    _status = status;
    _notifications = data;
  }

  NotificationsResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _notifications = [];
      json["data"].forEach((v) {
        _notifications.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_notifications != null) {
      map["data"] = _notifications.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NotificationModel {
  int _id;
  String _title;
  String _body;
  String _read;
  String _type;
  String _image;
  int _unixTime;

  int get id => _id;

  String get title => _title == null ? '' : _title;

  String get body => _body == null ? '' : _body;

  String get read => _read;

  String get type => _type;

  String get image => _image;

  int get unixTime => _unixTime;

  NotificationModel(
      {int id,
      String title,
      String body,
      String read,
      String type,
      String image,
      int unixTime}) {
    _id = id;
    _title = title;
    _body = body;
    _read = read;
    _type = type;
    _image = image;
    _unixTime = unixTime;
  }

  NotificationModel.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _body = json["body"];
    _read = json["read"];
    _type = json["type"];
    _image = json["image"];
    _unixTime = json["unixTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["body"] = _body;
    map["read"] = _read;
    map["type"] = _type;
    map["image"] = _image;
    map["unixTime"] = _unixTime;
    return map;
  }
}
