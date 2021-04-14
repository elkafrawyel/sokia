import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/chat/components/message_bubble.dart';
import 'package:sokia_app/screens/chat/components/message_bubble_v2.dart';
class MessageListView extends StatefulWidget {
  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  ScrollController _scrollController = ScrollController();
  final chatController = Get.find<ChatController>();

  void scrollerListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange)
      chatController.getChatMessages();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollerListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      dispose: (state) {
        chatController.resetVales();
      },
      builder: (controller) => controller.loading
          ? Center(child: CircularProgressIndicator())
          : controller.empty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 30,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      alignment: AlignmentDirectional.center,
                      text: 'howToHelpYou'.tr,
                      color: Colors.grey.shade500,
                      fontSize: fontSize18,
                    ),
                  ],
                )
              : ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (BuildContext context, int index) {
                    return BubbleChat2(
                      chatMessage: controller.chatMessages[index],
                    );
                  },
                  itemCount: controller.chatMessages.length,
                  reverse: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
    );
  }
}
