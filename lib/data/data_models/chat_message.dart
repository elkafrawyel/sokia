class ChatMessage {
  int _id;
  String _from;
  String _to;
  String _message;
  bool _isReaded;
  int _unixCreatedAt;
  int _unixUpdatedAt;
  List<ChatMedia> _chatMedia;

  List<String> _localChatMedia;

  int get id => _id;

  String get from => _from;

  String get to => _to;

  String get message => _message;

  bool get isReaded => _isReaded;

  int get unixCreatedAt => _unixCreatedAt;

  int get unixUpdatedAt => _unixUpdatedAt;

  List<ChatMedia> get chatMedia => _chatMedia;

  List<String> get localChatMedia => _localChatMedia;

  bool uploading=false;

  ChatMessage(
      {int id,
      String from,
      String to,
      String message,
      bool isReaded,
      String image,
      int unixCreatedAt,
      int unixUpdatedAt,
      List<ChatMedia> chatFiles,
      List<String> localChatMedia}) {
    _id = id;
    _from = from;
    _to = to;
    _message = message;
    _isReaded = isReaded;
    _unixCreatedAt = unixCreatedAt;
    _unixUpdatedAt = unixUpdatedAt;
    _chatMedia = chatFiles;
    _localChatMedia = localChatMedia;
  }

  ChatMessage.fromJson(dynamic json) {
    _id = json["id"];
    _from = json["from"];
    _to = json["to"];
    _message = json["message"];
    _isReaded = json["isReaded"];
    _unixCreatedAt = json["unix_created_at"];
    _unixUpdatedAt = json["unix_updated_at"];
    if (json["chat_files"] != null) {
      _chatMedia = [];
      json["chat_files"].forEach((v) {
        _chatMedia.add(ChatMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["from"] = _from;
    map["to"] = _to;
    map["message"] = _message;
    map["isReaded"] = _isReaded;
    map["unix_created_at"] = _unixCreatedAt;
    map["unix_updated_at"] = _unixUpdatedAt;
    if (_chatMedia != null) {
      map["chat_files"] = _chatMedia.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ChatMedia {
  int _id;
  String _mediaName;
  String _mediaLink;
  String _mediaType;
  int _chatId;

  int get id => _id;

  String get mediaName => _mediaName;

  String get mediaLink => _mediaLink;

  String get mediaType => _mediaType;

  int get chatId => _chatId;

  ChatMedia(
      {int id,
      String mediaName,
      String mediaLink,
      String mediaType,
      int chatId,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _mediaName = mediaName;
    _mediaLink = mediaLink;
    _mediaType = mediaType;
    _chatId = chatId;
  }

  ChatMedia.fromJson(dynamic json) {
    _id = json["id"];
    _mediaName = json["mediaName"];
    _mediaLink = json["mediaLink"];
    _mediaType = json["mediaType"];
    _chatId = json["chat_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["mediaName"] = _mediaName;
    map["mediaLink"] = _mediaLink;
    map["mediaType"] = _mediaType;
    map["chat_id"] = _chatId;
    return map;
  }
}
