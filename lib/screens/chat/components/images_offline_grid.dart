import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sokia_app/controllers/chat_controller.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';
import 'package:sokia_app/screens/chat/components/images_offline_viewer.dart';

class ImagesOfflineGrid extends StatelessWidget {
  final List<File> images;
  final bool uploading;

  ImagesOfflineGrid({@required this.images, this.uploading});

  @override
  Widget build(BuildContext context) {
    return _imagesGrid();
  }

  _singleImage({
    int index,
  }) =>
      Stack(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => OfflineImagesViewer(
                    initialIndex: index,
                    images: images,
                  ));
            },
            child: Image.file(
              images[index],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(child: _uploadingView()),
        ],
      );

  _imagesGrid() {
    if (images.length == 1) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: _singleImage(index: 0),
          ),
        ],
      );
    } else if (images.length == 2) {
      return Row(
        children: [
          Expanded(
            child: _singleImage(index: 0),
            flex: 2,
          ),
          Expanded(
            child: _singleImage(index: 1),
            flex: 2,
          ),
        ],
      );
    } else if (images.length == 3) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _singleImage(index: 0),
                flex: 2,
              ),
              Expanded(
                child: _singleImage(index: 1),
                flex: 2,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _singleImage(index: 2),
                flex: 4,
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _singleImage(index: 0),
                flex: 2,
              ),
              Expanded(
                child: _singleImage(index: 1),
                flex: 2,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _singleImage(index: 2),
                flex: 2,
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    _singleImage(index: 3),
                    InkWell(
                      onTap: () {
                        Get.to(() => OfflineImagesViewer(
                            initialIndex: 3, images: images));
                      },
                      child: Visibility(
                        visible: images.length > 4,
                        child: Container(
                          height: 200,
                          color: Colors.black.withOpacity(0.3),
                          child: CustomText(
                            fontSize: 18,
                            color: Colors.white,
                            alignment: AlignmentDirectional.center,
                            text: '${images.length - 3}+',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  _uploadingView() {
    // upload placeholder
    return GetBuilder<ChatController>(
      id: 'upload',
      builder: (controller) => Visibility(
        visible: uploading,
        child: Container(
          height: 200,
          width: 200,
          color: Colors.black45,
          child: Center(
            child: CircularPercentIndicator(
              radius: 70.0,
              lineWidth: 5.0,
              percent: 1.0,
              animationDuration: 1000,
              animation: true,
              center: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${controller.uploadProgress} %',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              progressColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
