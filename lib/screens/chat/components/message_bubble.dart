import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/messages_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/chat/components/image_viewer.dart';
import 'package:sokia_app/screens/chat/components/images_grid.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class BubbleChat extends StatelessWidget {
  BubbleChat({this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    final _isMe = chatMessage.from == 'user';
    final bg = _isMe
        ? Color.fromRGBO(225, 255, 199, 1)
        : Color.fromRGBO(255, 255, 255, 100);
    final icon = !chatMessage.isReaded ? Icons.done_all : Icons.done;
    final iconColor = !chatMessage.isReaded ? Colors.green : Colors.grey;
    final textColor = _isMe ? Colors.black : Colors.black;
    return Bubble(
      margin: BubbleEdges.only(top: 10),
      alignment:
          _isMe ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
      nipWidth: 8,
      nipHeight: 10,
      radius: Radius.circular(10),
      nip: LocalStorage().isArabicLanguage()
          ? _isMe
              ? BubbleNip.leftTop
              : BubbleNip.rightTop
          : _isMe
              ? BubbleNip.rightTop
              : BubbleNip.leftTop,
      color: bg,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            true
                ? SizedBox()
                : ImagesGrid(images: [
                    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
                  ]),
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 8, end: 12, start: 12),
              child: SelectableLinkify(
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                text: chatMessage.message,
                textAlign: TextAlign.start,
                style: TextStyle(color: textColor, fontSize: 18),
                linkStyle: TextStyle(color: Colors.green),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10),
                  child: Text(
                    CommonMethods()
                        .getDateStringHhMmA(chatMessage.unixCreatedAt),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey.shade600),
                  ),
                ),
                SizedBox(width: 3.0),
                Visibility(
                  visible: _isMe,
                  child: Icon(
                    icon,
                    size: 20.0,
                    color: iconColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
