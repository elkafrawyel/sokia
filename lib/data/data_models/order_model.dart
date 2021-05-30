import 'package:flutter/material.dart';
import 'package:sokia_app/data/data_models/search_model.dart';
import 'package:sokia_app/data/responses/home_response.dart';

class OrderModel {
  SearchModel searchModel;

  String workerName;
  String workerNumber;
  List<OrderCategories> orderCategories;

  double get orderPrice {
    double price =0.0;
    orderCategories.forEach((element) {
      price += (element.count * element.category.categoryPrice).toDouble();
    });

    return price;
  }

  OrderModel({
    @required this.searchModel,
    @required this.orderCategories,
    this.workerName,
    this.workerNumber,
  });

  @override
  String toString() {
    return 'OrderModel{orderCategories: $orderCategories, price: $orderPrice}';
  }
}

class OrderCategories {
  Category category;
  int count;

  OrderCategories(
    this.category,
    this.count,
  );

  double categoryPrice() {
    double boxPrice = category.categoryPrice;
    return (count * boxPrice).toDouble();
  }

  @override
  String toString() {
    return 'OrderCategory{,price: ${categoryPrice()}}';
  }
}
