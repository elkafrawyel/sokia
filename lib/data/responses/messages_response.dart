import 'package:sokia_app/data/data_models/chat_message.dart';

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

