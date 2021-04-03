import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:mime/mime.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/data_models/super_message.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';

class ChatController extends GetxController {
  List<SuperMessage> chatMessages = [];
  int page = 0;
  int totalPages = 1;
  bool loading = false;
  bool empty = false;
  bool error = false;
  bool loadingMore = false;
  String uploadProgress = '0';
  bool sendingMessage = false;

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType.startsWith('image/');
  }

  bool isVideo(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType.startsWith('video/');
  }

  sendChatMessage(
    String message,
    List<Media> media, {
    @required Function(DataState dataState) uiState,
  }) {
    if (sendingMessage) return;

    sendingMessage = true;

    int id = DateTime.now().millisecondsSinceEpoch;
    List<File> images = [];
    List<File> videos = [];

    images = media
        .where((element) => isImage(element.path))
        .map((e) => File(e.path))
        .toList();

    videos = media
        .where((element) => isVideo(element.path))
        .map((e) => File(e.path))
        .toList();

    LocalMessage localMessage = LocalMessage(
        id: id,
        to: 'management',
        messageText: message,
        seen: false,
        videoFiles: videos,
        uploading: true,
        imagesFiles: images,
        time: id);

    chatMessages.insert(0, localMessage);
    update();
    ApiService().sendMessage(
        message: message,
        media: media,
        onUploadProgress: (progress) {
          uploadProgress = progress;
          update(['upload']);
        },
        state: (dataState) {
          if (dataState is SuccessState) {
            localMessage.uploading = false;
            chatMessages[chatMessages.indexOf(
                    chatMessages.singleWhere((element) => element.id == id))] =
                localMessage;
            sendingMessage = false;
            empty = false;
            update();
            uiState(SuccessState(true));
          } else if (dataState is ErrorState) {
          } else if (dataState is NoConnectionState) {
            CommonMethods().goOffline();
          }
        });
  }

  getChatMessages() {
    if (loading) {
      return;
    }
    if (page < totalPages) {
      page++;
      page == 1 ? loading = true : loadingMore = true;
      update();
      ApiService().getChatMessage(
        page: page,
        state: (dataState) {
          if (dataState is SuccessState) {
            Chat chat = dataState.data as Chat;
            chatMessages.addAll(chat.data
                .map((element) => OnlineMessage(
                    id: element.id,
                    to: element.to,
                    from: element.from,
                    messageText: element.message,
                    seen: element.isReaded,
                    //filter media type in class
                    imagesUrl: element.chatMedia
                        .where((element) => element.mediaType == 'image')
                        .map((e) => e.mediaLink)
                        .toList(),
                    videosUrl: element.chatMedia
                        .where((element) => element.mediaType == 'video')
                        .map((e) => e.mediaLink)
                        .toList(),
                    time: element.unixCreatedAt))
                .toList());
            totalPages = chat.lastPage;
            empty = chatMessages.isEmpty;
            loading = false;
            loadingMore = false;
            update();
          } else if (dataState is ErrorState) {
            loading = false;
            error = true;
            loadingMore = false;
            update();
          } else if (dataState is NoConnectionState) {
            loadingMore = false;
            loading = false;
            update();
            CommonMethods().goOffline();
          }
        },
      );
    }
  }

  void resetVales() {
    page = 0;
    totalPages = 1;
    loading = false;
    error = false;
    loadingMore = false;
    chatMessages.clear();
  }
}
