import 'package:flutter/material.dart';
import 'package:sokia_app/data/responses/home_response.dart';

class OrderModel {
  Mosque mosque;
  Category category;
  String workerName;
  String workerNumber;
  int count;
  double price;

  double get orderPrice {
    double boxPrice = category.categoryPrice;
    price = (count * boxPrice).toDouble();

    return price;
  }

  OrderModel({
    @required this.mosque,
    @required this.category,
    this.workerName,
    this.workerNumber,
    @required this.count,
  });

  @override
  String toString() {
    return '${mosque.mosqueName} - ${category.categoryName} - $count - $workerName - $workerNumber';
  }
}
