import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:get/get.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/map_helper/map_api.dart';
import 'package:sokia_app/helper/map_helper/search_place_model.dart';

class PlacesSearchView extends StatefulWidget {
  final Function(String placeId) onPlaceSelected;

  @override
  _PlacesSearchViewState createState() => _PlacesSearchViewState();

  PlacesSearchView({@required this.onPlaceSelected});
}

class _PlacesSearchViewState extends State<PlacesSearchView> {
  List<SearchPlaceModel> places = [];
  Timer debouncer;
  final _searchController = FloatingSearchBarController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'search'.tr,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      clearQueryOnClose: false,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        if (query.isNotEmpty) {
          setState(() {
            loading = true;
          });
          debounce(() async {
            print('search input : $query');
            places = await MapApi().searchForPlaces(query);
            setState(() {
              loading = false;
            });
          });
        } else {
          places.clear();
          setState(() {
            loading = false;
          });
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      controller: _searchController,
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: loading
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          text: 'searching'.tr,
                          fontSize: fontSize14,
                          color: Colors.grey.shade700,
                        )
                      ],
                    ),
                  ))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: places.map((placeModel) {
                      return _searchResultItem(placeModel);
                    }).toList(),
                  ),
          ),
        );
      },
    );
  }

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 1)}) {
    if (debouncer != null) {
      debouncer.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Widget _searchResultItem(SearchPlaceModel placeModel) {
    return GestureDetector(
      onTap: () {
        print('You select ${placeModel.placeDescription}');
        widget.onPlaceSelected(placeModel.placeId);
        _searchController.close();
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.place_outlined,
                color: Colors.grey.shade500,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    CustomText(
                      text: placeModel.placeDescription,
                      fontSize: fontSize14,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
