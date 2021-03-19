import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sokia_app/controllers/map_controller.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/screens/map/markers.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  // final _mapController = Get.put(MapController());
  final _searchController = FloatingSearchBarController();
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<String> selectedMarkersId = [];
  BitmapDescriptor selectedIcon;
  BitmapDescriptor unSelectedIcon;
  LatLng _userLatLng;
  LatLng _myLatLang = LatLng(30.949780185265226, 31.184251479085507);

  @override
  void initState() {
    super.initState();
    _drawMapMarkers();
    _determineUserPosition();
  }

  _drawMapMarkers() async {
    // selectedIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(
    //       size: Platform.isAndroid ? Size(25, 25) : Size(20, 20),
    //     ),
    //     'src/images/location.png');
    //
    // unSelectedIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(
    //       size: Platform.isAndroid ? Size(25, 25) : Size(20, 20),
    //     ),
    //     'src/images/location_.png');

    selectedIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    unSelectedIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    _addMarkers();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  _determineUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position userPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _userLatLng = LatLng(userPosition.latitude, userPosition.longitude);
      print(_userLatLng);
    });
  }

  void _addMarkers() {
    for (int i = 0; i < Markers().locations.length; i++) {
      String id = 'markerId$i';
      final MarkerId markerId = MarkerId(id);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          Markers().locations[i].lat,
          Markers().locations[i].lng,
        ),
        infoWindow: InfoWindow(
          title: Markers().locations[i].title,
          snippet: Platform.isAndroid
              ? Markers().locations[i].address
              : _multiLineAddress(Markers().locations[i].address),
        ),
        icon: unSelectedIcon,
        onTap: () {
          _highlightMaker(markerId);
        },
      );
      setState(() {
        markers[markerId] = marker;
      });
    }
  }

  void _highlightMaker(MarkerId markerId) {
    // select marker by id
    final Marker marker = markers[markerId];

    if (marker != null) {
      if (selectedMarkersId.contains(marker.markerId.value)) {
        setState(() {
          CommonMethods().showToast(message: 'unSelected', context: context);
          selectedMarkersId.remove(marker.markerId.value);
          // unSelect marker by changing the icon using copyWith() helper method
          final Marker newMarker = marker.copyWith(
            iconParam: unSelectedIcon,
          );

          markers[markerId] = newMarker;

          // zoom in to the selected camera position
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: newMarker.position,
              zoom: 15.0,
            ),
          ));
        });
      } else {
        setState(() {
          CommonMethods().showToast(message: 'selected', context: context);
          selectedMarkersId.add(marker.markerId.value);
          // select marker by changing the icon using copyWith() helper method
          final Marker newMarker = marker.copyWith(
            iconParam: selectedIcon,
          );

          markers[markerId] = newMarker;

          // zoom in to the selected camera position
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: newMarker.position,
              zoom: 15.0,
            ),
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildMap(),
          buildBottomNavigationBar(),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildMap() {
    return _userLatLng == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: Platform.isAndroid ? _userLatLng : _myLatLang,
                zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _onMapCreated(controller);
            },
            myLocationButtonEnabled: true,
            onLongPress: (latLng) {
              print('You Tabbed long on : $latLng');
            },
            onTap: (latLng) {
              print('You Tabbed  on : $latLng');
            },
            markers: Set<Marker>.of(markers.values),
            zoomControlsEnabled: false,
          );
  }

  void _goTo(LatLng points) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition _kLocation = CameraPosition(
        bearing: 0,
        target: LatLng(
          points.latitude,
          points.longitude,
        ),
        zoom: 12.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    // zoom in to the selected camera position
    if (_userLatLng != null) _goTo(_userLatLng);
  }

  Widget buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 20, start: 10, end: 10),
      alignment: AlignmentDirectional.bottomCenter,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: 50,
              child: CustomButton(
                text: 'تأكيد مكان الاستلام',
                colorText: Colors.white,
                fontSize: fontSize14,
                colorBackground: kPrimaryColor,
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 5,
              child: Container(
                height: 50,
                child: CustomButton(
                  text: 'عنوان مخصص',
                  colorText: Colors.white,
                  fontSize: fontSize14,
                  colorBackground: kPrimaryColor,
                  onPressed: () {},
                ),
              )),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Markers().locations.map((location) {
                return _searchResultItem(location);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _searchResultItem(MyLocation location) {
    return GestureDetector(
      onTap: () {
        print('You select ${location.title}');
        _searchController.close();
        //go to the chosen location and show mark on map
      },
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.place,
              size: 30,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 10, start: 10, end: 10),
                    child: CustomText(
                      text: location.title,
                      fontSize: fontSize18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomText(
                      text: location.address,
                      fontSize: fontSize14,
                      maxLines: 3,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() async {
    super.dispose();
    (await _controller.future).dispose();
  }

  String _multiLineAddress(String address) {
    String newStr = '';
    int step = 35;
    for (int i = 0; i < address.length; i += step) {
      newStr += address.substring(i, math.min(i + step, address.length));
      if (i + step < address.length) newStr += '\n';
    }
    print(newStr);
    return newStr;
  }
}
