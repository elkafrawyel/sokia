import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/home_response.dart';

import 'suggestion_item.dart';

class Suggestions {
  Widget getSuggestions({List<Mosque> mosques}) {
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

    views.addAll(mosques
        .map(
          (element) => SuggestionItem(mosque: element),
        )
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
