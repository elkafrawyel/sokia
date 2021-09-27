import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/data_models/chat_message.dart';
import 'package:sokia_app/data/data_models/super_message.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';

class ChatController extends GetxController {
  List<SuperMessage> chatMessages = [];
  int page = 0;
  int totalPages = 1;
  bool loading = true;
  bool empty = false;
  bool error = false;
  bool loadingMore = false;
  RxBool sending = false.obs;
  Timer timer;
  bool calledByTimer = false;

  ScrollController scrollController = ScrollController();

  @override
  onInit() {
    scrollController.addListener(scrollerListener);
    timer = Timer.periodic(
        Duration(seconds: 3), (Timer t) => getChatMessages(inBackground: true));
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    if (timer != null) timer.cancel();
  }

  void scrollerListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) getChatMessages();
  }

  sendChatMessage(
    String message,
    List<Media> media,
  ) {
    sending.value = true;
    update();
    int id = DateTime.now().millisecondsSinceEpoch;
    ApiService().sendMessage(
        message: message,
        media: media,
        state: (dataState) {
          if (dataState is SuccessState) {
            sending.value = false;
            empty = false;
            update();
          } else if (dataState is ErrorState) {
            chatMessages.removeAt(chatMessages.indexOf(
                chatMessages.singleWhere((element) => element.id == id)));
            error = true;
            update();
          } else if (dataState is NoConnectionState) {
            CommonMethods().goOffline();
          }
        });
  }

  getChatMessages({bool inBackground = false}) {
    if (page < totalPages) {
      if (inBackground) {
        // no need to increase page
        ApiService().getChatMessage(
          page: 1,
          state: (dataState) async {
            handelMessageState(dataState);
          },
        );
      } else {
        page++;
        page == 1 ? loading = true : loadingMore = true;
        update();
        ApiService().getChatMessage(
          page: page,
          state: (dataState) async {
            handelMessageState(dataState);
          },
        );
      }
    }
  }

  void handelMessageState(DataState dataState) {
    if (dataState is SuccessState) {
      Chat chat = dataState.data as Chat;
      chatMessages.insertAll(0, findNewMessages(chat.data));
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
  }

  List<SuperMessage> findNewMessages(List<ChatMessage> data) {
    List<SuperMessage> newMessages = [];
    List<SuperMessage> newList = data
        .map((element) => SuperMessage(
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
        .toList();

    newList.forEach((element) {
      //if message exists
      SuperMessage message = chatMessages
          .firstWhere((e) => e.time == element.time, orElse: () => null);
      if (message == null) {
        newMessages.add(element);
        print(element.messageText);
      }
    });

    print('You have ${newMessages.length} new messages');

    if (newMessages.isNotEmpty &&
        scrollController.hasClients &&
        scrollController.position != null) {
      scrollController.animateTo(
        0.0,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      );
    }
    return newMessages;
  }
}
