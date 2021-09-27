import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/chat/components/message_bubble.dart';

class MessageListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
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
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (BuildContext context, int index) {
                    return BubbleChat(
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
