import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';

class ToMessageView extends StatelessWidget {
  final ChatMessage chatMessage;

  ToMessageView({this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsetsDirectional.only(
                  start: 15, end: 15, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.8),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  bottomStart: Radius.circular(20),
                  topStart: Radius.circular(20),
                ),
              ),
              child: Text(
                chatMessage.message,
                style: Theme.of(context).textTheme.subtitle1.apply(
                      color: Colors.white,
                    ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 8),
                  child: Text(
                    CommonMethods().timeAgoSinceDate(chatMessage.unixCreatedAt),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey),
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: chatMessage.isReaded ? kPrimaryColor : Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
