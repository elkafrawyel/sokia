import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sokia_app/helper/Constant.dart';
import 'package:sokia_app/helper/custom_widgets/custom_button.dart';
import 'package:sokia_app/screens/map/components/search_view.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.421512, -122.084101), zoom: 15.151926040649414);

  final List<MyLocation> locations = [
    MyLocation(
        id: '1',
        title: 'mountain-view',
        lat: 37.421512,
        lng: -122.084101,
        isSelected: false),
    MyLocation(
        id: '2',
        title: 'san-bruno',
        lat: 37.62816,
        lng: -122.426491,
        isSelected: false),
    MyLocation(
        id: '3',
        title: 'san-francisco',
        lat: 37.789972,
        lng: -122.390013,
        isSelected: false),
    MyLocation(
        id: '4',
        title: 'sunnyvale',
        lat: 37.403694,
        lng: -122.031583,
        isSelected: false),
  ];

  Set<Marker> _buildMarkers() {
    return locations.map((location) {
      return Marker(
          markerId: MarkerId(location.id),
          position: LatLng(location.lat, location.lng),
          icon: location.isSelected
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
              : BitmapDescriptor.defaultMarker,
          consumeTapEvents: true,
          infoWindow: InfoWindow(
            title: location.title,
          ),
          draggable: false,
          onTap: () {
            setState(() {
              setState(() {
                location.isSelected = !location.isSelected;
              });
            });
          });
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (argument) {
              print('You Tabbed on : $argument');
            },
            markers: _buildMarkers(),
            zoomControlsEnabled: false,
          ),
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SearchGoogleMap(
              onSearchTapped: (value) {
                _goTo(LatLng(30.948492, 31.179745));
              },
              onSubmitted: (value) {
                _goTo(LatLng(30.948492, 31.179745));
              },
            ),
          ),
          PositionedDirectional(
            bottom: 20,
            start: 10,
            end: 10,
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
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  void _goTo(LatLng points) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition _kLocation = CameraPosition(
        target: LatLng(
          points.latitude,
          points.longitude,
        ),
        zoom: 15.151926040649414);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }
}

class MyLocation {
  String id, title;
  double lat, lng;
  bool isSelected;

  MyLocation({this.id, this.title, this.lat, this.lng, this.isSelected});
}
