import 'dart:async';
import 'dart:io';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/controllers/create_order_controller.dart';
import 'package:sokia_app/controllers/main_controller.dart';
import 'package:sokia_app/controllers/map_controller.dart';
import 'package:sokia_app/data/responses/home_response.dart';
import 'package:sokia_app/helper/CommonMethods.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/helper/custom_widgets/text/custom_text.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/helper/map_helper/custom_marker.dart';
import 'package:sokia_app/helper/map_helper/map_api.dart';
import 'package:sokia_app/screens/create_order/create_order_screen.dart';
import 'package:sokia_app/screens/map/places_search_view.dart';

class MapScreen extends StatefulWidget {
  final Category category;

  MapScreen({this.category});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mainController = Get.find<MainController>();
  final _mapController = Get.put(MapController());
  GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildMap(),
          buildBottomNavigationBar(),
          _myLocationIcon(),
          _openSelectedPlaces(),
          PlacesSearchView(onPlaceSelected: _drawSearchPlace),
        ],
      ),
    );
  }

  Widget buildMap() {
    return GetBuilder<MapController>(
      dispose: (state) {
        _mapController.refreshMap();
      },
      builder: (controller) => _mainController.userLatLng == null
          ? Container(
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomText(
                      text: 'findingYou'.tr,
                      alignment: AlignmentDirectional.center,
                      fontSize: fontSize18,
                    ),
                  )
                ],
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  // target: _userLatLng ,
                  target: _mainController.userLatLng,
                  zoom: 19),
              onMapCreated: (GoogleMapController controller) {
                _onMapCreated(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onLongPress: (latLng) {
                print('You Tabbed long on : $latLng');
              },
              onTap: (latLng) {
                print('You Tabbed  on : $latLng');
              },
              markers: Set<Marker>.of(_mapController.googleMapMarkers.values),
              zoomControlsEnabled: false,
            ),
    );
  }

  void _goTo(LatLng points) async {
    final CameraPosition _kLocation = CameraPosition(
        bearing: 0,
        target: LatLng(
          points.latitude,
          points.longitude,
        ),
        zoom: 16.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _mapController.googleMapController = controller;
    // zoom in to the selected camera position
    if (_mainController.userLatLng != null) {
      _goTo(_mainController.userLatLng);
      _mapController.getNearByPlaces();
    }
  }

  Widget buildBottomNavigationBar() {
    return GetBuilder<MapController>(
      builder: (controller) => Visibility(
        visible: _mapController.selectedMarkersId.isNotEmpty,
        child: Container(
          padding: EdgeInsetsDirectional.only(bottom: 10, start: 10, end: 10),
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            height: 50,
            child: CustomButton(
              text: 'continueToOrders'.tr,
              colorText: Colors.white,
              fontSize: fontSize16,
              radius: 0,
              colorBackground: kPrimaryColor,
              onPressed: () async {
                //you must login
                if (LocalStorage().getBool(LocalStorage.loginKey)) {
                  List<Mosque> mosques =
                      _mapController.getSelectedPlacesAsMosques();
                  if (mosques.isEmpty) {
                    CommonMethods()
                        .showToast(message: 'Select First',);
                    return;
                  } else {
                    await Get.to(() => CreateOrderScreen(
                        mosques: mosques, category: widget.category));
                    Get.find<CreateOrderController>().orderMap.clear();
                  }
                } else {
                  CommonMethods()
                      .showToast(message: 'youMustLogin'.tr,);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() async {
    super.dispose();
    if (controller != null) controller.dispose();
  }

  void _drawSearchPlace(
    String placeId,
  ) async {
    CustomMarker customMarker = await MapApi().getPlaceDetails(placeId);

    if (customMarker != null) {
      Marker newMarker = _mapController.createMarker(customMarker);

      if (_mapController.lastSearchMarkerId == null) {
        _mapController.lastSearchMarkerId = newMarker.markerId;
      } else {
        _mapController.googleMapMarkers.removeWhere(
            (key, value) => key == _mapController.lastSearchMarkerId);
        _mapController.lastSearchMarkerId = newMarker.markerId;
      }

      setState(() {
        _mapController.googleMapMarkers.addAll({
          newMarker.markerId: newMarker,
        });
      });
      _goTo(LatLng(customMarker.lat, customMarker.lng));

      Future.delayed(Duration(milliseconds: 500), () {
        controller.showMarkerInfoWindow(newMarker.markerId);
      });
    } else {
      // no marker
    }
  }

  _myLocationIcon() => GetBuilder<MapController>(
        builder: (controller) => Visibility(
          visible: _mainController.userLatLng != null,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 100, start: 10),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                    ),
                    color: kPrimaryColor,
                    onPressed: () {
                      _goTo(_mainController.userLatLng);
                    }),
              ),
            ),
          ),
        ),
      );

  _openSelectedPlaces() => GetBuilder<MapController>(
        builder: (controller) => Visibility(
          visible: _mapController.selectedMarkersId.isNotEmpty,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 150, start: 10),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: FocusedMenuHolder(
                blurBackgroundColor: Colors.black,
                openWithTap: true,
                onPressed: () {},
                menuItems: _mapController.getMenuItems(),
                menuOffset: 10,
                menuWidth: MediaQuery.of(context).size.width - 50,
                duration: Duration(milliseconds: 900),
                // blurSize: 0,
                // menuItemExtent: 80, //item height
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
