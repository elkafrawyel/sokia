import 'package:flutter/material.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:sokia_app/screens/chat/components/messages_list.dart';
import 'package:sokia_app/screens/chat/components/send_message_view.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              child: Image.asset('src/images/chat_logo.png'),
              radius: 15,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "customerService".tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: InkWell(
          //     child: Icon(
          //       Icons.call,
          //       color: Colors.black,
          //     ),
          //     onTap: () {},
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: InkWell(
          //     child: Icon(
          //       Icons.videocam,
          //       color: Colors.black,
          //     ),
          //     onTap: () {},
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: InkWell(
          //     child: Icon(
          //       MdiIcons.dotsVertical,
          //       color: Colors.black,
          //     ),
          //     onTap: () {},
          //   ),
          // )
        ],
        elevation: 2,
        brightness: Brightness.dark,
      ),
      backgroundColor: Color(0xFFECEBEB),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('src/images/chat_bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            GetBuilder<ChatController>(
              builder: (controller) => Expanded(
                child: MessageListView(),
              ),
            ),
            SendMessageView(),
          ],
        ),
      ),
    );
  }
}
