import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/data_models/search_model.dart';

import 'suggestion_item.dart';

class Suggestions {
  Widget getSuggestions({List<SearchModel> searchModel}) {
    List<Widget> views = [];

    views.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'suggestions'.tr,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );

    views.addAll(searchModel
        .map((element) => SuggestionItem(searchModel: element))
        .toList());

    views.add(
      SizedBox(
        height: 20,
      ),
    );
    return Column(
      children: views,
    );
  }
}
