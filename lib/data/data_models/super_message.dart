import 'dart:io';

class SuperMessage {
  int id;
  String from, to;
  bool seen;
  int time;
  String messageText;
}

class OnlineMessage extends SuperMessage {
  List<String> imagesUrl;
  List<String> videosUrl;

  OnlineMessage({
    int id,
    String from,
    String to,
    bool seen,
    int time,
    String messageText,
    List<String> imagesUrl,
    List<String> videosUrl,
  }) {
    this.id = id;
    this.from = from;
    this.to = to;
    this.seen = seen;
    this.time = time;
    this.messageText = messageText;
    this.imagesUrl = imagesUrl;
    this.videosUrl = videosUrl;
  }
}

class LocalMessage extends SuperMessage {
  List<File> imagesFiles;
  List<File> videosFiles;
  bool uploading;
  LocalMessage({
    int id,
    String from,
    String to,
    bool seen,
    bool uploading,
    int time,
    String messageText,
    List<File> imagesFiles,
    List<File> videoFiles,
  }) {
    this.id = id;
    this.from = from;
    this.to = to;
    this.seen = seen;
    this.uploading = uploading;
    this.time = time;
    this.messageText = messageText;
    this.imagesFiles = imagesFiles;
    this.videosFiles = videoFiles;
  }
}
