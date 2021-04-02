import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

class ImagesViewer extends StatelessWidget {
  final int initialIndex;
  final List<String> images;

  ImagesViewer({@required this.initialIndex, @required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'customerService'.tr,
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(MdiIcons.download),
            onPressed: () {
              CommonMethods().showToast(message: 'Soon', context: context);
            },
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(MdiIcons.dotsVertical),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: CarouselSlider(
          items: createSliders(),
          options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 1,
            aspectRatio: 1,
            enableInfiniteScroll: images.length > 1,
            initialPage: initialIndex,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: Duration(seconds: 2),
          ),
        ),
      ),
    );
  }

  List<Widget> createSliders() {
    return images
        .map(
          (item) => ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: PhotoView(
              imageProvider: NetworkImage(item),
            ),
          ),
        )
        .toList();
  }
}