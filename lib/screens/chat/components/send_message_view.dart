import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/data_states.dart';
import 'package:sokia_app/helper/local_storage.dart';

class SendMessageView extends StatefulWidget {
  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  final TextEditingController controller = TextEditingController();
  var canSendMessage = false;
  final chatController = Get.find<ChatController>();
  var emojiOpened = false;
  var keyboardOpeded = false;
  Timer debouncer;
  FocusNode focusNode = FocusNode();

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 2)}) {
    if (debouncer != null) {
      debouncer.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiOpened = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    debouncer.cancel();
    if (focusNode.hasFocus) {
      focusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
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
                        IconButton(
                            icon: Icon(
                              Icons.insert_emoticon,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              focusNode.unfocus();
                              focusNode.canRequestFocus = false;
                              setState(() {
                                emojiOpened = !emojiOpened;
                              });
                            }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 10, end: 10),
                            child: TextField(
                              focusNode: focusNode,
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
                        Visibility(
                          visible: !canSendMessage,
                          child: LocalStorage().isArabicLanguage()
                              ? SlideInLeft(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _openFiles();
                                    },
                                  ),
                                )
                              : SlideInRight(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _openFiles();
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                canSendMessage
                    ? InkWell(
                        key: UniqueKey(),
                        onTap: () {
                          debounce(() {
                            chatController.sendChatMessage(
                                controller.text.trim(), uiState: (dataState) {
                              if (dataState is SuccessState) {
                                setState(() {
                                  controller.text = '';
                                  canSendMessage = false;
                                });
                              }
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor, shape: BoxShape.circle),
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
                      )
                    : Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                        child: InkWell(
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          ),
                          onLongPress: () {},
                        ),
                      ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          Visibility(
            visible: emojiOpened,
            child: Stack(
              children: [
                EmojiPicker(
                  rows: 4,
                  columns: 7,
                  // buttonMode: Platform.isAndroid
                  //     ? ButtonMode.MATERIAL
                  //     : ButtonMode.CUPERTINO,
                  // // recommendKeywords: ["racing", "horse"],
                  // numRecommended: 10,
                  onEmojiSelected: (emoji, category) {
                    controller.text = controller.text + emoji.emoji;
                    setState(() {
                      canSendMessage = true;
                    });
                  },
                ),
                PositionedDirectional(
                  top: 0,
                  bottom: 0,
                  start: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        child: Icon(
                          Icons.backspace,
                          size: 30,
                          color: Colors.black54,
                        ),
                        onTap: () {
                          controller.text = controller.text
                              .substring(0, controller.text.length - 2);
                          setState(() {
                            if (controller.text.isEmpty) {
                              canSendMessage = false;
                            }
                          });
                        },
                        onLongPress: () {
                          controller.text = '';

                          setState(() {
                            canSendMessage = false;
                          });
                        },
                      ),
                    ),
                  ),
                )
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
    } else if (emojiOpened) {
      setState(() {
        emojiOpened = false;
      });

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
  }

  void _openFiles() async {
    List<Media> res = await ImagesPicker.pick(
      count: 5,
      pickType: PickType.all,
    );
// Media
// .path
// .thumbPath (path for video thumb)
// .size (kb)
  }
}
