import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/chat/components/image_viewer.dart';
import 'package:get/get.dart';

class ImagesGrid extends StatelessWidget {
  final List<String> images;

  ImagesGrid({@required this.images});

  @override
  Widget build(BuildContext context) {
    return _imagesGrid();
  }

  _singleImage({
    int index,
  }) =>
      InkWell(
        onTap: () {
          Get.to(() => ImagesViewer(initialIndex: index, images: images));
        },
        child: CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.fill,
          height: 150,
          placeholder: (context, url) => Image.asset(
            'src/images/placeholder.png',
            fit: BoxFit.fill,
            height: 150,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error_outline_sharp,
            color: Colors.red.shade400,
            size: 50,
          ),
        ),
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
                child: Stack(
                  children: [
                    _singleImage(index: 3),
                    InkWell(
                      onTap: () {
                        Get.to(() =>
                            ImagesViewer(initialIndex: 3, images: images));
                      },
                      child: Container(
                        height: 150,
                        color: Colors.black.withOpacity(0.3),
                        child: CustomText(
                          fontSize: 18,
                          color: Colors.white,
                          alignment: AlignmentDirectional.center,
                          text: '${images.length - 3}+',
                        ),
                      ),
                    ),
                  ],
                ),
                flex: 2,
              ),
            ],
          ),
        ],
      );
    }
  }
}
