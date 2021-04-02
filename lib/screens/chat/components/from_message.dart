import 'package:flutter/material.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';

class FromMessageView extends StatelessWidget {
  final ChatMessage chatMessage;

  FromMessageView({this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 20),
          child: CircleAvatar(
            child: Image.asset('src/images/chat_logo.png'),
            radius: 15,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsetsDirectional.only(
                  start: 15, end: 15, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20),
                  topEnd: Radius.circular(20),
                  bottomEnd: Radius.circular(20),
                ),
              ),
              child: Text(
                chatMessage.message,
                style: Theme.of(context).textTheme.subtitle1.apply(
                      color: Colors.black87,
                    ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 5),
                  child: Text(
                    'Sokia Team',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 5),
                  child: Text(
                    CommonMethods().timeAgoSinceDate(chatMessage.unixCreatedAt),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
