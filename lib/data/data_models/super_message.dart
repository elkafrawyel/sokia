class SuperMessage {
  int id;
  String from, to;
  bool seen;
  int time;
  String messageText;
  List<String> imagesUrl;
  List<String> videosUrl;

  SuperMessage(
      {this.id,
      this.from,
      this.to,
      this.seen,
      this.time,
      this.messageText,
      this.imagesUrl,
      this.videosUrl});
}
