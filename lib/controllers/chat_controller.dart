import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/data_states.dart';

class ChatController extends GetxController {
  List<ChatMessage> chatMessages = [];
  int page = 0;
  int totalPages = 1;
  bool loading = false;
  bool empty = false;
  bool error = false;
  bool loadingMore = false;

  sendChatMessage(
    String message, {
    @required Function(DataState dataState) uiState,
  }) {
    ApiService().sendMessage(
        message: message,
        state: (dataState) {
          if (dataState is SuccessState) {
            chatMessages.insert(
                0,
                ChatMessage(
                    id: DateTime.now().millisecondsSinceEpoch,
                    from: 'user',
                    to: 'management',
                    message: message,
                    isReaded: false,
                    unixCreatedAt: DateTime.now().millisecondsSinceEpoch));
            empty=false;
            update();
            print(chatMessages.last.message);
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
            chatMessages.addAll(chat.data);
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
