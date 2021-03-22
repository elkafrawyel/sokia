import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sokia_app/api/logging_interceptor.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/helper/map_helper/auto_complete_response.dart';
import 'package:sokia_app/helper/map_helper/custom_marker.dart';
import 'package:sokia_app/helper/map_helper/near_by_places_response.dart';
import 'package:sokia_app/helper/map_helper/search_place_model.dart';
import 'package:sokia_app/helper/map_helper/single_place_response.dart';

class MapApi {
  final String _placesKey = 'AIzaSyAlD-AjHc-bdnyomHFsHtlkXy8gO_neVgg';
  var language = LocalStorage().getLanguage();
  var sessionToken = '1234567890';

  Dio _getDioClient() {
    BaseOptions options = new BaseOptions(
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
      },
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    Dio _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());

    return _dio;
  }

  Future<List<CustomMarker>> getNearByPlaces({
    String lat,
    String lng,
  }) async {
    String _baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    String location = '$lat,$lng';
    String radius = '10000'; //max is 50 000 meters
    String type = 'mosque';
    String mUrl =
        '$_baseUrl?&location=$location&radius=$radius&type=$type&key=$_placesKey&language=$language&sessiontoken=$sessionToken';

    Response response = await _getDioClient().get(mUrl);

    NearByPlacesResponse nearByPlacesResponse =
        NearByPlacesResponse.fromJson(response.data);

    if (nearByPlacesResponse.status == "OK") {
      List<CustomMarker> markersList = nearByPlacesResponse.results
          .map(
            (e) => CustomMarker(
              placeId: e.placeId,
              name: e.name,
              formattedAddress: e.vicinity,
              lat: e.geometry.location.lat,
              lng: e.geometry.location.lng,
              isSelected: false,
            ),
          )
          .toList();
      print('search result size : ${markersList.length}');
      return markersList;
    } else {
      return [];
    }
  }

  Future<List<SearchPlaceModel>> searchForPlaces(String input) async {
    String _baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = 'address';

    String mUrl =
        '$_baseUrl?input=$input&types=$type&key=$_placesKey&language=$language&sessiontoken=$sessionToken';

    Response response = await _getDioClient().get(mUrl);

    AutoCompleteResponse autoCompleteResponse =
        AutoCompleteResponse.fromJson(response.data);

    if (autoCompleteResponse.status == "OK") {
      List<SearchPlaceModel> places = autoCompleteResponse.predictions
          .map((e) => SearchPlaceModel(
              placeId: e.placeId, placeDescription: e.description))
          .toList();
      print('search result size : ${places.length}');
      return places;
    } else {
      return [];
    }
  }

  Future<CustomMarker> getPlaceDetails(String placeId) async {
    String _baseUrl = 'https://maps.googleapis.com/maps/api/place/details/json';
    String fields = 'name,geometry,formatted_address,place_id';
    String mUrl =
        '$_baseUrl?place_id=$placeId&fields=$fields&key=$_placesKey&language=$language';

    Response response = await _getDioClient().get(mUrl);

    SinglePlaceResponse singlePlaceResponse =
        SinglePlaceResponse.fromJson(response.data);
    if (singlePlaceResponse.status == "OK") {
      print('Place name : ${singlePlaceResponse.result.name}');
      CustomMarker customMarker = CustomMarker(
        placeId: singlePlaceResponse.result.placeId,
        name: singlePlaceResponse.result.name,
        formattedAddress: singlePlaceResponse.result.formattedAddress,
        lat: singlePlaceResponse.result.geometry.location.lat,
        lng: singlePlaceResponse.result.geometry.location.lng,
        isSelected: false,
      );
      return customMarker;
    } else {
      return null;
    }
  }
}

// OK
// ZERO_RESULTS
// OVER_QUERY_LIMIT
// REQUEST_DENIED
// INVALID_REQUEST
// UNKNOWN_ERROR
