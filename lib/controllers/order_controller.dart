import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokia_app/data/responses/home_response.dart';

class OrderController extends GetxController {
  Map<int, OrderModel> orderMap = {};
  bool cash = true;
  double fee = 20.0;
  double shipping = 30.0;
  double totalPriceForAllOrders = 0.0;
  double totalPrice = 0.0;



  addToOrderMap({OrderModel orderModel}) {
    orderMap.addAll({
      orderModel.mosque.id: orderModel,
    });
    print('add' + orderMap.toString());

    calculatePrices();

    update();
  }

  updateOrderMap({OrderModel orderModel}) {
    orderMap[orderModel.mosque.id] = orderModel;
    print('update' + orderMap.toString());
    calculatePrices();

    update();
  }

  calculatePrices() {
    totalPrice = 0.0;
    totalPriceForAllOrders = 0.0;
    orderMap.values.forEach((element) {
      totalPrice += element.orderPrice;
    });

    totalPriceForAllOrders = totalPrice + fee + shipping;
  }

  String priceWithCurrency(double price) {

    return '${price.toStringAsFixed(2)} ' + 'currency'.tr;
  }

  changePaymentMethod(bool isCash) {
    cash = isCash;
    update();
  }
}

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
