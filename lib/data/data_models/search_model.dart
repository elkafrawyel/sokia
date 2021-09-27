import 'package:get/get.dart';

class SearchModel {
  int id;
  String name;
  String image;
  String adress;
  bool availableFastShipping;
  bool open;
  String longitude;
  String latitude;

  String get status => open ? 'opened'.tr : 'closed'.tr;


  String fastShipping() => availableFastShipping
      ? 'availableFastShipping'.tr
      : 'notAvailableFastShipping'.tr;

  SearchModel(this.id, this.name, this.image, this.adress,
      this.availableFastShipping, this.open, this.longitude, this.latitude);


}
