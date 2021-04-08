import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/screens/map/map_screen.dart';

class HorizontalList extends StatelessWidget {
  final List<Category> categories;

  HorizontalList({this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsetsDirectional.only(top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.to(() => MapScreen(category: categories[index],));
          },
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width / 3.3,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        // placeholder: placeholder,
                        height: 50,
                        width: 50,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                        imageUrl: categories[index].categoryImage,
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.grey.shade300,
                          size: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        categories[index].categoryName,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
