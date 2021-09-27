import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/local_storage.dart';

class SendMessageView extends StatefulWidget {
  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  final TextEditingController controller = TextEditingController();
  var canSendMessage = false;
  final chatController = Get.find<ChatController>();
  var keyboardOpeded = false;
  Timer debouncer;

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 2)}) {
    if (debouncer != null) {
      debouncer.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  void dispose() {
    super.dispose();
    if (debouncer != null) debouncer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 10, end: 10),
                            child: TextField(
                              minLines: 1,
                              maxLines: 8,
                              controller: controller,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    value.trim().isNotEmpty) {
                                  setState(() {
                                    canSendMessage = true;
                                  });
                                } else {
                                  setState(() {
                                    canSendMessage = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "writeMessage".tr,
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !canSendMessage,
                          child: LocalStorage().isArabicLanguage()
                              ? SlideInLeft(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _openCamera();
                                    },
                                  ),
                                )
                              : SlideInRight(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _openCamera();
                                    },
                                  ),
                                ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _selectImages();
                            // _openBottomSheet();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  key: UniqueKey(),
                  onTap: !canSendMessage
                      ? null
                      : () {
                          String messageText = controller.text.isEmpty
                              ? null
                              : controller.text.trim();
                          setState(() {
                            controller.text = '';
                            canSendMessage = false;
                          });
                          _sendMessage(
                            text: messageText,
                            media: [],
                          );
                        },
                  child: Container(
                    decoration: BoxDecoration(
                        color: canSendMessage ? kPrimaryColor : Colors.grey,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Directionality(
                        textDirection: LocalStorage().isArabicLanguage()
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    if (keyboardOpeded) {
      Get.back();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _openCamera() async {
    List<Media> media = await ImagesPicker.openCamera(
      pickType: PickType.all,
      maxTime: 15, // record video max time
    );

    _sendMessage(
      text: controller.text.isEmpty ? null : controller.text.trim(),
      media: media,
    );
    setState(() {
      controller.text = '';
      canSendMessage = false;
    });
  }

  /* void _selectVideo() async {
    List<Media> media = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.video,
    );

    _sendMessage(
      text: controller.text.isEmpty ? null : controller.text.trim(),
      media: media,
    );
    setState(() {
      controller.text = '';
      canSendMessage = false;
    });
  }
 */
  void _selectImages() async {
    List<Media> media = await ImagesPicker.pick(
      count: 10,
      pickType: PickType.image,
    );

    _sendMessage(
      text: controller.text.isEmpty ? null : controller.text.trim(),
      media: media,
    );
    setState(() {
      controller.text = '';
      canSendMessage = false;
    });
  }

  void _sendMessage({String text, List<Media> media}) {
    debounce(() {
      chatController.sendChatMessage(text, media);
    });
  }
}
