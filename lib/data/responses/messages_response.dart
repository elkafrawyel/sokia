class MessagesResponse {
  bool _status;
  Chat _chat;

  bool get status => _status;

  Chat get chat => _chat;

  MessagesResponse({bool status, Chat chat}) {
    _status = status;
    _chat = chat;
  }

  MessagesResponse.fromJson(dynamic json) {
    _status = json["status"];
    _chat = json["chat"] != null ? Chat.fromJson(json["chat"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_chat != null) {
      map["chat"] = _chat.toJson();
    }
    return map;
  }
}

class Chat {
  int _currentPage;
  List<ChatMessage> _data;
  int _lastPage;

  int get currentPage => _currentPage;

  List<ChatMessage> get data => _data;

  int get lastPage => _lastPage;

  Chat({int currentPage, List<ChatMessage> data, int lastPage}) {
    _currentPage = currentPage;
    _data = data;
    _lastPage = lastPage;
  }

  Chat.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(ChatMessage.fromJson(v));
      });
    }
    _lastPage = json["last_page"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = _currentPage;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["last_page"] = _lastPage;
    return map;
  }
}

class ChatMessage {
  int _id;
  String _from;
  String _to;
  dynamic _message;
  bool _isReaded;
  String _image;
  int _unixCreatedAt;
  int _unixUpdatedAt;

  int get id => _id;

  String get from => _from;

  String get to => _to;

  dynamic get message => _message;

  bool get isReaded => _isReaded;

  String get image => _image;

  int get unixCreatedAt => _unixCreatedAt;

  int get unixUpdatedAt => _unixUpdatedAt;

  ChatMessage(
      {int id,
      String from,
      String to,
      dynamic message,
      bool isReaded,
      String image,
      int unixCreatedAt,
      int unixUpdatedAt}) {
    _id = id;
    _from = from;
    _to = to;
    _message = message;
    _isReaded = isReaded;
    _image = image;
    _unixCreatedAt = unixCreatedAt;
    _unixUpdatedAt = unixUpdatedAt;
  }

  ChatMessage.fromJson(dynamic json) {
    _id = json["id"];
    _from = json["from"];
    _to = json["to"];
    _message = json["message"];
    _isReaded = json["isReaded"];
    _image = json["image"];
    _unixCreatedAt = json["unix_created_at"];
    _unixUpdatedAt = json["unix_updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["from"] = _from;
    map["to"] = _to;
    map["message"] = _message;
    map["isReaded"] = _isReaded;
    map["image"] = _image;
    map["unix_created_at"] = _unixCreatedAt;
    map["unix_updated_at"] = _unixUpdatedAt;
    return map;
  }
}
