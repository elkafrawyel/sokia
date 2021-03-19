import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  final List<MyLocation> locations = [
    MyLocation(
        id: '1',
        title: 'Queen Of Peace School',
        address:
            'Al Mahallah Al Kobra - Kafr Hegazy, Kafr Hegazy, El Mahalla El Kubra, Gharbia Governorate',
        lat: 30.949780185265226,
        lng: 31.184251479085507,
        isSelected: false),
    MyLocation(
        id: '2',
        address:
            'Al Mahallah Al Kobra - Kafr Hegazy, Kafr Hegazy, El Mahalla El Kubra, Gharbia Governorate',
        title: 'Mahala Shooting club',
        lat: 30.94886005612807,
        lng: 31.178887061141886,
        isSelected: false),
    MyLocation(
        id: '3',
        address:
            'Al Mahalah Al Kubra (Part 2), El Mahalla El Kubra, Gharbia Governorate',
        title: 'LALA LAND RESTAURANT',
        lat: 30.959643412944693,
        lng: 31.188543013440416,
        isSelected: false),
  ];


}

class MyLocation {
  String id, title, address;
  double lat, lng;
  bool isSelected;

  MyLocation(
      {this.id, this.title, this.address, this.lat, this.lng, this.isSelected});
}
