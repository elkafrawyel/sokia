import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/map_helper/custom_marker.dart';
import 'package:sokia_app/helper/map_helper/map_api.dart';

import 'main_controller.dart';

class MapController extends GetxController {
  Map<MarkerId, Marker> googleMapMarkers = <MarkerId, Marker>{};
  MarkerId lastSearchMarkerId;
  List<String> selectedMarkersId = [];
  List<CustomMarker> nearByMarkers = [];
  final _mainController = Get.find<MainController>();
  GoogleMapController googleMapController;
  MarkerId lastSelectedMarker;

  @override
  void onInit() async {
    super.onInit();
    _determineUserPosition();
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

    // store user location in main controller to save
    // it in app lifetime and not load it again every time
    Position userPosition = await Geolocator.getCurrentPosition();
    _mainController.userLatLng =
        LatLng(userPosition.latitude, userPosition.longitude);
    print(_mainController.userLatLng);
    update();
  }

  void getNearByPlaces() async {
    if (_mainController.userLatLng != null) {
      nearByMarkers = await MapApi().getNearByPlaces(
          lat: _mainController.userLatLng.latitude.toString(),
          lng: _mainController.userLatLng.longitude.toString());

      _addMarkersToMap();
    }
  }

  refreshMap() {
    selectedMarkersId.clear();
    _addMarkersToMap();
    update();
  }

  void _addMarkersToMap() {
    googleMapMarkers.clear();
    nearByMarkers.forEach((element) {
      Marker nearByMarker = createMarker(element);
      googleMapMarkers.addAll({nearByMarker.markerId: nearByMarker});
    });

    update();
  }

  Marker createMarker(CustomMarker customMarker) {
    final MarkerId markerId = MarkerId(customMarker.placeId);
    return Marker(
      markerId: markerId,
      position: LatLng(
        customMarker.lat,
        customMarker.lng,
      ),
      infoWindow: InfoWindow(
        title: customMarker.name,
        snippet: Platform.isAndroid
            ? customMarker.formattedAddress
            : _multiLineAddress(customMarker.formattedAddress),
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () {
        _highlightMaker(markerId);
      },
    );
  }

  List<FocusedMenuItem> getMenuItems() {
    List<FocusedMenuItem> menuItems = [];

    selectedMarkersId.forEach((element) {
      Marker marker = googleMapMarkers[MarkerId(element)];
      if (marker != null) {
        if (marker.infoWindow != null) {
          menuItems.add(FocusedMenuItem(
              title: Expanded(
                  child: Text(
                marker.infoWindow.title,
                maxLines: 2,
              )),
              trailingIcon: Icon(
                Icons.location_on_outlined,
                color: Colors.grey.shade700,
              ),
              onPressed: () {
                _goTo(marker.position);
                googleMapController.showMarkerInfoWindow(marker.markerId);
              }));
        }
      }
    });

    menuItems.add(FocusedMenuItem(
        title: Text(
          'unSelectAll'.tr,
          style: TextStyle(color: Colors.white),
        ),
        trailingIcon: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        onPressed: () async {
          refreshMap();
          if (await googleMapController
              .isMarkerInfoWindowShown(lastSelectedMarker))
            googleMapController.hideMarkerInfoWindow(lastSelectedMarker);
          _goTo(_mainController.userLatLng);
        }));

    print('selected ${menuItems.length}');
    return menuItems;
  }

  void _goTo(LatLng points) async {
    final CameraPosition _kLocation = CameraPosition(
        bearing: 0,
        target: LatLng(
          points.latitude,
          points.longitude,
        ),
        zoom: 16.0);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }

  void _highlightMaker(MarkerId markerId) {
    // select marker by id
    final Marker marker = googleMapMarkers[markerId];

    if (marker != null) {
      if (selectedMarkersId.contains(marker.markerId.value)) {
        selectedMarkersId.remove(marker.markerId.value);
        // unSelect marker by changing the icon using copyWith() helper method
        final Marker newMarker = marker.copyWith(
          iconParam:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );

        googleMapMarkers.removeWhere((key, value) => key == markerId);
        googleMapMarkers.addAll({newMarker.markerId: newMarker});

        update();
        // zoom in to the selected camera position
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: newMarker.position,
            zoom: 15.0,
          ),
        ));
      } else {
        selectedMarkersId.add(marker.markerId.value);
        // select marker by changing the icon using copyWith() helper method
        final Marker newMarker = marker.copyWith(
          iconParam:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );

        googleMapMarkers.removeWhere((key, value) => key == markerId);
        googleMapMarkers.addAll({newMarker.markerId: newMarker});
        lastSelectedMarker = newMarker.markerId;
        update();
        // zoom in to the selected camera position
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            target: newMarker.position,
            zoom: 19.0,
          ),
        ));
      }
    }
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

  List<Mosque> getSelectedPlacesAsMosques() {
    List<Mosque> list = [];
    int i = 0;
    selectedMarkersId.forEach((element) {
      Marker marker = googleMapMarkers[MarkerId(element)];

      list.add(
        Mosque(
          id: i++,
          mosqueName: marker.infoWindow.title,
          mosqueAdress: marker.infoWindow.snippet,
          mosqueLatitude: marker.position.latitude.toString(),
          mosqueLongitude: marker.position.longitude.toString(),
        ),
      );
    });

    return list;
  }
}
