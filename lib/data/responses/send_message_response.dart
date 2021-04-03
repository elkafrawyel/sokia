import 'package:sokia_app/data/data_models/chat_message.dart';

class SendMessageResponse {
  bool _status;
  String _message;
  ChatMessage _chatMessage;

  bool get status => _status;

  String get message => _message;

  ChatMessage get chatMessage => _chatMessage;

  SendMessageResponse({bool status, String message, ChatMessage chatMessage}) {
    _status = status;
    _message = message;
    _chatMessage = chatMessage;
  }

  SendMessageResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _chatMessage = json["data"] != null ? ChatMessage.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_chatMessage != null) {
      map["data"] = _chatMessage.toJson();
    }
    return map;
  }
}
